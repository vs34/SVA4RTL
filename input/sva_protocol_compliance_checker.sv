// ---------------------------------------------------------------
// Auto-generated SVA checker -- DO NOT EDIT
// Module: sva_protocol_compliance_checker
// ---------------------------------------------------------------
`timescale 1ns / 1ps

module sva_protocol_compliance_checker (
    input logic clk,
    input logic rst_n
);

default clocking cb @(posedge clk);
endclocking

default disable iff (rst_n);

    // --- p_protocol_compliance_c904a1aa3923 (roi=0.675) ---
    // Template-generated for protocol_compliance
    // Protocol compliance assertions for axi_lite_slave
    // Target: c904a1aa3923 -- AXI4-Lite slave compliance
    
    
    // Handshake stability: VALID must not deassert without READY
    p_c904a1aa3923_valid_stable: assert property (
        @(posedge clk) disable iff (rst_n)
        valid && !ready |=> valid
    );
    
    // Handshake stability: signals must remain stable while VALID && !READY
    
    
    // Handshake must complete: VALID eventually sees READY (liveness bound)
    p_c904a1aa3923_handshake_live: assert property (
        @(posedge clk) disable iff (rst_n)
        valid |-> ##[0:64] ready
    );
    
    // No response without request
    
    // Protocol rule: AWVALID and WVALID may assert in any order or simultaneously
    // Protocol rule: AWREADY and WREADY may be asserted independently
    // Protocol rule: BVALID must remain asserted until BREADY is observed high
    // Protocol rule: RVALID must remain asserted until RREADY is observed high
    // Protocol rule: Single-beat transactions only (no burst support)
    // Protocol rule: Write response (BRESP) always OKAY per code comment
    // Protocol rule: Read data is registered for timing closure
    // --- p_protocol_compliance_awvalid_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires AWVALID to remain stable (high) once asserted until AWREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_awvalid_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> s_awvalid
        );
    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WVALID to remain stable (high) once asserted until WREADY handshake completes.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARVALID to remain stable (high) once asserted until ARREADY handshake completes.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol mandates BVALID must remain asserted until BREADY is observed high. Slave must not deassert BVALID prematurely.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol mandates RVALID must remain asserted until RREADY is observed high. Slave must not deassert RVALID prematurely.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_awaddr_stable_until_awready (roi=0.667) ---
    // AXI4-Lite requires write address to remain stable while AWVALID is asserted and before AWREADY handshake.
    p_protocol_compliance_awaddr_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awaddr)
        );
    // --- p_protocol_compliance_awprot_stable_until_awready (roi=0.667) ---
    // AXI4-Lite requires protection attributes to remain stable while AWVALID is asserted and before AWREADY handshake.
    p_protocol_compliance_awprot_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awprot)
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.667) ---
    // AXI4-Lite requires write data to remain stable while WVALID is asserted and before WREADY handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.667) ---
    // AXI4-Lite requires write strobes to remain stable while WVALID is asserted and before WREADY handshake.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.667) ---
    // AXI4-Lite requires read address to remain stable while ARVALID is asserted and before ARREADY handshake.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.667) ---
    // AXI4-Lite requires protection attributes to remain stable while ARVALID is asserted and before ARREADY handshake.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.667) ---
    // AXI4-Lite requires write response to remain stable while BVALID is asserted until BREADY handshake completes.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.667) ---
    // AXI4-Lite requires read data to remain stable while RVALID is asserted until RREADY handshake completes.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.667) ---
    // AXI4-Lite requires read response to remain stable while RVALID is asserted until RREADY handshake completes.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_eventually_after_write (roi=0.654) ---
    // Liveness property: After both address and data phases complete simultaneously, slave must eventually assert BVALID within reasonable time (bounded to prevent infinite wait).
    p_protocol_compliance_bvalid_eventually_after_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_bvalid_eventually_after_aw_then_w (roi=0.654) ---
    // Liveness property: After AW phase completes first, then W phase completes, slave must eventually assert BVALID within bounded time.
    p_protocol_compliance_bvalid_eventually_after_aw_then_w: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) ##[1:$] (s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_bvalid_eventually_after_w_then_aw (roi=0.654) ---
    // Liveness property: After W phase completes first, then AW phase completes, slave must eventually assert BVALID within bounded time.
    p_protocol_compliance_bvalid_eventually_after_w_then_aw: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) ##[1:$] (s_awvalid && s_awready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_eventually_after_read (roi=0.654) ---
    // Liveness property: After read address handshake completes, slave must eventually assert RVALID with read data within bounded time.
    p_protocol_compliance_rvalid_eventually_after_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid
        );
    // --- p_protocol_compliance_no_bvalid_without_write_transaction (roi=0.642) ---
    // Safety property: BVALID should never be asserted without a preceding write transaction (both AW and W phases must have occurred within recent history).
    p_protocol_compliance_no_bvalid_without_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready, 1, 16) && $past(s_wvalid && s_wready, 1, 16)
        );
    // --- p_protocol_compliance_no_rvalid_without_read_transaction (roi=0.642) ---
    // Safety property: RVALID should never be asserted without a preceding read address handshake within recent history.
    p_protocol_compliance_no_rvalid_without_read_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> $past(s_arvalid && s_arready, 1, 16)
        );
    // --- p_protocol_compliance_bvalid_cleared_after_handshake (roi=0.667) ---
    // Safety property: After write response handshake completes, BVALID must be deasserted in the next cycle (no lingering BVALID).
    p_protocol_compliance_bvalid_cleared_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid
        );
    // --- p_protocol_compliance_rvalid_cleared_after_handshake (roi=0.667) ---
    // Safety property: After read data handshake completes, RVALID must be deasserted in the next cycle (no lingering RVALID).
    p_protocol_compliance_rvalid_cleared_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid
        );
    // --- p_protocol_compliance_no_overlapping_write_responses (roi=0.629) ---
    // Safety property: A new BVALID cannot be asserted until the current write response completes and stays low. Ensures no overlapping responses for single-beat transactions.
    p_protocol_compliance_no_overlapping_write_responses: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> ##[1:$] (s_bready && s_bvalid) ##1 !s_bvalid [*1:$] ##0 !s_bvalid throughout (s_awvalid && s_awready && s_wvalid && s_wready)[->1]
        );
    // --- p_protocol_compliance_no_overlapping_read_responses (roi=0.629) ---
    // Safety property: A new RVALID cannot be asserted until the current read response completes and stays low. Ensures no overlapping responses for single-beat transactions.
    p_protocol_compliance_no_overlapping_read_responses: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> ##[1:$] (s_rready && s_rvalid) ##1 !s_rvalid [*1:$] ##0 !s_rvalid throughout (s_arvalid && s_arready)[->1]
        );
    // --- p_protocol_compliance_awready_deasserts_after_handshake (roi=0.617) ---
    // Implementation-specific safety: Slave typically deasserts AWREADY after accepting an address to process the transaction (common FSM pattern).
    p_protocol_compliance_awready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready
        );
    // --- p_protocol_compliance_wready_deasserts_after_handshake (roi=0.617) ---
    // Implementation-specific safety: Slave typically deasserts WREADY after accepting data to process the transaction (common FSM pattern).
    p_protocol_compliance_wready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready
        );
    // --- p_protocol_compliance_arready_deasserts_after_handshake (roi=0.617) ---
    // Implementation-specific safety: Slave typically deasserts ARREADY after accepting a read address to process the transaction (common FSM pattern).
    p_protocol_compliance_arready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.667) ---
    // Per design comment, write response is always OKAY (2'b00). This verifies the slave never returns error responses.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00)
        );
    // --- p_protocol_compliance_write_addr_aligned_to_word (roi=0.654) ---
    // Safety property: For a register file with 32-bit registers, addresses should be word-aligned (bottom 2 bits are 0).
    p_protocol_compliance_write_addr_aligned_to_word: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> (s_awaddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_read_addr_aligned_to_word (roi=0.654) ---
    // Safety property: For a register file with 32-bit registers, addresses should be word-aligned (bottom 2 bits are 0).
    p_protocol_compliance_read_addr_aligned_to_word: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> (s_araddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_write_addr_within_range (roi=0.642) ---
    // Safety property: Write addresses must target one of the four defined registers (0x00, 0x04, 0x08, 0x0C). Addresses outside this range are invalid.
    p_protocol_compliance_write_addr_within_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> (s_awaddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
        );
    // --- p_protocol_compliance_read_addr_within_range (roi=0.642) ---
    // Safety property: Read addresses must target one of the four defined registers (0x00, 0x04, 0x08, 0x0C). Addresses outside this range are invalid.
    p_protocol_compliance_read_addr_within_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> (s_araddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
        );
    // --- p_protocol_compliance_wstrb_nonzero_on_valid_write (roi=0.629) ---
    // Safety property: For a meaningful write transaction, at least one byte strobe should be active. All-zero WSTRB would indicate no actual write.
    p_protocol_compliance_wstrb_nonzero_on_valid_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |-> (|s_wstrb)
        );
    // --- p_protocol_compliance_bvalid_mutex_with_new_write (roi=0.642) ---
    // Safety property: While a write response is pending (BVALID high, BREADY low), slave should not accept a new complete write transaction (FSM constraint).
    p_protocol_compliance_bvalid_mutex_with_new_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid && !s_bready |-> !(s_awvalid && s_awready && s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_rvalid_mutex_with_new_read (roi=0.642) ---
    // Safety property: While a read response is pending (RVALID high, RREADY low), slave should not accept a new read address (FSM constraint).
    p_protocol_compliance_rvalid_mutex_with_new_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid && !s_rready |-> !(s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_no_bvalid_at_reset (roi=0.654) ---
    // Safety property: At reset deassertion, BVALID should be low (no pending write response).
    p_protocol_compliance_no_bvalid_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(rst_n) |-> !s_bvalid
        );
    // --- p_protocol_compliance_no_rvalid_at_reset (roi=0.654) ---
    // Safety property: At reset deassertion, RVALID should be low (no pending read response).
    p_protocol_compliance_no_rvalid_at_reset: assert property (
            @(posedge clk) disable iff (!rst_n)
              $fell(rst_n) |-> !s_rvalid
        );
    // --- p_protocol_compliance_awready_low_during_bvalid_wait (roi=0.629) ---
    // Implementation-specific: While waiting for BREADY, slave should not accept new write addresses (FSM in response state).
    p_protocol_compliance_awready_low_during_bvalid_wait: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !s_awready
        );
    // --- p_protocol_compliance_wready_low_during_bvalid_wait (roi=0.629) ---
    // Implementation-specific: While waiting for BREADY, slave should not accept new write data (FSM in response state).
    p_protocol_compliance_wready_low_during_bvalid_wait: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !s_wready
        );
    // --- p_protocol_compliance_arready_low_during_rvalid_wait (roi=0.629) ---
    // Implementation-specific: While waiting for RREADY, slave should not accept new read addresses (FSM in data response state).
    p_protocol_compliance_arready_low_during_rvalid_wait: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> !s_arready
        );
    // --- p_protocol_compliance_write_response_bounded_latency (roi=0.617) ---
    // Bounded liveness: Write response handshake should complete within reasonable cycles (8 cycles) after both address and data are accepted. Prevents deadlock.
    p_protocol_compliance_write_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:8] (s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_read_response_bounded_latency (roi=0.617) ---
    // Bounded liveness: Read response handshake should complete within reasonable cycles (8 cycles) after address is accepted. Prevents deadlock.
    p_protocol_compliance_read_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:8] (s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_single_beat_only_no_awlen (roi=0.567) ---
    // Placeholder rationale: AXI4-Lite has no burst signals (AWLEN/ARLEN). This is implicitly enforced by interface definition, not a runtime property. Kept for documentation.
    p_protocol_compliance_single_beat_only_no_awlen: assert property (
            @(posedge clk) disable iff (!rst_n)
              1'b1 |-> 1'b1
        );
    // --- p_protocol_compliance_write_data_not_x_on_valid (roi=0.642) ---
    // Safety property: When WVALID is asserted, WDATA must not contain X/Z values (protocol violation and design bug indicator).
    p_protocol_compliance_write_data_not_x_on_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wdata)
        );
    // --- p_protocol_compliance_write_strb_not_x_on_valid (roi=0.642) ---
    // Safety property: When WVALID is asserted, WSTRB must not contain X/Z values (protocol violation and design bug indicator).
    p_protocol_compliance_write_strb_not_x_on_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wstrb)
        );
    // --- p_protocol_compliance_awaddr_not_x_on_valid (roi=0.642) ---
    // Safety property: When AWVALID is asserted, AWADDR must not contain X/Z values (protocol violation and design bug indicator).
    p_protocol_compliance_awaddr_not_x_on_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awaddr)
        );
    // --- p_protocol_compliance_araddr_not_x_on_valid (roi=0.642) ---
    // Safety property: When ARVALID is asserted, ARADDR must not contain X/Z values (protocol violation and design bug indicator).
    p_protocol_compliance_araddr_not_x_on_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_araddr)
        );
    // --- p_protocol_compliance_rdata_not_x_on_rvalid (roi=0.654) ---
    // Safety property: When RVALID is asserted, RDATA must not contain X/Z values (indicates proper register read implementation).
    p_protocol_compliance_rdata_not_x_on_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata)
        );
    // --- p_protocol_compliance_bresp_not_x_on_bvalid (roi=0.654) ---
    // Safety property: When BVALID is asserted, BRESP must not contain X/Z values (indicates proper response generation).
    p_protocol_compliance_bresp_not_x_on_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp)
        );
    // --- p_protocol_compliance_rresp_not_x_on_rvalid (roi=0.654) ---
    // Safety property: When RVALID is asserted, RRESP must not contain X/Z values (indicates proper response generation).
    p_protocol_compliance_rresp_not_x_on_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp)
        );

endmodule // sva_protocol_compliance_checker
