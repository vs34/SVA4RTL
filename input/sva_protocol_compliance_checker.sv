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

    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.677) ---
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.677) ---
    // Write data must remain stable while WVALID is asserted and WREADY has not been received, ensuring data integrity during the handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.677) ---
    // Write strobe signals must remain stable during the write data handshake to maintain consistent byte-lane enables.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.677) ---
    // Write response BVALID must remain asserted until BREADY handshake completes per AXI4-Lite protocol.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.677) ---
    // Write response value must remain stable while BVALID is high and BREADY has not been asserted.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.677) ---
    // Read address ARVALID must remain asserted until ARREADY handshake completes per AXI4-Lite protocol.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.677) ---
    // Read address must remain stable while ARVALID is high and ARREADY has not been asserted.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.677) ---
    // Read protection attributes must remain stable during the read address handshake period.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.677) ---
    // Read data RVALID must remain asserted until RREADY handshake completes per AXI4-Lite protocol.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.677) ---
    // Read data must remain stable while RVALID is high and RREADY has not been asserted to ensure data integrity.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.677) ---
    // Read response must remain stable while RVALID is high and RREADY has not been asserted.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_after_both_aw_and_w (roi=0.652) ---
    // Write response can only be asserted after either write address or write data has been received (or is continuing from previous cycle). This ensures proper sequencing.
    p_protocol_compliance_bvalid_after_both_aw_and_w: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready, 1, 1) || $past(s_wvalid && s_wready, 1, 1) || (s_bvalid && !s_bready)
        );
    // --- p_protocol_compliance_rvalid_after_arvalid (roi=0.665) ---
    // Read response can only begin after a read address handshake has completed. New RVALID assertion must follow an AR handshake.
    p_protocol_compliance_rvalid_after_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !$past(s_rvalid)) |-> $past(s_arvalid && s_arready, 1, 1)
        );
    // --- p_protocol_compliance_no_bvalid_without_write_transaction (roi=0.627) ---
    // After completing a write response, the slave should not generate another BVALID without receiving a new write transaction (address or data).
    p_protocol_compliance_no_bvalid_without_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(s_bvalid && s_bready) |-> ##[1:$] (s_awvalid && s_awready) || (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_no_rvalid_without_read_transaction (roi=0.627) ---
    // After completing a read response, the slave should not generate another RVALID without receiving a new read address transaction.
    p_protocol_compliance_no_rvalid_without_read_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(s_rvalid && s_rready) |-> ##[1:$] (s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_awready_no_glitch (roi=0.640) ---
    // Slave should only assert AWREADY when there is a valid request (AWVALID=1). Prevents spurious ready signals.
    p_protocol_compliance_awready_no_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_awready) |-> s_awvalid
        );
    // --- p_protocol_compliance_wready_no_glitch (roi=0.640) ---
    // Slave should only assert WREADY when there is a valid write data (WVALID=1). Prevents spurious ready signals.
    p_protocol_compliance_wready_no_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_wready) |-> s_wvalid
        );
    // --- p_protocol_compliance_arready_no_glitch (roi=0.640) ---
    // Slave should only assert ARREADY when there is a valid read request (ARVALID=1). Prevents spurious ready signals.
    p_protocol_compliance_arready_no_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_arready) |-> s_arvalid
        );
    // --- p_protocol_compliance_bvalid_eventually_cleared (roi=0.615) ---
    // Write response must eventually complete. Bounded liveness property ensures no deadlock with reasonable timeout for master to assert BREADY.
    p_protocol_compliance_bvalid_eventually_cleared: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> ##[1:16] (s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_rvalid_eventually_cleared (roi=0.615) ---
    // Read response must eventually complete. Bounded liveness property ensures no deadlock with reasonable timeout for master to assert RREADY.
    p_protocol_compliance_rvalid_eventually_cleared: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> ##[1:16] (s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_no_simultaneous_bvalid_new_write (roi=0.627) ---
    // If a write response is pending and a new write address arrives, the pending response must remain stable (slave handles one write at a time).
    p_protocol_compliance_no_simultaneous_bvalid_new_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready && (s_awvalid && s_awready)) |=> s_bvalid
        );
    // --- p_protocol_compliance_no_simultaneous_rvalid_new_read (roi=0.627) ---
    // If a read response is pending and a new read address arrives, the pending response must remain stable (single-beat transactions only).
    p_protocol_compliance_no_simultaneous_rvalid_new_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready && (s_arvalid && s_arready)) |=> s_rvalid
        );
    // --- p_protocol_compliance_awready_deasserts_after_handshake (roi=0.615) ---
    // After accepting a write address, AWREADY should deassert unless immediately accepting another transaction. Prevents accepting same transaction twice.
    p_protocol_compliance_awready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready || s_awvalid
        );
    // --- p_protocol_compliance_wready_deasserts_after_handshake (roi=0.615) ---
    // After accepting write data, WREADY should deassert unless immediately accepting another transaction. Prevents accepting same data twice.
    p_protocol_compliance_wready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready || s_wvalid
        );
    // --- p_protocol_compliance_arready_deasserts_after_handshake (roi=0.615) ---
    // After accepting a read address, ARREADY should deassert unless immediately accepting another transaction. Prevents accepting same transaction twice.
    p_protocol_compliance_arready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready || s_arvalid
        );
    // --- p_protocol_compliance_bvalid_clears_on_handshake (roi=0.627) ---
    // BVALID must deassert after handshake unless a new write transaction is already in progress. Ensures proper transaction completion.
    p_protocol_compliance_bvalid_clears_on_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid || (s_awvalid || s_wvalid)
        );
    // --- p_protocol_compliance_rvalid_clears_on_handshake (roi=0.627) ---
    // RVALID must deassert after handshake unless a new read transaction is already in progress. Ensures proper transaction completion.
    p_protocol_compliance_rvalid_clears_on_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid || s_arvalid
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.665) ---
    // Per design specification, write responses are always OKAY (2'b00). This ensures the slave never returns error responses.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00)
        );
    // --- p_protocol_compliance_no_bvalid_at_reset (roi=0.665) ---
    // After reset deassertion, BVALID must be low. No pending write responses should exist coming out of reset.
    p_protocol_compliance_no_bvalid_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_bvalid
        );
    // --- p_protocol_compliance_no_rvalid_at_reset (roi=0.665) ---
    // After reset deassertion, RVALID must be low. No pending read responses should exist coming out of reset.
    p_protocol_compliance_no_rvalid_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_rvalid
        );
    // --- p_protocol_compliance_no_awready_at_reset (roi=0.652) ---
    // After reset deassertion, AWREADY should be low initially, requiring proper FSM state initialization before accepting transactions.
    p_protocol_compliance_no_awready_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_awready
        );
    // --- p_protocol_compliance_no_wready_at_reset (roi=0.652) ---
    // After reset deassertion, WREADY should be low initially, requiring proper FSM state initialization before accepting data.
    p_protocol_compliance_no_wready_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_wready
        );
    // --- p_protocol_compliance_no_arready_at_reset (roi=0.652) ---
    // After reset deassertion, ARREADY should be low initially, requiring proper FSM state initialization before accepting read addresses.
    p_protocol_compliance_no_arready_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_arready
        );
    // --- p_protocol_compliance_wstrb_valid_encoding (roi=0.640) ---
    // Write strobe must have at least one byte enabled during a valid write transaction. All-zero strobe is meaningless.
    p_protocol_compliance_wstrb_valid_encoding: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb != 4'b0000)
        );
    // --- p_protocol_compliance_awaddr_word_aligned (roi=0.652) ---
    // For 32-bit registers with 4-byte alignment, write addresses must be word-aligned. Ensures proper register access.
    p_protocol_compliance_awaddr_word_aligned: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_araddr_word_aligned (roi=0.652) ---
    // For 32-bit registers with 4-byte alignment, read addresses must be word-aligned. Ensures proper register access.
    p_protocol_compliance_araddr_word_aligned: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_awaddr_in_valid_range (roi=0.652) ---
    // Design has 4 registers at addresses 0x00, 0x04, 0x08, 0x0C. Valid addresses must be within the first 16 bytes (upper bits zero).
    p_protocol_compliance_awaddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[31:4] == 28'h0)
        );
    // --- p_protocol_compliance_araddr_in_valid_range (roi=0.652) ---
    // Design has 4 registers at addresses 0x00, 0x04, 0x08, 0x0C. Valid read addresses must be within the first 16 bytes (upper bits zero).
    p_protocol_compliance_araddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[31:4] == 28'h0)
        );
    // --- p_protocol_compliance_bvalid_response_latency_bounded (roi=0.627) ---
    // When both write address and data arrive simultaneously, response should be generated within bounded time. Ensures liveness with reasonable latency.
    p_protocol_compliance_bvalid_response_latency_bounded: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:8] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_response_latency_bounded (roi=0.627) ---
    // After accepting a read address, read data response should be generated within bounded time. Ensures liveness with reasonable latency.
    p_protocol_compliance_rvalid_response_latency_bounded: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:8] s_rvalid
        );
    // --- p_protocol_compliance_no_x_on_bvalid (roi=0.665) ---
    // BVALID must never be X or Z in valid operation. Critical control signal must have defined logic level.
    p_protocol_compliance_no_x_on_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_bvalid)
        );
    // --- p_protocol_compliance_no_x_on_rvalid (roi=0.665) ---
    // RVALID must never be X or Z in valid operation. Critical control signal must have defined logic level.
    p_protocol_compliance_no_x_on_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_rvalid)
        );
    // --- p_protocol_compliance_no_x_on_awready (roi=0.665) ---
    // AWREADY must never be X or Z in valid operation. Critical control signal must have defined logic level.
    p_protocol_compliance_no_x_on_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_awready)
        );
    // --- p_protocol_compliance_no_x_on_wready (roi=0.665) ---
    // WREADY must never be X or Z in valid operation. Critical control signal must have defined logic level.
    p_protocol_compliance_no_x_on_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_wready)
        );
    // --- p_protocol_compliance_no_x_on_arready (roi=0.665) ---
    // ARREADY must never be X or Z in valid operation. Critical control signal must have defined logic level.
    p_protocol_compliance_no_x_on_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_arready)
        );
    // --- p_protocol_compliance_no_x_on_bresp_when_valid (roi=0.665) ---
    // When BVALID is asserted, BRESP must have a defined value. Prevents propagation of unknown response values.
    p_protocol_compliance_no_x_on_bresp_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp)
        );
    // --- p_protocol_compliance_no_x_on_rresp_when_valid (roi=0.665) ---
    // When RVALID is asserted, RRESP must have a defined value. Prevents propagation of unknown response values.
    p_protocol_compliance_no_x_on_rresp_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp)
        );
    // --- p_protocol_compliance_no_x_on_rdata_when_valid (roi=0.665) ---
    // When RVALID is asserted, RDATA must have a defined value. Prevents reading undefined data from registers.
    p_protocol_compliance_no_x_on_rdata_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata)
        );
    // --- p_protocol_compliance_write_addr_before_resp (roi=0.640) ---
    // Write response can only be issued after a write address was accepted. Checks that AW handshake occurred within reasonable history before B response.
    p_protocol_compliance_write_addr_before_resp: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && $rose(s_bvalid)) |-> $past((s_awvalid && s_awready), 1, 1) || $past((s_awvalid && s_awready), 2, 1) || $past((s_awvalid && s_awready), 3, 1) || $past((s_awvalid && s_awready), 4, 1) || $past((s_awvalid && s_awready), 5, 1) || $past((s_awvalid && s_awready), 6, 1) || $past((s_awvalid && s_awready), 7, 1) || $past((s_awvalid && s_awready), 8, 1)
        );
    // --- p_protocol_compliance_write_data_before_resp (roi=0.640) ---
    // Write response can only be issued after write data was accepted. Checks that W handshake occurred within reasonable history before B response.
    p_protocol_compliance_write_data_before_resp: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && $rose(s_bvalid)) |-> $past((s_wvalid && s_wready), 1, 1) || $past((s_wvalid && s_wready), 2, 1) || $past((s_wvalid && s_wready), 3, 1) || $past((s_wvalid && s_wready), 4, 1) || $past((s_wvalid && s_wready), 5, 1) || $past((s_wvalid && s_wready), 6, 1) || $past((s_wvalid && s_wready), 7, 1) || $past((s_wvalid && s_wready), 8, 1)
        );
    // --- p_protocol_compliance_single_outstanding_write (roi=0.627) ---
    // Single-beat transaction constraint: after accepting write address (when no response is pending), a response must eventually be generated.
    p_protocol_compliance_single_outstanding_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_bvalid) |-> ##[1:8] s_bvalid
        );
    // --- p_protocol_compliance_single_outstanding_read (roi=0.627) ---
    // Single-beat transaction constraint: after accepting read address (when no response is pending), a response must eventually be generated.
    p_protocol_compliance_single_outstanding_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready && !s_rvalid) |-> ##[1:8] s_rvalid
        );

endmodule // sva_protocol_compliance_checker
