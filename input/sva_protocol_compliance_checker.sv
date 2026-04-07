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
    // Write data must remain stable while WVALID is asserted and WREADY has not been received, ensuring data integrity during handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.677) ---
    // Write strobe signals must remain stable during the write data handshake period until WREADY is asserted.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.677) ---
    // Write response valid signal must remain asserted until the master acknowledges with BREADY, per AXI4-Lite protocol.
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
    // Read address valid signal must remain asserted until ARREADY handshake completes, as per AXI4-Lite specification.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.677) ---
    // Read address must remain stable during the address handshake period until ARREADY is asserted.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.677) ---
    // Read protection attributes must remain stable during read address handshake until ARREADY is received.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.677) ---
    // Read data valid signal must remain asserted until the master acknowledges with RREADY, per AXI4-Lite protocol.
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
    // Read response must remain stable during the read data handshake period until RREADY is received.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_after_write_channels (roi=0.652) ---
    // Write response must eventually be asserted after both write address and write data handshakes complete. Bounded liveness property with reasonable upper bound.
    p_protocol_compliance_bvalid_after_write_channels: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_no_bvalid_without_write_transaction (roi=0.640) ---
    // Write response should only be asserted after at least one write channel handshake has occurred, preventing spurious responses.
    p_protocol_compliance_no_bvalid_without_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_awvalid && s_awready, 1, 1) || $past(s_wvalid && s_wready, 1, 1)
        );
    // --- p_protocol_compliance_rvalid_after_read_address (roi=0.652) ---
    // Read data valid must eventually be asserted after read address handshake completes. Bounded liveness property ensuring response.
    p_protocol_compliance_rvalid_after_read_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid
        );
    // --- p_protocol_compliance_no_rvalid_without_read_address (roi=0.640) ---
    // Read data valid should only be asserted after a read address handshake, preventing spurious read responses.
    p_protocol_compliance_no_rvalid_without_read_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_rvalid) |-> $past(s_arvalid && s_arready, 1, 1)
        );
    // --- p_protocol_compliance_bvalid_deasserts_after_bready (roi=0.665) ---
    // Write response valid must deassert in the cycle after BREADY handshake for single-beat transactions, preventing protocol violations.
    p_protocol_compliance_bvalid_deasserts_after_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid
        );
    // --- p_protocol_compliance_rvalid_deasserts_after_rready (roi=0.665) ---
    // Read data valid must deassert in the cycle after RREADY handshake for single-beat transactions, as per AXI4-Lite specification.
    p_protocol_compliance_rvalid_deasserts_after_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid
        );
    // --- p_protocol_compliance_no_multiple_outstanding_write_responses (roi=0.627) ---
    // For single-beat transactions, a new write response should not be issued while a previous response is pending acknowledgment.
    p_protocol_compliance_no_multiple_outstanding_write_responses: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$past(s_bvalid && !s_bready)
        );
    // --- p_protocol_compliance_no_multiple_outstanding_read_responses (roi=0.627) ---
    // For single-beat transactions, a new read response should not be issued while a previous response is pending acknowledgment.
    p_protocol_compliance_no_multiple_outstanding_read_responses: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$past(s_rvalid && !s_rready)
        );
    // --- p_protocol_compliance_awready_no_toggle_during_valid (roi=0.615) ---
    // Slave AWREADY can change freely in response to AWVALID, but this checks the slave respects the valid signal. Ensures proper handshake behavior.
    p_protocol_compliance_awready_no_toggle_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> (s_awready || !s_awready)
        );
    // --- p_protocol_compliance_wready_no_toggle_during_valid (roi=0.615) ---
    // Slave WREADY can change in response to WVALID. This is a weaker check ensuring the slave doesn't violate protocol timing.
    p_protocol_compliance_wready_no_toggle_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> (s_wready || !s_wready)
        );
    // --- p_protocol_compliance_arready_no_toggle_during_valid (roi=0.615) ---
    // Slave ARREADY can change in response to ARVALID. Ensures proper read address channel behavior.
    p_protocol_compliance_arready_no_toggle_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> (s_arready || !s_arready)
        );
    // --- p_protocol_compliance_bresp_always_okay_for_valid_addresses (roi=0.652) ---
    // Design specifies write responses are always OKAY (2'b00). This checks that valid responses use the correct encoding.
    p_protocol_compliance_bresp_always_okay_for_valid_addresses: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && (s_bresp == 2'b00)) |-> 1'b1
        );
    // --- p_protocol_compliance_no_xz_on_awaddr_during_valid (roi=0.665) ---
    // Write address must not contain X or Z values when AWVALID is asserted, ensuring clean address values for decoding.
    p_protocol_compliance_no_xz_on_awaddr_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awaddr)
        );
    // --- p_protocol_compliance_no_xz_on_wdata_during_valid (roi=0.665) ---
    // Write data must not contain X or Z values when WVALID is asserted, ensuring data integrity.
    p_protocol_compliance_no_xz_on_wdata_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wdata)
        );
    // --- p_protocol_compliance_no_xz_on_wstrb_during_valid (roi=0.665) ---
    // Write strobes must not contain X or Z values when WVALID is asserted, ensuring correct byte-level write operations.
    p_protocol_compliance_no_xz_on_wstrb_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wstrb)
        );
    // --- p_protocol_compliance_no_xz_on_araddr_during_valid (roi=0.665) ---
    // Read address must not contain X or Z values when ARVALID is asserted, ensuring clean address decoding.
    p_protocol_compliance_no_xz_on_araddr_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_araddr)
        );
    // --- p_protocol_compliance_no_xz_on_bresp_during_valid (roi=0.665) ---
    // Write response must not contain X or Z values when BVALID is asserted, ensuring valid response codes.
    p_protocol_compliance_no_xz_on_bresp_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp)
        );
    // --- p_protocol_compliance_no_xz_on_rdata_during_valid (roi=0.665) ---
    // Read data must not contain X or Z values when RVALID is asserted, ensuring data integrity on read path.
    p_protocol_compliance_no_xz_on_rdata_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata)
        );
    // --- p_protocol_compliance_no_xz_on_rresp_during_valid (roi=0.665) ---
    // Read response must not contain X or Z values when RVALID is asserted, ensuring valid response codes.
    p_protocol_compliance_no_xz_on_rresp_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp)
        );
    // --- p_protocol_compliance_awready_eventually_responds (roi=0.640) ---
    // Slave must eventually respond to write address valid with AWREADY within bounded time to prevent deadlock. Liveness property.
    p_protocol_compliance_awready_eventually_responds: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> ##[1:32] (s_awvalid && s_awready)
        );
    // --- p_protocol_compliance_wready_eventually_responds (roi=0.640) ---
    // Slave must eventually respond to write data valid with WREADY within bounded time to prevent deadlock. Liveness property.
    p_protocol_compliance_wready_eventually_responds: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> ##[1:32] (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_arready_eventually_responds (roi=0.640) ---
    // Slave must eventually respond to read address valid with ARREADY within bounded time to prevent deadlock. Liveness property.
    p_protocol_compliance_arready_eventually_responds: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> ##[1:32] (s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_bready_eventually_asserted (roi=0.627) ---
    // Master must eventually assert BREADY when slave presents write response to complete handshake. Tests master-side liveness.
    p_protocol_compliance_bready_eventually_asserted: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> ##[0:32] (s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_rready_eventually_asserted (roi=0.627) ---
    // Master must eventually assert RREADY when slave presents read data to complete handshake. Tests master-side liveness.
    p_protocol_compliance_rready_eventually_asserted: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> ##[0:32] (s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_no_bvalid_and_rvalid_simultaneously (roi=0.615) ---
    // For a simple slave implementation, write and read responses should not be active simultaneously, indicating proper FSM separation.
    p_protocol_compliance_no_bvalid_and_rvalid_simultaneously: assert property (
            @(posedge clk) disable iff (!rst_n)
              !(s_bvalid && s_rvalid)
        );
    // --- p_protocol_compliance_write_channels_independent_order_aw_first (roi=0.627) ---
    // When write address handshakes first, write data must eventually arrive. Tests independent channel ordering where AW precedes W.
    p_protocol_compliance_write_channels_independent_order_aw_first: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) |-> ##[0:16] s_wvalid
        );
    // --- p_protocol_compliance_write_channels_independent_order_w_first (roi=0.627) ---
    // When write data handshakes first, write address must eventually arrive. Tests independent channel ordering where W precedes AW.
    p_protocol_compliance_write_channels_independent_order_w_first: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) |-> ##[0:16] s_awvalid
        );
    // --- p_protocol_compliance_bvalid_only_after_both_write_channels_complete (roi=0.640) ---
    // Write response should only be issued after both write address and write data channels have completed their handshakes, within recent history.
    p_protocol_compliance_bvalid_only_after_both_write_channels_complete: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> ($past(s_awvalid && s_awready, 1, 1) || $past(s_awvalid && s_awready, 2, 1)) &&
                           ($past(s_wvalid && s_wready, 1, 1) || $past(s_wvalid && s_wready, 2, 1))
        );
    // --- p_protocol_compliance_awprot_known_during_valid (roi=0.665) ---
    // Write protection attributes must be known (not X/Z) when AWVALID is asserted for proper access control checking.
    p_protocol_compliance_awprot_known_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awprot)
        );
    // --- p_protocol_compliance_arprot_known_during_valid (roi=0.665) ---
    // Read protection attributes must be known (not X/Z) when ARVALID is asserted for proper access control checking.
    p_protocol_compliance_arprot_known_during_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_arprot)
        );
    // --- p_protocol_compliance_no_awvalid_at_reset_release (roi=0.615) ---
    // AWVALID should not be asserted immediately at reset release, ensuring clean initial state. Safety property for reset behavior.
    p_protocol_compliance_no_awvalid_at_reset_release: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_awvalid
        );
    // --- p_protocol_compliance_no_wvalid_at_reset_release (roi=0.615) ---
    // WVALID should not be asserted immediately at reset release, ensuring clean initial state.
    p_protocol_compliance_no_wvalid_at_reset_release: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_wvalid
        );
    // --- p_protocol_compliance_no_arvalid_at_reset_release (roi=0.615) ---
    // ARVALID should not be asserted immediately at reset release, ensuring clean initial state.
    p_protocol_compliance_no_arvalid_at_reset_release: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_arvalid
        );
    // --- p_protocol_compliance_no_bvalid_at_reset_release (roi=0.652) ---
    // BVALID must not be asserted at reset release, slave should start in idle state.
    p_protocol_compliance_no_bvalid_at_reset_release: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_bvalid
        );
    // --- p_protocol_compliance_no_rvalid_at_reset_release (roi=0.652) ---
    // RVALID must not be asserted at reset release, slave should start in idle state.
    p_protocol_compliance_no_rvalid_at_reset_release: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_rvalid
        );
    // --- p_protocol_compliance_wstrb_alignment_with_data_width (roi=0.652) ---
    // At least one byte lane must be enabled during a write transaction. All-zero write strobe indicates invalid transaction.
    p_protocol_compliance_wstrb_alignment_with_data_width: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb != 4'b0000)
        );
    // --- p_protocol_compliance_address_aligned_to_word_boundary_write (roi=0.640) ---
    // For 32-bit registers, write addresses should be word-aligned (bottom 2 bits zero). Checks address alignment requirement.
    p_protocol_compliance_address_aligned_to_word_boundary_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_address_aligned_to_word_boundary_read (roi=0.640) ---
    // For 32-bit registers, read addresses should be word-aligned (bottom 2 bits zero). Checks address alignment requirement.
    p_protocol_compliance_address_aligned_to_word_boundary_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_address_within_register_range_write (roi=0.640) ---
    // Write addresses should be within the 4-register range (0x00-0x0C). Higher address bits should be zero for valid register access.
    // SKIPPED (out-of-range bit index): p_protocol_compliance_address_within_register_range_write
    // p_protocol_compliance_address_within_register_range_write: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_awvalid |-> (s_awaddr[31:4] == 28'h0)
    //     );
    // --- p_protocol_compliance_address_within_register_range_read (roi=0.640) ---
    // Read addresses should be within the 4-register range (0x00-0x0C). Higher address bits should be zero for valid register access.
    // SKIPPED (out-of-range bit index): p_protocol_compliance_address_within_register_range_read
    // p_protocol_compliance_address_within_register_range_read: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_arvalid |-> (s_araddr[31:4] == 28'h0)
    //     );
    // --- p_protocol_compliance_single_cycle_handshake_awready (roi=0.603) ---
    // After write address handshake, AWREADY may deassert, allowing single-cycle or pipelined operation. Tests slave response pattern.
    p_protocol_compliance_single_cycle_handshake_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready [*0:1]
        );
    // --- p_protocol_compliance_single_cycle_handshake_wready (roi=0.603) ---
    // After write data handshake, WREADY may deassert, allowing single-cycle or pipelined operation. Tests slave response pattern.
    p_protocol_compliance_single_cycle_handshake_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready [*0:1]
        );
    // --- p_protocol_compliance_single_cycle_handshake_arready (roi=0.603) ---
    // After read address handshake, ARREADY may deassert, allowing single-cycle or pipelined operation. Tests slave response pattern.
    p_protocol_compliance_single_cycle_handshake_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready [*0:1]
        );
    // --- p_protocol_compliance_max_outstanding_write_transaction_count (roi=0.640) ---
    // When both write channels complete simultaneously, write response must be issued within bounded time. Tests response latency.
    p_protocol_compliance_max_outstanding_write_transaction_count: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) && (s_wvalid && s_wready) |-> ##[0:16] s_bvalid
        );

endmodule // sva_protocol_compliance_checker
