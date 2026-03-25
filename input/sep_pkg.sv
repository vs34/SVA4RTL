//==============================================================================
// Module: sep_mailbox
// Description: Mailbox for Host ↔ SEP Communication
//
// This module implements a bidirectional mailbox for communication between
// the host CPU and the SEP. It provides:
// - 256-bit data buffer (8 × 32-bit registers)
// - Command/status registers
// - Interrupt generation (host_irq, sep_irq)
// - Handshake protocol
//
// Author: AMSIS Team
// Date: 2025-11-29
// Version: 2.0
//==============================================================================

module sep_mailbox
    import sep_pkg::*;
(
    input  logic                  clk,
    input  logic                  rst_n,
    
    // SEP Interface (APB-like)
    input  logic                  i_sep_req,
    input  logic                  i_sep_write,
    input  logic [11:0]           i_sep_addr,
    input  logic [DATA_WIDTH-1:0] i_sep_wdata,
    output logic [DATA_WIDTH-1:0] o_sep_rdata,
    output logic                  o_sep_ready,
    
    // Host Interface (memory-mapped)
    input  logic                  i_host_req,
    input  logic                  i_host_write,
    input  logic [11:0]           i_host_addr,
    input  logic [DATA_WIDTH-1:0] i_host_wdata,
    output logic [DATA_WIDTH-1:0] o_host_rdata,
    output logic                  o_host_ready,
    
    // Interrupts
    output logic                  o_host_irq,
    output logic                  o_sep_irq
);

    //==========================================================================
    // Mailbox Registers
    //==========================================================================
    
    // Data buffer (8 × 32-bit = 256 bits)
    logic [DATA_WIDTH-1:0] mbox_data [8];
    
    // Command register
    logic [DATA_WIDTH-1:0] mbox_cmd;
    
    // Status register
    typedef struct packed {
        logic [28:0] rsvd;
        logic        error;
        logic        done;
        logic        busy;
    } mbox_status_t;
    
    mbox_status_t mbox_sts;
    
    //==========================================================================
    // SEP Register Access
    //==========================================================================
    
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            mbox_cmd <= '0;
            mbox_sts <= '0;
            for (int i = 0; i < 8; i++) begin
                mbox_data[i] <= '0;
            end
            o_sep_rdata <= '0;
            o_sep_ready <= 1'b0;
        end else begin
            o_sep_ready <= 1'b0;
            
            if (i_sep_req) begin
                o_sep_ready <= 1'b1;
                
                if (i_sep_write) begin
                    // SEP writes
                    case (i_sep_addr)
                        MBOX_CMD_OFFSET: begin
                            mbox_cmd <= i_sep_wdata;
                            mbox_sts.busy <= 1'b1;
                        end
                        MBOX_DATA0_OFFSET: mbox_data[0] <= i_sep_wdata;
                        MBOX_DATA1_OFFSET: mbox_data[1] <= i_sep_wdata;
                        MBOX_DATA2_OFFSET: mbox_data[2] <= i_sep_wdata;
                        MBOX_DATA3_OFFSET: mbox_data[3] <= i_sep_wdata;
                        MBOX_DATA4_OFFSET: mbox_data[4] <= i_sep_wdata;
                        MBOX_DATA5_OFFSET: mbox_data[5] <= i_sep_wdata;
                        MBOX_DATA6_OFFSET: mbox_data[6] <= i_sep_wdata;
                        MBOX_DATA7_OFFSET: mbox_data[7] <= i_sep_wdata;
                        MBOX_STS_OFFSET: begin
                            // Write to status clears done/error flags
                            if (i_sep_wdata[MBOX_STS_DONE])
                                mbox_sts.done <= 1'b0;
                            if (i_sep_wdata[MBOX_STS_ERROR])
                                mbox_sts.error <= 1'b0;
                        end
                    endcase
                end else begin
                    // SEP reads
                    case (i_sep_addr)
                        MBOX_CMD_OFFSET:   o_sep_rdata <= mbox_cmd;
                        MBOX_DATA0_OFFSET: o_sep_rdata <= mbox_data[0];
                        MBOX_DATA1_OFFSET: o_sep_rdata <= mbox_data[1];
                        MBOX_DATA2_OFFSET: o_sep_rdata <= mbox_data[2];
                        MBOX_DATA3_OFFSET: o_sep_rdata <= mbox_data[3];
                        MBOX_DATA4_OFFSET: o_sep_rdata <= mbox_data[4];
                        MBOX_DATA5_OFFSET: o_sep_rdata <= mbox_data[5];
                        MBOX_DATA6_OFFSET: o_sep_rdata <= mbox_data[6];
                        MBOX_DATA7_OFFSET: o_sep_rdata <= mbox_data[7];
                        MBOX_STS_OFFSET:   o_sep_rdata <= {29'd0, mbox_sts};
                        default:           o_sep_rdata <= '0;
                    endcase
                end
            end
        end
    end
    
    //==========================================================================
    // Host Register Access
    //==========================================================================
    
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            o_host_rdata <= '0;
            o_host_ready <= 1'b0;
        end else begin
            o_host_ready <= 1'b0;
            
            if (i_host_req) begin
                o_host_ready <= 1'b1;
                
                if (i_host_write) begin
                    // Host writes
                    case (i_host_addr)
                        MBOX_CMD_OFFSET: begin
                            mbox_cmd <= i_host_wdata;
                            mbox_sts.busy <= 1'b1;
                        end
                        MBOX_DATA0_OFFSET: mbox_data[0] <= i_host_wdata;
                        MBOX_DATA1_OFFSET: mbox_data[1] <= i_host_wdata;
                        MBOX_DATA2_OFFSET: mbox_data[2] <= i_host_wdata;
                        MBOX_DATA3_OFFSET: mbox_data[3] <= i_host_wdata;
                        MBOX_DATA4_OFFSET: mbox_data[4] <= i_host_wdata;
                        MBOX_DATA5_OFFSET: mbox_data[5] <= i_host_wdata;
                        MBOX_DATA6_OFFSET: mbox_data[6] <= i_host_wdata;
                        MBOX_DATA7_OFFSET: mbox_data[7] <= i_host_wdata;
                        MBOX_STS_OFFSET: begin
                            // Host can set done/error flags
                            if (i_host_wdata[MBOX_STS_DONE]) begin
                                mbox_sts.done <= 1'b1;
                                mbox_sts.busy <= 1'b0;
                            end
                            if (i_host_wdata[MBOX_STS_ERROR]) begin
                                mbox_sts.error <= 1'b1;
                                mbox_sts.busy <= 1'b0;
                            end
                        end
                    endcase
                end else begin
                    // Host reads
                    case (i_host_addr)
                        MBOX_CMD_OFFSET:   o_host_rdata <= mbox_cmd;
                        MBOX_DATA0_OFFSET: o_host_rdata <= mbox_data[0];
                        MBOX_DATA1_OFFSET: o_host_rdata <= mbox_data[1];
                        MBOX_DATA2_OFFSET: o_host_rdata <= mbox_data[2];
                        MBOX_DATA3_OFFSET: o_host_rdata <= mbox_data[3];
                        MBOX_DATA4_OFFSET: o_host_rdata <= mbox_data[4];
                        MBOX_DATA5_OFFSET: o_host_rdata <= mbox_data[5];
                        MBOX_DATA6_OFFSET: o_host_rdata <= mbox_data[6];
                        MBOX_DATA7_OFFSET: o_host_rdata <= mbox_data[7];
                        MBOX_STS_OFFSET:   o_host_rdata <= {29'd0, mbox_sts};
                        default:           o_host_rdata <= '0;
                    endcase
                end
            end
        end
    end
    
    //==========================================================================
    // Interrupt Generation
    //==========================================================================
    
    // Host interrupt: asserted when SEP sets done/error
    assign o_host_irq = mbox_sts.done || mbox_sts.error;
    
    // SEP interrupt: asserted when host writes command
    assign o_sep_irq = mbox_sts.busy && (mbox_cmd != '0);
    
    //==========================================================================
    // Assertions
    //==========================================================================
    
    `ifdef FORMAL
    // Busy should be cleared when done or error is set
    assert property (@(posedge clk) disable iff (!rst_n)
        (mbox_sts.done || mbox_sts.error) |-> !mbox_sts.busy
    );
    
    // Done and error should be mutually exclusive
    assert property (@(posedge clk) disable iff (!rst_n)
        !(mbox_sts.done && mbox_sts.error)
    );
    
    `endif

endmodule : sep_mailbox
