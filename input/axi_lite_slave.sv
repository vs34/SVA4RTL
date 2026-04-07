// axi_lite_slave.sv — AXI4-Lite slave with 4 memory-mapped registers
// Supports single-beat read and write transactions.
// Write response always OKAY. Read data registered for timing closure.

module axi_lite_slave #(
    parameter int unsigned ADDR_WIDTH = 12,
    parameter int unsigned DATA_WIDTH = 32
) (
    input  logic                    clk,
    input  logic                    rst_n,

    // --- Write address channel ---
    input  logic [ADDR_WIDTH-1:0]   s_awaddr,
    input  logic [2:0]              s_awprot,
    input  logic                    s_awvalid,
    output logic                    s_awready,

    // --- Write data channel ---
    input  logic [DATA_WIDTH-1:0]   s_wdata,
    input  logic [DATA_WIDTH/8-1:0] s_wstrb,
    input  logic                    s_wvalid,
    output logic                    s_wready,

    // --- Write response channel ---
    output logic [1:0]              s_bresp,
    output logic                    s_bvalid,
    input  logic                    s_bready,

    // --- Read address channel ---
    input  logic [ADDR_WIDTH-1:0]   s_araddr,
    input  logic [2:0]              s_arprot,
    input  logic                    s_arvalid,
    output logic                    s_arready,

    // --- Read data channel ---
    output logic [DATA_WIDTH-1:0]   s_rdata,
    output logic [1:0]              s_rresp,
    output logic                    s_rvalid,
    input  logic                    s_rready
);

    // -----------------------------------------------------------------------
    // Register file (4 x 32-bit registers at offsets 0x00, 0x04, 0x08, 0x0C)
    // -----------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] reg_ctrl;    // 0x00 — control register
    logic [DATA_WIDTH-1:0] reg_status;  // 0x04 — status  (read-only)
    logic [DATA_WIDTH-1:0] reg_data0;   // 0x08 — data register 0
    logic [DATA_WIDTH-1:0] reg_data1;   // 0x0C — data register 1

    // -----------------------------------------------------------------------
    // Write FSM  (states: WR_IDLE → WR_ADDR → WR_DATA → WR_RESP → WR_IDLE)
    // -----------------------------------------------------------------------
    typedef enum logic [1:0] {
        WR_IDLE = 2'b00,
        WR_ADDR = 2'b01,
        WR_DATA = 2'b10,
        WR_RESP = 2'b11
    } wr_state_t;

    wr_state_t wr_state, wr_state_next;
    logic [ADDR_WIDTH-1:0] wr_addr_lat;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) wr_state <= WR_IDLE;
        else        wr_state <= wr_state_next;
    end

    always_comb begin
        wr_state_next = wr_state;
        case (wr_state)
            WR_IDLE: if (s_awvalid)                        wr_state_next = WR_ADDR;
            WR_ADDR: if (s_wvalid)                         wr_state_next = WR_DATA;
            WR_DATA:                                        wr_state_next = WR_RESP;
            WR_RESP: if (s_bready)                         wr_state_next = WR_IDLE;
            default:                                        wr_state_next = WR_IDLE;
        endcase
    end

    assign s_awready = (wr_state == WR_IDLE);
    assign s_wready  = (wr_state == WR_ADDR);
    assign s_bvalid  = (wr_state == WR_RESP);
    assign s_bresp   = 2'b00; // OKAY

    // Latch write address
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) wr_addr_lat <= '0;
        else if (wr_state == WR_IDLE && s_awvalid)
            wr_addr_lat <= s_awaddr;
    end

    // Register write
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_ctrl  <= '0;
            reg_data0 <= '0;
            reg_data1 <= '0;
        end else if (wr_state == WR_ADDR && s_wvalid) begin
            case (wr_addr_lat[3:2])
                2'h0: reg_ctrl  <= s_wdata;
                2'h2: reg_data0 <= s_wdata;
                2'h3: reg_data1 <= s_wdata;
                default: ; // 0x04 = status is read-only
            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Read FSM  (states: RD_IDLE → RD_DATA → RD_IDLE)
    // -----------------------------------------------------------------------
    typedef enum logic {
        RD_IDLE = 1'b0,
        RD_DATA = 1'b1
    } rd_state_t;

    rd_state_t rd_state, rd_state_next;
    logic [ADDR_WIDTH-1:0] rd_addr_lat;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) rd_state <= RD_IDLE;
        else        rd_state <= rd_state_next;
    end

    always_comb begin
        rd_state_next = rd_state;
        case (rd_state)
            RD_IDLE: if (s_arvalid)  rd_state_next = RD_DATA;
            RD_DATA: if (s_rready)   rd_state_next = RD_IDLE;
            default:                 rd_state_next = RD_IDLE;
        endcase
    end

    assign s_arready = (rd_state == RD_IDLE);
    assign s_rvalid  = (rd_state == RD_DATA);
    assign s_rresp   = 2'b00; // OKAY

    // Latch read address
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) rd_addr_lat <= '0;
        else if (rd_state == RD_IDLE && s_arvalid)
            rd_addr_lat <= s_araddr;
    end

    // Read data mux
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_rdata   <= '0;
            reg_status <= 32'hDEAD_C0DE; // example hw-driven status
        end else begin
            reg_status <= {28'b0, wr_state, rd_state}; // expose FSM state in status reg
            if (rd_state == RD_IDLE && s_arvalid) begin
                case (s_araddr[3:2])
                    2'h0: s_rdata <= reg_ctrl;
                    2'h1: s_rdata <= reg_status;
                    2'h2: s_rdata <= reg_data0;
                    2'h3: s_rdata <= reg_data1;
                    default: s_rdata <= '0;
                endcase
            end
        end
    end

endmodule
