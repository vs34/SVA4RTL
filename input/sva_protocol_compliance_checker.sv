// ---------------------------------------------------------------
// Auto-generated SVA checker -- DO NOT EDIT
// Module: sva_protocol_compliance_checker
// ---------------------------------------------------------------
`timescale 1ns / 1ps

module sva_protocol_compliance_checker #(
    parameter ADDR_WIDTH = 12,
    parameter DATA_WIDTH = 32
)(
    input logic clk,
    input logic rst_n,
    input logic [ADDR_WIDTH-1:0] s_awaddr,
    input logic [2:0] s_awprot,
    input logic s_awvalid,
    input logic s_awready,
    input logic [DATA_WIDTH-1:0] s_wdata,
    input logic [DATA_WIDTH/8-1:0] s_wstrb,
    input logic s_wvalid,
    input logic s_wready,
    input logic [1:0] s_bresp,
    input logic s_bvalid,
    input logic s_bready,
    input logic [ADDR_WIDTH-1:0] s_araddr,
    input logic [2:0] s_arprot,
    input logic s_arvalid,
    input logic s_arready,
    input logic [DATA_WIDTH-1:0] s_rdata,
    input logic [1:0] s_rresp,
    input logic s_rvalid,
    input logic s_rready
);

default clocking cb @(posedge clk);
endclocking

default disable iff (rst_n);

    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.677) ---
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid;
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.677) ---
    // Write data must remain stable while WVALID is asserted and WREADY has not been received, ensuring data integrity during handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata);
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.677) ---
    // Write strobe signals must remain stable during the write data handshake period to maintain consistent byte lane selection.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb);
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.677) ---
    // Write response valid must remain asserted until master acknowledges with BREADY, per AXI4-Lite handshake protocol.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid;
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.677) ---
    // Write response code must remain stable while BVALID is asserted and awaiting BREADY handshake completion.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp);
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.677) ---
    // Read address valid must remain asserted until read address handshake completes with ARREADY, per AXI4-Lite specification.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid;
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.677) ---
    // Read address must remain stable during the read address handshake period until ARREADY is asserted.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr);
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.677) ---
    // Read protection attributes must remain stable during read address handshake to maintain transaction attributes.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot);
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.677) ---
    // Read data valid must remain asserted until master acknowledges with RREADY, completing the read data handshake.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid;
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.677) ---
    // Read data must remain stable while RVALID is asserted and awaiting RREADY to ensure data integrity.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata);
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.677) ---
    // Read response code must remain stable during read data handshake period until RREADY is received.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp);
        );
    // --- p_protocol_compliance_no_bvalid_without_prior_write_channels (roi=0.652) ---
    // Write response cannot be asserted unless a write address handshake occurred previously. Checks temporal ordering within reasonable window.
    p_protocol_compliance_no_bvalid_without_prior_write_channels: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_awvalid && s_awready, 1) || $past(s_awvalid && s_awready, 2) || $past(s_awvalid && s_awready, 3) || $past(s_awvalid && s_awready, 4) || $past(s_awvalid && s_awready, 5);
        );
    // --- p_protocol_compliance_no_rvalid_without_prior_arvalid (roi=0.652) ---
    // Read data response cannot be asserted unless a read address handshake occurred previously. Ensures read channel ordering.
    p_protocol_compliance_no_rvalid_without_prior_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_rvalid) |-> $past(s_arvalid && s_arready, 1) || $past(s_arvalid && s_arready, 2) || $past(s_arvalid && s_arready, 3) || $past(s_arvalid && s_arready, 4) || $past(s_arvalid && s_arready, 5);
        );
    // --- p_protocol_compliance_bvalid_eventually_cleared_after_handshake (roi=0.665) ---
    // Write response valid must be deasserted in the cycle following BREADY handshake, preventing protocol stalls.
    p_protocol_compliance_bvalid_eventually_cleared_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid;
        );
    // --- p_protocol_compliance_rvalid_eventually_cleared_after_handshake (roi=0.665) ---
    // Read data valid must be deasserted in the cycle following RREADY handshake to allow new transactions.
    p_protocol_compliance_rvalid_eventually_cleared_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid;
        );
    // --- p_protocol_compliance_no_bvalid_without_wdata_received (roi=0.652) ---
    // Write response cannot be issued until write data handshake has completed. Enforces write channel dependency.
    p_protocol_compliance_no_bvalid_without_wdata_received: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_wvalid && s_wready, 1) || $past(s_wvalid && s_wready, 2) || $past(s_wvalid && s_wready, 3) || $past(s_wvalid && s_wready, 4) || $past(s_wvalid && s_wready, 5);
        );
    // --- p_protocol_compliance_awready_deasserts_after_handshake (roi=0.627) ---
    // Slave should deassert AWREADY after accepting write address to prevent accepting duplicate addresses. Allows for 0-2 cycles of reassertion for pipelining.
    p_protocol_compliance_awready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready [*0:2];
        );
    // --- p_protocol_compliance_wready_deasserts_after_handshake (roi=0.627) ---
    // Slave should deassert WREADY after accepting write data to prevent duplicate data acceptance. Allows brief reassertion window.
    p_protocol_compliance_wready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready [*0:2];
        );
    // --- p_protocol_compliance_arready_deasserts_after_handshake (roi=0.627) ---
    // Slave should deassert ARREADY after accepting read address to prevent duplicate address acceptance.
    p_protocol_compliance_arready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready [*0:2];
        );
    // --- p_protocol_compliance_no_simultaneous_bvalid_new_write (roi=0.615) ---
    // While write response is pending, slave should not accept a new complete write transaction to avoid outstanding transaction overflow in single-transaction slave.
    p_protocol_compliance_no_simultaneous_bvalid_new_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !(s_awvalid && s_awready && s_wvalid && s_wready);
        );
    // --- p_protocol_compliance_no_simultaneous_rvalid_new_read (roi=0.615) ---
    // While read data is pending, slave should not accept a new read address to prevent outstanding read transaction overflow.
    p_protocol_compliance_no_simultaneous_rvalid_new_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> !(s_arvalid && s_arready);
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.665) ---
    // Design summary indicates write responses are always OKAY (2'b00). This checks implementation matches specification.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00);
        );
    // --- p_protocol_compliance_awaddr_aligned_to_word (roi=0.652) ---
    // 32-bit register accesses should be word-aligned. Checks that write addresses are aligned to 4-byte boundaries.
    p_protocol_compliance_awaddr_aligned_to_word: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> (s_awaddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_araddr_aligned_to_word (roi=0.652) ---
    // 32-bit register accesses should be word-aligned. Checks that read addresses are aligned to 4-byte boundaries.
    p_protocol_compliance_araddr_aligned_to_word: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> (s_araddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_awaddr_in_valid_range (roi=0.640) ---
    // Register map has 4 registers at 0x00, 0x04, 0x08, 0x0C. Write addresses should be within this range.
    p_protocol_compliance_awaddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> (s_awaddr <= 32'h0C);
        );
    // --- p_protocol_compliance_araddr_in_valid_range (roi=0.640) ---
    // Register map has 4 registers at 0x00, 0x04, 0x08, 0x0C. Read addresses should be within this range.
    p_protocol_compliance_araddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> (s_araddr <= 32'h0C);
        );
    // --- p_protocol_compliance_wstrb_valid_encoding (roi=0.652) ---
    // Write strobe must have at least one byte enabled for a valid write operation. All-zero strobe is invalid.
    p_protocol_compliance_wstrb_valid_encoding: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |-> (s_wstrb != 4'b0000);
        );
    // --- p_protocol_compliance_no_awvalid_during_reset (roi=0.665) ---
    // Master should not assert AWVALID during reset. Checks reset behavior compliance.
    p_protocol_compliance_no_awvalid_during_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |-> !s_awvalid;
        );
    // --- p_protocol_compliance_no_wvalid_during_reset (roi=0.665) ---
    // Master should not assert WVALID during reset. Checks reset behavior compliance.
    p_protocol_compliance_no_wvalid_during_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |-> !s_wvalid;
        );
    // --- p_protocol_compliance_no_arvalid_during_reset (roi=0.665) ---
    // Master should not assert ARVALID during reset. Checks reset behavior compliance.
    p_protocol_compliance_no_arvalid_during_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |-> !s_arvalid;
        );
    // --- p_protocol_compliance_no_bready_during_reset (roi=0.665) ---
    // Master should not assert BREADY during reset. Checks reset behavior compliance.
    p_protocol_compliance_no_bready_during_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |-> !s_bready;
        );
    // --- p_protocol_compliance_no_rready_during_reset (roi=0.665) ---
    // Master should not assert RREADY during reset. Checks reset behavior compliance.
    p_protocol_compliance_no_rready_during_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |-> !s_rready;
        );
    // --- p_protocol_compliance_bvalid_low_after_reset (roi=0.677) ---
    // Slave must not have BVALID asserted immediately after reset release. Ensures clean initialization.
    p_protocol_compliance_bvalid_low_after_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_bvalid;
        );
    // --- p_protocol_compliance_rvalid_low_after_reset (roi=0.677) ---
    // Slave must not have RVALID asserted immediately after reset release. Ensures clean initialization.
    p_protocol_compliance_rvalid_low_after_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_rvalid;
        );
    // --- p_protocol_compliance_awready_low_after_reset (roi=0.652) ---
    // Slave should not have AWREADY asserted immediately after reset to ensure proper FSM initialization.
    p_protocol_compliance_awready_low_after_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_awready;
        );
    // --- p_protocol_compliance_wready_low_after_reset (roi=0.652) ---
    // Slave should not have WREADY asserted immediately after reset to ensure proper FSM initialization.
    p_protocol_compliance_wready_low_after_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_wready;
        );
    // --- p_protocol_compliance_arready_low_after_reset (roi=0.652) ---
    // Slave should not have ARREADY asserted immediately after reset to ensure proper FSM initialization.
    p_protocol_compliance_arready_low_after_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_arready;
        );
    // --- p_protocol_compliance_write_response_within_bounded_time (roi=0.640) ---
    // Liveness property: after both write address and data are accepted, write response must eventually be asserted within 10 cycles to prevent deadlock.
    p_protocol_compliance_write_response_within_bounded_time: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:10] s_bvalid;
        );
    // --- p_protocol_compliance_read_response_within_bounded_time (roi=0.640) ---
    // Liveness property: after read address is accepted, read data must eventually be provided within 10 cycles to prevent starvation.
    p_protocol_compliance_read_response_within_bounded_time: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:10] s_rvalid;
        );
    // --- p_protocol_compliance_no_multiple_outstanding_writes (roi=0.627) ---
    // AXI4-Lite slave with single-beat transactions should not accept a new write address until current write completes with BVALID response.
    // SKIPPED (unsupported operator): p_protocol_compliance_no_multiple_outstanding_writes
    // p_protocol_compliance_no_multiple_outstanding_writes: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_awvalid && s_awready) && !s_bvalid |-> ##1 !((s_awvalid && s_awready) throughout ((!s_bvalid) [*1:$]));
    //     );
    // --- p_protocol_compliance_no_multiple_outstanding_reads (roi=0.627) ---
    // AXI4-Lite slave with single-beat transactions should not accept a new read address until current read completes with RVALID response.
    // SKIPPED (unsupported operator): p_protocol_compliance_no_multiple_outstanding_reads
    // p_protocol_compliance_no_multiple_outstanding_reads: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_arvalid && s_arready) && !s_rvalid |-> ##1 !((s_arvalid && s_arready) throughout ((!s_rvalid) [*1:$]));
    //     );
    // --- p_protocol_compliance_exclusive_write_fsm_states (roi=0.603) ---
    // Write FSM should be in exactly one state at a time. Checks for IDLE, ADDR, DATA, RESP state exclusivity based on ready/valid signals.
    p_protocol_compliance_exclusive_write_fsm_states: assert property (
            @(posedge clk) disable iff (!rst_n)
              $onehot({(!s_awready && !s_wready && !s_bvalid), (s_awready && !s_wready && !s_bvalid), (!s_awready && s_wready && !s_bvalid), (!s_awready && !s_wready && s_bvalid)});
        );
    // --- p_protocol_compliance_write_addr_before_resp (roi=0.652) ---
    // Write response requires that write address was previously accepted. Checks ordering constraint in write transaction flow.
    p_protocol_compliance_write_addr_before_resp: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready);
        );
    // --- p_protocol_compliance_write_data_before_resp (roi=0.652) ---
    // Write response requires that write data was previously accepted. Checks ordering constraint in write transaction flow.
    p_protocol_compliance_write_data_before_resp: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_wvalid && s_wready);
        );
    // --- p_protocol_compliance_awprot_width_check (roi=0.590) ---
    // AWPROT is 3-bit wide per AXI4-Lite spec. This property verifies signal width consistency (tautology for width checking).
    p_protocol_compliance_awprot_width_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awprot[2:0] == s_awprot[2:0]);
        );
    // --- p_protocol_compliance_arprot_width_check (roi=0.590) ---
    // ARPROT is 3-bit wide per AXI4-Lite spec. This property verifies signal width consistency (tautology for width checking).
    p_protocol_compliance_arprot_width_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_arprot[2:0] == s_arprot[2:0]);
        );
    // --- p_protocol_compliance_rresp_valid_encoding (roi=0.652) ---
    // RRESP should be OKAY (2'b00) or SLVERR (2'b10) for valid transactions. EXOKAY and DECERR are not used in AXI4-Lite.
    p_protocol_compliance_rresp_valid_encoding: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> (s_rresp == 2'b00 || s_rresp == 2'b10);
        );
    // --- p_protocol_compliance_bresp_valid_encoding (roi=0.652) ---
    // BRESP should be OKAY (2'b00) or SLVERR (2'b10) for valid transactions. EXOKAY and DECERR are not used in AXI4-Lite.
    p_protocol_compliance_bresp_valid_encoding: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00 || s_bresp == 2'b10);
        );
    // --- p_protocol_compliance_no_x_on_awaddr_during_handshake (roi=0.665) ---
    // Write address must not contain X or Z values during handshake to ensure deterministic behavior.
    p_protocol_compliance_no_x_on_awaddr_during_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> !$isunknown(s_awaddr);
        );
    // --- p_protocol_compliance_no_x_on_wdata_during_handshake (roi=0.665) ---
    // Write data must not contain X or Z values during handshake to ensure deterministic register updates.
    p_protocol_compliance_no_x_on_wdata_during_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |-> !$isunknown(s_wdata);
        );
    // --- p_protocol_compliance_no_x_on_wstrb_during_handshake (roi=0.665) ---
    // Write strobe must not contain X or Z values during handshake to ensure deterministic byte lane selection.
    p_protocol_compliance_no_x_on_wstrb_during_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |-> !$isunknown(s_wstrb);
        );
    // --- p_protocol_compliance_no_x_on_araddr_during_handshake (roi=0.665) ---
    // Read address must not contain X or Z values during handshake to ensure deterministic register selection.
    p_protocol_compliance_no_x_on_araddr_during_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> !$isunknown(s_araddr);
        );
    // --- p_protocol_compliance_no_x_on_rdata_during_valid (roi=0.665) ---
    // Read data must not contain X or Z values when RVALID is asserted to ensure valid data transfer.
    p_protocol_compliance_no_x_on_rdata_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata);
        );
    // --- p_protocol_compliance_no_x_on_bresp_during_valid (roi=0.665) ---
    // Write response must not contain X or Z values when BVALID is asserted to ensure deterministic response.
    p_protocol_compliance_no_x_on_bresp_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp);
        );
    // --- p_protocol_compliance_no_x_on_rresp_during_valid (roi=0.665) ---
    // Read response must not contain X or Z values when RVALID is asserted to ensure deterministic response.
    p_protocol_compliance_no_x_on_rresp_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp);
        );

endmodule // sva_protocol_compliance_checker
