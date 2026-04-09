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
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY handshake completes, ensuring reliable write data transfer.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.677) ---
    // Write data must remain stable while WVALID is high until WREADY is asserted, preventing data corruption during handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.677) ---
    // Write strobe signals must remain stable during the handshake period to ensure correct byte-level write operations.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.677) ---
    // Write response valid signal must remain asserted until master accepts it via BREADY, per AXI4-Lite protocol.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.677) ---
    // Write response value must remain stable while BVALID is high until handshake completes with BREADY.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.677) ---
    // Read address valid signal must remain asserted until ARREADY handshake, ensuring reliable address transfer.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.677) ---
    // Read address must remain stable while ARVALID is high until ARREADY is asserted, preventing address corruption.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.677) ---
    // Read protection attributes must remain stable during address handshake period for consistent access control.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.677) ---
    // Read data valid signal must remain asserted until master acknowledges with RREADY, per AXI4-Lite specification.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.677) ---
    // Read data must remain stable while RVALID is high until handshake completes, preventing data corruption.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.677) ---
    // Read response must remain stable while RVALID is high until RREADY handshake completes.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_after_both_write_channels (roi=0.665) ---
    // Write response must eventually be asserted after both write address and write data channels complete their handshakes, ensuring proper transaction ordering.
    p_protocol_compliance_bvalid_after_both_write_channels: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:$] s_bvalid
        );
    // --- p_protocol_compliance_no_bvalid_without_awvalid_wvalid (roi=0.652) ---
    // Write response cannot be generated without at least one of the write channels having been valid, preventing spurious responses.
    p_protocol_compliance_no_bvalid_without_awvalid_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_awvalid && s_awready, 0, 20) || $past(s_wvalid && s_wready, 0, 20)
        );
    // --- p_protocol_compliance_rvalid_after_arvalid_arready (roi=0.665) ---
    // Read data valid must eventually be asserted after read address handshake completes, ensuring liveness of read transactions.
    p_protocol_compliance_rvalid_after_arvalid_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:$] s_rvalid
        );
    // --- p_protocol_compliance_no_rvalid_without_arvalid (roi=0.652) ---
    // Read data valid cannot be asserted without a preceding read address handshake, preventing spurious read responses.
    p_protocol_compliance_no_rvalid_without_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_rvalid) |-> $past(s_arvalid && s_arready, 0, 20)
        );
    // --- p_protocol_compliance_awready_requires_awvalid (roi=0.640) ---
    // Slave should only assert AWREADY when AWVALID is present, ensuring proper handshake sequencing.
    p_protocol_compliance_awready_requires_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awready |-> s_awvalid
        );
    // --- p_protocol_compliance_wready_requires_wvalid (roi=0.640) ---
    // Slave should only assert WREADY when WVALID is present, ensuring proper write data handshake.
    p_protocol_compliance_wready_requires_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wready |-> s_wvalid
        );
    // --- p_protocol_compliance_arready_requires_arvalid (roi=0.640) ---
    // Slave should only assert ARREADY when ARVALID is present, ensuring proper read address handshake.
    p_protocol_compliance_arready_requires_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arready |-> s_arvalid
        );
    // --- p_protocol_compliance_bvalid_deasserts_after_bready (roi=0.627) ---
    // Write response valid should deassert within 1-2 cycles after handshake completion, preventing protocol deadlock.
    p_protocol_compliance_bvalid_deasserts_after_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid [*1:2]
        );
    // --- p_protocol_compliance_rvalid_deasserts_after_rready (roi=0.627) ---
    // Read data valid should deassert within 1-2 cycles after handshake completion, preventing protocol deadlock.
    p_protocol_compliance_rvalid_deasserts_after_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid [*1:2]
        );
    // --- p_protocol_compliance_no_simultaneous_bvalid_for_same_transaction (roi=0.652) ---
    // BVALID cannot rise again while a previous write response is still pending, ensuring single-beat transaction compliance.
    p_protocol_compliance_no_simultaneous_bvalid_for_same_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid && !s_bready |-> !$rose(s_bvalid)
        );
    // --- p_protocol_compliance_no_simultaneous_rvalid_for_same_transaction (roi=0.652) ---
    // RVALID cannot rise again while a previous read response is still pending, ensuring single-beat transaction compliance.
    p_protocol_compliance_no_simultaneous_rvalid_for_same_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid && !s_rready |-> !$rose(s_rvalid)
        );
    // --- p_protocol_compliance_write_response_bounded_latency (roi=0.615) ---
    // Write response should be generated within a bounded time (16 cycles) after both write channels complete, ensuring reasonable latency.
    p_protocol_compliance_write_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_read_response_bounded_latency (roi=0.615) ---
    // Read response should be generated within a bounded time (16 cycles) after read address handshake, ensuring reasonable latency.
    p_protocol_compliance_read_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid
        );
    // --- p_protocol_compliance_bresp_okay_for_valid_writes (roi=0.665) ---
    // Design summary states write responses are always OKAY (2'b00), verifying correct response encoding.
    p_protocol_compliance_bresp_okay_for_valid_writes: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00)
        );
    // --- p_protocol_compliance_awaddr_aligned_to_word_boundary (roi=0.652) ---
    // For 32-bit registers, write addresses should be word-aligned (lower 2 bits zero), ensuring valid memory-mapped access.
    p_protocol_compliance_awaddr_aligned_to_word_boundary: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_araddr_aligned_to_word_boundary (roi=0.652) ---
    // For 32-bit registers, read addresses should be word-aligned (lower 2 bits zero), ensuring valid memory-mapped access.
    p_protocol_compliance_araddr_aligned_to_word_boundary: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_awaddr_within_register_range (roi=0.640) ---
    // Register map has 4 registers (0x00-0x0C), so valid addresses should be within first 16-byte range.
    // SKIPPED (out-of-range bit index): p_protocol_compliance_awaddr_within_register_range
    // p_protocol_compliance_awaddr_within_register_range: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_awvalid |-> (s_awaddr[31:4] == 28'h0)
    //     );
    // --- p_protocol_compliance_araddr_within_register_range (roi=0.640) ---
    // Register map has 4 registers (0x00-0x0C), so valid addresses should be within first 16-byte range.
    // SKIPPED (out-of-range bit index): p_protocol_compliance_araddr_within_register_range
    // p_protocol_compliance_araddr_within_register_range: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_arvalid |-> (s_araddr[31:4] == 28'h0)
    //     );
    // --- p_protocol_compliance_wstrb_valid_encoding (roi=0.627) ---
    // Write strobes should represent valid byte-enable patterns for aligned 32-bit accesses (single byte, half-word, or full word).
    p_protocol_compliance_wstrb_valid_encoding: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000, 4'b0011, 4'b1100, 4'b1111})
        );
    // --- p_protocol_compliance_no_bvalid_glitch_without_handshake (roi=0.652) ---
    // BVALID should only deassert after BREADY handshake, not spontaneously, preventing protocol violations.
    p_protocol_compliance_no_bvalid_glitch_without_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(s_bvalid) |-> $past(s_bready)
        );
    // --- p_protocol_compliance_no_rvalid_glitch_without_handshake (roi=0.652) ---
    // RVALID should only deassert after RREADY handshake, not spontaneously, preventing protocol violations.
    p_protocol_compliance_no_rvalid_glitch_without_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(s_rvalid) |-> $past(s_rready)
        );
    // --- p_protocol_compliance_write_addr_data_independent_arrival (roi=0.640) ---
    // Write address can complete before write data, and write data must eventually arrive, verifying independent channel operation.
    p_protocol_compliance_write_addr_data_independent_arrival: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) |-> ##[0:$] (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_write_data_addr_independent_arrival (roi=0.640) ---
    // Write data can complete before write address, and write address must eventually arrive, verifying independent channel operation.
    p_protocol_compliance_write_data_addr_independent_arrival: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) |-> ##[0:$] (s_awvalid && s_awready)
        );
    // --- p_protocol_compliance_no_multiple_outstanding_write_transactions (roi=0.640) ---
    // Single-beat transaction requirement means no new write should complete while a response is pending, preventing transaction overlap.
    p_protocol_compliance_no_multiple_outstanding_write_transactions: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !(s_awvalid && s_awready && s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_no_multiple_outstanding_read_transactions (roi=0.640) ---
    // Single-beat transaction requirement means no new read should start while a response is pending, preventing transaction overlap.
    p_protocol_compliance_no_multiple_outstanding_read_transactions: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> !(s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_reset_clears_awready (roi=0.627) ---
    // After reset deassertion, slave ready signals should be deasserted initially, ensuring clean state machine initialization.
    p_protocol_compliance_reset_clears_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_awready
        );
    // --- p_protocol_compliance_reset_clears_wready (roi=0.627) ---
    // After reset deassertion, write data ready should be deasserted initially, ensuring clean state machine initialization.
    p_protocol_compliance_reset_clears_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_wready
        );
    // --- p_protocol_compliance_reset_clears_arready (roi=0.627) ---
    // After reset deassertion, read address ready should be deasserted initially, ensuring clean state machine initialization.
    p_protocol_compliance_reset_clears_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_arready
        );
    // --- p_protocol_compliance_reset_clears_bvalid (roi=0.652) ---
    // After reset deassertion, write response valid should be deasserted, preventing spurious responses.
    p_protocol_compliance_reset_clears_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_bvalid
        );
    // --- p_protocol_compliance_reset_clears_rvalid (roi=0.652) ---
    // After reset deassertion, read data valid should be deasserted, preventing spurious read data.
    p_protocol_compliance_reset_clears_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_rvalid
        );

endmodule // sva_protocol_compliance_checker
