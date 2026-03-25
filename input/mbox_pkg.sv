//=============================================================================
// Package: mbox_pkg
// Description: Types, constants, and register map for the mbox_ctrl module.
//=============================================================================
package mbox_pkg;

  // -------------------------------------------------------------------------
  // Widths
  // -------------------------------------------------------------------------
  localparam int DATA_W   = 32;
  localparam int FIFO_DEP = 8;
  localparam int FIFO_PTR = 3; // $clog2(FIFO_DEP) = 3

  // -------------------------------------------------------------------------
  // Register map (12-bit byte address)
  // -------------------------------------------------------------------------
  localparam logic [11:0] REG_CTRL     = 12'h000; // Control          (RW)
  localparam logic [11:0] REG_STATUS   = 12'h004; // Status           (RO)
  localparam logic [11:0] REG_CMD      = 12'h008; // Command opcode   (RW)
  localparam logic [11:0] REG_IRQ_MASK = 12'h00C; // IRQ enable mask  (RW)
  localparam logic [11:0] REG_XFER_CNT = 12'h010; // Transfer count   (RW, lock-protected)
  localparam logic [11:0] REG_SRC_ADDR = 12'h014; // Source address   (RW, lock-protected)
  localparam logic [11:0] REG_DST_ADDR = 12'h018; // Dest address     (RW, lock-protected)
  localparam logic [11:0] REG_LOCK     = 12'h01C; // Config lock      (W1S)
  localparam logic [11:0] REG_FIFO_IN  = 12'h020; // FIFO push port   (WO)
  localparam logic [11:0] REG_FIFO_OUT = 12'h024; // FIFO pop port    (RO)
  localparam logic [11:0] REG_ERR_CODE = 12'h028; // First error code (RO, sticky)

  // -------------------------------------------------------------------------
  // CTRL register bit positions
  // -------------------------------------------------------------------------
  localparam int CTRL_EN    = 0; // Controller enable
  localparam int CTRL_START = 1; // Start transfer (self-clearing after 1 cycle)
  localparam int CTRL_CLR   = 2; // Clear done/error status (self-clearing)

  // -------------------------------------------------------------------------
  // STATUS register bit positions
  // -------------------------------------------------------------------------
  localparam int STS_BUSY      = 0; // Transfer in progress
  localparam int STS_DONE      = 1; // Transfer completed successfully
  localparam int STS_ERROR     = 2; // Transfer ended with error
  localparam int STS_FIFO_FULL = 3; // FIFO is full
  localparam int STS_FIFO_EMPT = 4; // FIFO is empty
  localparam int STS_LOCKED    = 5; // Config registers are locked

  // -------------------------------------------------------------------------
  // IRQ mask register bit positions
  // -------------------------------------------------------------------------
  localparam int IRQ_DONE  = 0; // Enable IRQ on transfer done
  localparam int IRQ_ERROR = 1; // Enable IRQ on transfer error

  // -------------------------------------------------------------------------
  // Error codes (stored in REG_ERR_CODE[7:0] — first error is sticky)
  // -------------------------------------------------------------------------
  localparam logic [7:0] ERR_NONE      = 8'h00;
  localparam logic [7:0] ERR_OVERFLOW  = 8'h01; // Push to full FIFO
  localparam logic [7:0] ERR_UNDERFLOW = 8'h02; // Pop from empty FIFO
  localparam logic [7:0] ERR_PARITY    = 8'h03; // Parity mismatch on FIFO pop
  localparam logic [7:0] ERR_TIMEOUT   = 8'h04; // Transfer did not complete in time
  localparam logic [7:0] ERR_ILLEGAL   = 8'h05; // Start with xfer_cnt == 0

  // -------------------------------------------------------------------------
  // FSM state encoding (binary, 3-bit)
  // -------------------------------------------------------------------------
  typedef enum logic [2:0] {
    ST_IDLE  = 3'd0, // Waiting for start
    ST_ARMED = 3'd1, // One-cycle setup: latching transfer parameters
    ST_XFER  = 3'd2, // Transfer in progress, counting down remaining_cnt
    ST_DONE  = 3'd3, // Transfer completed; waiting for software CLR
    ST_ERROR = 3'd4  // Error occurred; waiting for software CLR
  } state_t;

endpackage : mbox_pkg
