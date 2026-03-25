//=============================================================================
// Module: mbox_ctrl
// Description: Mailbox DMA-lite controller with APB-like register interface.
//
// Features:
//   - 5-state FSM: IDLE → ARMED → XFER → DONE / ERROR
//   - 8-entry FIFO with even-parity error detection
//   - Transfer countdown counter (remaining_cnt)
//   - Timeout watchdog (fires if XFER takes > TIMEOUT_CYCLES cycles)
//   - Write-1-to-set config lock (xfer_cnt, src_addr, dst_addr are protected)
//   - Masked interrupts: separate done and error IRQ enables
//   - Sticky first-error code register
//   - Clock-gate hint output: high when controller is idle
//
// Interface:
//   APB-like single-cycle address/data with 1-cycle ready response.
//   i_req asserted for one cycle. o_ready asserted the following cycle.
//=============================================================================
module mbox_ctrl
  import mbox_pkg::*;
#(
  parameter int TIMEOUT_CYCLES = 64
)(
  input  logic        clk,
  input  logic        rst_n,

  // APB-like register interface
  input  logic        i_req,
  input  logic        i_write,
  input  logic [11:0] i_addr,
  input  logic [31:0] i_wdata,
  output logic [31:0] o_rdata,
  output logic        o_ready,

  // Interrupt output (level, active-high)
  output logic        o_irq,

  // Clock-gate hint: high when controller is idle (safe to gate clock)
  output logic        o_clk_gate_en
);

  // -------------------------------------------------------------------------
  // Local parameters
  // -------------------------------------------------------------------------
  localparam int TOUT_W = 7; // $clog2(TIMEOUT_CYCLES + 1) for TIMEOUT_CYCLES=64

  // -------------------------------------------------------------------------
  // Soft registers
  // -------------------------------------------------------------------------
  logic [31:0] r_ctrl;       // [EN, START(self-clr), CLR(self-clr)]
  logic [31:0] r_cmd;        // Command opcode (informational)
  logic [31:0] r_irq_mask;   // [DONE_EN, ERROR_EN]
  logic [31:0] r_xfer_cnt;   // Transfer word count  (lock-protected)
  logic [31:0] r_src_addr;   // Source address       (lock-protected)
  logic [31:0] r_dst_addr;   // Destination address  (lock-protected)
  logic        r_lock;       // Config lock (W1S; cleared only by rst_n)
  logic [31:0] r_err_code;   // First-error code (sticky until rst_n)

  // -------------------------------------------------------------------------
  // FSM
  // -------------------------------------------------------------------------
  state_t state_q, state_d;

  // -------------------------------------------------------------------------
  // Transfer countdown counter
  // -------------------------------------------------------------------------
  logic [31:0] remaining_q;

  // -------------------------------------------------------------------------
  // Timeout counter
  // -------------------------------------------------------------------------
  logic [TOUT_W-1:0] timeout_q;
  logic              timeout_hit;

  // -------------------------------------------------------------------------
  // FIFO (8 entries, 32-bit data + 1 even-parity bit per entry)
  // -------------------------------------------------------------------------
  logic [31:0] fifo_data [FIFO_DEP];
  logic        fifo_pbit [FIFO_DEP]; // stored even-parity bit
  logic [3:0]  fifo_cnt;             // occupancy: 0..FIFO_DEP
  logic [2:0]  fifo_wr_ptr;          // next write slot
  logic [2:0]  fifo_rd_ptr;          // next read slot
  logic        fifo_full;
  logic        fifo_empty;
  logic        do_push;              // push accepted this cycle
  logic        do_pop;               // pop accepted this cycle
  logic        parity_err;           // parity mismatch detected on pop

  // -------------------------------------------------------------------------
  // Decoded status
  // -------------------------------------------------------------------------
  logic reg_wr, reg_rd;
  logic busy_s, done_s, error_s;

  assign reg_wr  = i_req & i_write;
  assign reg_rd  = i_req & ~i_write;
  assign busy_s  = (state_q == ST_ARMED) | (state_q == ST_XFER);
  assign done_s  = (state_q == ST_DONE);
  assign error_s = (state_q == ST_ERROR);

  // =========================================================================
  // FIFO
  // =========================================================================
  assign fifo_full  = (fifo_cnt == 4'd8);   // FIFO_DEP = 8
  assign fifo_empty = (fifo_cnt == 4'd0);

  // Push: host writes to REG_FIFO_IN and FIFO is not full
  assign do_push = reg_wr & (i_addr == REG_FIFO_IN) & ~fifo_full;

  // Pop: host reads from REG_FIFO_OUT and FIFO is not empty
  assign do_pop  = reg_rd & (i_addr == REG_FIFO_OUT) & ~fifo_empty;

  // Parity check: XOR of all data bits must equal the stored parity bit
  assign parity_err = do_pop & (^fifo_data[fifo_rd_ptr] != fifo_pbit[fifo_rd_ptr]);

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      fifo_cnt    <= 4'd0;
      fifo_wr_ptr <= 3'd0;
      fifo_rd_ptr <= 3'd0;
    end else begin
      // Push
      if (do_push) begin
        fifo_data[fifo_wr_ptr] <= i_wdata;
        fifo_pbit[fifo_wr_ptr] <= ^i_wdata; // compute even parity
        fifo_wr_ptr <= (fifo_wr_ptr == 3'd7) ? 3'd0 : fifo_wr_ptr + 3'd1;
      end
      // Pop
      if (do_pop) begin
        fifo_rd_ptr <= (fifo_rd_ptr == 3'd7) ? 3'd0 : fifo_rd_ptr + 3'd1;
      end
      // Count update (simultaneous push+pop = count unchanged)
      case ({do_push, do_pop})
        2'b10:   fifo_cnt <= fifo_cnt + 4'd1;
        2'b01:   fifo_cnt <= fifo_cnt - 4'd1;
        default: fifo_cnt <= fifo_cnt;
      endcase
    end
  end

  // =========================================================================
  // Timeout counter
  // =========================================================================
  assign timeout_hit = (timeout_q == TOUT_W'(TIMEOUT_CYCLES));

  always_ff @(posedge clk) begin
    if (!rst_n)
      timeout_q <= '0;
    else if (state_q == ST_XFER)
      timeout_q <= timeout_hit ? timeout_q : timeout_q + 1'b1;
    else
      timeout_q <= '0;
  end

  // =========================================================================
  // FSM next-state logic
  // =========================================================================
  always_comb begin
    state_d = state_q;
    case (state_q)
      ST_IDLE: begin
        if (r_ctrl[CTRL_EN] & r_ctrl[CTRL_START])
          state_d = (r_xfer_cnt == '0) ? ST_ERROR : ST_ARMED;
      end
      ST_ARMED: begin
        state_d = ST_XFER;
      end
      ST_XFER: begin
        if (timeout_hit)
          state_d = ST_ERROR;
        else if (remaining_q == 32'd1)
          state_d = ST_DONE;
      end
      ST_DONE: begin
        if (r_ctrl[CTRL_CLR]) state_d = ST_IDLE;
      end
      ST_ERROR: begin
        if (r_ctrl[CTRL_CLR]) state_d = ST_IDLE;
      end
      default: state_d = ST_IDLE;
    endcase
  end

  always_ff @(posedge clk) begin
    if (!rst_n) state_q <= ST_IDLE;
    else        state_q <= state_d;
  end

  // =========================================================================
  // Transfer countdown counter
  // =========================================================================
  always_ff @(posedge clk) begin
    if (!rst_n)
      remaining_q <= '0;
    else if (state_q == ST_ARMED)
      remaining_q <= r_xfer_cnt;
    else if (state_q == ST_XFER && remaining_q > '0)
      remaining_q <= remaining_q - 32'd1;
  end

  // =========================================================================
  // First-error code register (sticky: first error wins)
  // =========================================================================
  always_ff @(posedge clk) begin
    if (!rst_n) begin
      r_err_code <= '0;
    end else if (r_err_code[7:0] == ERR_NONE) begin
      if (parity_err)
        r_err_code <= {24'd0, ERR_PARITY};
      else if (reg_wr && (i_addr == REG_FIFO_IN) && fifo_full)
        r_err_code <= {24'd0, ERR_OVERFLOW};
      else if (reg_rd && (i_addr == REG_FIFO_OUT) && fifo_empty)
        r_err_code <= {24'd0, ERR_UNDERFLOW};
      else if (timeout_hit)
        r_err_code <= {24'd0, ERR_TIMEOUT};
      else if (r_ctrl[CTRL_EN] && r_ctrl[CTRL_START] && r_xfer_cnt == '0)
        r_err_code <= {24'd0, ERR_ILLEGAL};
    end
  end

  // =========================================================================
  // Soft register write logic
  // =========================================================================
  always_ff @(posedge clk) begin
    if (!rst_n) begin
      r_ctrl     <= '0;
      r_cmd      <= '0;
      r_irq_mask <= '0;
      r_xfer_cnt <= '0;
      r_src_addr <= '0;
      r_dst_addr <= '0;
      r_lock     <= 1'b0;
    end else begin
      // START and CLR are self-clearing: deassert every cycle unless actively written
      r_ctrl[CTRL_START] <= 1'b0;
      r_ctrl[CTRL_CLR]   <= 1'b0;

      if (reg_wr) begin
        case (i_addr)
          REG_CTRL: begin
            r_ctrl[CTRL_EN]    <= i_wdata[CTRL_EN];
            // START only accepted when not already busy
            if (!busy_s)
              r_ctrl[CTRL_START] <= i_wdata[CTRL_START];
            r_ctrl[CTRL_CLR]   <= i_wdata[CTRL_CLR];
          end
          REG_CMD:      r_cmd      <= i_wdata;
          REG_IRQ_MASK: r_irq_mask <= i_wdata;
          // Lock-protected: ignore writes when locked or while transfer is active
          REG_XFER_CNT: if (!r_lock && !busy_s) r_xfer_cnt <= i_wdata;
          REG_SRC_ADDR: if (!r_lock && !busy_s) r_src_addr <= i_wdata;
          REG_DST_ADDR: if (!r_lock && !busy_s) r_dst_addr <= i_wdata;
          // Lock register: write-1-to-set; only rst_n clears it
          REG_LOCK:     if (i_wdata[0]) r_lock <= 1'b1;
          default: ;
        endcase
      end
    end
  end

  // =========================================================================
  // Read data mux (registered, 1-cycle read latency)
  // =========================================================================
  logic [31:0] status_w;
  assign status_w = {
    26'd0,
    r_lock,       // bit 5
    fifo_empty,   // bit 4
    fifo_full,    // bit 3
    error_s,      // bit 2
    done_s,       // bit 1
    busy_s        // bit 0
  };

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      o_rdata <= '0;
    end else if (reg_rd) begin
      case (i_addr)
        REG_CTRL:     o_rdata <= r_ctrl;
        REG_STATUS:   o_rdata <= status_w;
        REG_CMD:      o_rdata <= r_cmd;
        REG_IRQ_MASK: o_rdata <= r_irq_mask;
        REG_XFER_CNT: o_rdata <= r_xfer_cnt;
        REG_SRC_ADDR: o_rdata <= r_src_addr;
        REG_DST_ADDR: o_rdata <= r_dst_addr;
        REG_LOCK:     o_rdata <= {31'd0, r_lock};
        REG_FIFO_OUT: o_rdata <= fifo_empty ? '0 : fifo_data[fifo_rd_ptr];
        REG_ERR_CODE: o_rdata <= r_err_code;
        default:      o_rdata <= '0;
      endcase
    end
  end

  // Ready: one cycle after req
  always_ff @(posedge clk) begin
    if (!rst_n) o_ready <= 1'b0;
    else        o_ready <= i_req;
  end

  // =========================================================================
  // IRQ (combinational level signal)
  // =========================================================================
  assign o_irq = (done_s  & r_irq_mask[IRQ_DONE]) |
                 (error_s & r_irq_mask[IRQ_ERROR]);

  // =========================================================================
  // Clock-gate hint (safe to gate the clock when idle)
  // =========================================================================
  assign o_clk_gate_en = (state_q == ST_IDLE);

endmodule : mbox_ctrl
