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
    // AXI4-Lite protocol requires AWVALID to remain asserted until AWREADY is observed high. This is a fundamental handshake stability requirement.
    p_protocol_compliance_awvalid_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> s_awvalid
        );
    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY is observed high. This ensures write data channel handshake stability.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARVALID to remain asserted until ARREADY is observed high. This is a fundamental read address handshake stability requirement.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BVALID to remain asserted until BREADY is observed high. This ensures write response channel handshake stability.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RVALID to remain asserted until RREADY is observed high. This ensures read data channel handshake stability.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_awaddr_stable_during_awvalid (roi=0.667) ---
    // AXI4-Lite protocol requires AWADDR to remain stable while AWVALID is asserted and AWREADY is not yet sampled high.
    p_protocol_compliance_awaddr_stable_during_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awaddr)
        );
    // --- p_protocol_compliance_awprot_stable_during_awvalid (roi=0.667) ---
    // AXI4-Lite protocol requires AWPROT to remain stable while AWVALID is asserted and AWREADY is not yet sampled high.
    p_protocol_compliance_awprot_stable_during_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awprot)
        );
    // --- p_protocol_compliance_wdata_stable_during_wvalid (roi=0.667) ---
    // AXI4-Lite protocol requires WDATA to remain stable while WVALID is asserted and WREADY is not yet sampled high.
    p_protocol_compliance_wdata_stable_during_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_during_wvalid (roi=0.667) ---
    // AXI4-Lite protocol requires WSTRB to remain stable while WVALID is asserted and WREADY is not yet sampled high.
    p_protocol_compliance_wstrb_stable_during_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_araddr_stable_during_arvalid (roi=0.667) ---
    // AXI4-Lite protocol requires ARADDR to remain stable while ARVALID is asserted and ARREADY is not yet sampled high.
    p_protocol_compliance_araddr_stable_during_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_during_arvalid (roi=0.667) ---
    // AXI4-Lite protocol requires ARPROT to remain stable while ARVALID is asserted and ARREADY is not yet sampled high.
    p_protocol_compliance_arprot_stable_during_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_bresp_stable_during_bvalid (roi=0.667) ---
    // AXI4-Lite protocol requires BRESP to remain stable while BVALID is asserted and BREADY is not yet sampled high.
    p_protocol_compliance_bresp_stable_during_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_rdata_stable_during_rvalid (roi=0.667) ---
    // AXI4-Lite protocol requires RDATA to remain stable while RVALID is asserted and RREADY is not yet sampled high.
    p_protocol_compliance_rdata_stable_during_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_during_rvalid (roi=0.667) ---
    // AXI4-Lite protocol requires RRESP to remain stable while RVALID is asserted and RREADY is not yet sampled high.
    p_protocol_compliance_rresp_stable_during_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_eventually_after_write (roi=0.654) ---
    // Liveness property: After both write address and write data handshakes complete, the slave must eventually assert BVALID within a reasonable bounded time (16 cycles assumed).
    p_protocol_compliance_bvalid_eventually_after_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_eventually_after_read (roi=0.654) ---
    // Liveness property: After read address handshake completes, the slave must eventually assert RVALID within a reasonable bounded time (16 cycles assumed).
    p_protocol_compliance_rvalid_eventually_after_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid
        );
    // --- p_protocol_compliance_no_bvalid_without_prior_write (roi=0.617) ---
    // Safety property: BVALID should not assert unless there was a prior write handshake or BVALID was already asserted (preventing spurious responses).
    p_protocol_compliance_no_bvalid_without_prior_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!$past(s_awvalid && s_awready, 1, 1) && !$past(s_wvalid && s_wready, 1, 1) && !$past(s_bvalid, 1, 1)) |-> !s_bvalid
        );
    // --- p_protocol_compliance_no_rvalid_without_prior_read (roi=0.617) ---
    // Safety property: RVALID should not assert unless there was a prior read address handshake or RVALID was already asserted (preventing spurious read data).
    p_protocol_compliance_no_rvalid_without_prior_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!$past(s_arvalid && s_arready, 1, 1) && !$past(s_rvalid, 1, 1)) |-> !s_rvalid
        );
    // --- p_protocol_compliance_bvalid_deasserts_after_bready (roi=0.642) ---
    // After write response handshake completes, BVALID should deassert (either immediately or stay low), unless a new write response is ready.
    p_protocol_compliance_bvalid_deasserts_after_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid [*0:1]
        );
    // --- p_protocol_compliance_rvalid_deasserts_after_rready (roi=0.642) ---
    // After read data handshake completes, RVALID should deassert (either immediately or stay low), unless a new read response is ready.
    p_protocol_compliance_rvalid_deasserts_after_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid [*0:1]
        );
    // --- p_protocol_compliance_write_response_after_both_aw_w (roi=0.654) ---
    // When both AW and W channels complete handshake simultaneously, a write response must eventually be generated within bounded time.
    p_protocol_compliance_write_response_after_both_aw_w: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready ##0 s_wvalid && s_wready) |-> ##[0:16] s_bvalid
        );
    // --- p_protocol_compliance_write_response_after_aw_then_w (roi=0.654) ---
    // When AW handshake completes before W handshake, a write response must eventually be generated within bounded time after W completes.
    p_protocol_compliance_write_response_after_aw_then_w: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready ##[1:$] s_wvalid && s_wready) |-> ##[0:16] s_bvalid
        );
    // --- p_protocol_compliance_write_response_after_w_then_aw (roi=0.654) ---
    // When W handshake completes before AW handshake, a write response must eventually be generated within bounded time after AW completes.
    p_protocol_compliance_write_response_after_w_then_aw: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready ##[1:$] s_awvalid && s_awready) |-> ##[0:16] s_bvalid
        );
    // --- p_protocol_compliance_no_awready_without_awvalid (roi=0.629) ---
    // Safety property: AWREADY should not be asserted when AWVALID is not asserted, following proper AXI handshake semantics (slave does not assert READY without VALID).
    p_protocol_compliance_no_awready_without_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !s_awvalid |-> !s_awready
        );
    // --- p_protocol_compliance_no_wready_without_wvalid (roi=0.629) ---
    // Safety property: WREADY should not be asserted when WVALID is not asserted, following proper AXI handshake semantics.
    p_protocol_compliance_no_wready_without_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !s_wvalid |-> !s_wready
        );
    // --- p_protocol_compliance_no_arready_without_arvalid (roi=0.629) ---
    // Safety property: ARREADY should not be asserted when ARVALID is not asserted, following proper AXI handshake semantics.
    p_protocol_compliance_no_arready_without_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !s_arvalid |-> !s_arready
        );
    // --- p_protocol_compliance_bresp_okay_always (roi=0.667) ---
    // Per design specification, write response is always OKAY (2'b00). This verifies the implementation matches the documented behavior.
    p_protocol_compliance_bresp_okay_always: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> s_bresp == 2'b00
        );
    // --- p_protocol_compliance_rresp_okay_for_valid_addresses (roi=0.654) ---
    // For valid register addresses (0x0, 0x4, 0x8, 0xC), read response should be OKAY. This validates correct address decoding and response generation.
    p_protocol_compliance_rresp_okay_for_valid_addresses: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && ($past(s_araddr[3:0]) inside {4'h0, 4'h4, 4'h8, 4'hC})) |-> s_rresp == 2'b00
        );
    // --- p_protocol_compliance_single_outstanding_write_transaction (roi=0.642) ---
    // AXI4-Lite does not support outstanding transactions. After a write starts, no new write should begin until the response completes.
    p_protocol_compliance_single_outstanding_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready && !s_bvalid) |-> ##1 (!s_awvalid && !s_wvalid) throughout (##[0:$] s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_single_outstanding_read_transaction (roi=0.642) ---
    // AXI4-Lite does not support outstanding transactions. After a read address is accepted, no new read should begin until read data completes.
    p_protocol_compliance_single_outstanding_read_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready && !s_rvalid) |-> ##1 !s_arvalid throughout (##[0:$] s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_awready_must_eventually_assert (roi=0.642) ---
    // Liveness property: If AWVALID is asserted, AWREADY must eventually assert within bounded time to prevent deadlock.
    p_protocol_compliance_awready_must_eventually_assert: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> ##[0:16] (s_awvalid && s_awready)
        );
    // --- p_protocol_compliance_wready_must_eventually_assert (roi=0.642) ---
    // Liveness property: If WVALID is asserted, WREADY must eventually assert within bounded time to prevent deadlock.
    p_protocol_compliance_wready_must_eventually_assert: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> ##[0:16] (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_arready_must_eventually_assert (roi=0.642) ---
    // Liveness property: If ARVALID is asserted, ARREADY must eventually assert within bounded time to prevent deadlock.
    p_protocol_compliance_arready_must_eventually_assert: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> ##[0:16] (s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_bready_eventually_asserts (roi=0.617) ---
    // Liveness assumption on master behavior: If BVALID is asserted, BREADY should eventually assert. While this is a master responsibility, it validates system-level liveness.
    p_protocol_compliance_bready_eventually_asserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> ##[0:32] (s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_rready_eventually_asserts (roi=0.617) ---
    // Liveness assumption on master behavior: If RVALID is asserted, RREADY should eventually assert. While this is a master responsibility, it validates system-level liveness.
    p_protocol_compliance_rready_eventually_asserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> ##[0:32] (s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_write_strobe_validity (roi=0.654) ---
    // Safety property: Write strobe should have at least one bit set when WVALID is asserted, otherwise the write is meaningless.
    p_protocol_compliance_write_strobe_validity: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> s_wstrb != 4'b0000
        );
    // --- p_protocol_compliance_aligned_address_for_word_access (roi=0.629) ---
    // When full word write (all strobes set), address should be word-aligned for proper access to 32-bit registers.
    p_protocol_compliance_aligned_address_for_word_access: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && (s_wstrb == 4'b1111)) |-> s_awaddr[1:0] == 2'b00
        );
    // --- p_protocol_compliance_no_bvalid_and_new_write_same_cycle (roi=0.617) ---
    // In a single-transaction slave, completing a write response and starting a new write in the same cycle may indicate timing or FSM issues.
    p_protocol_compliance_no_bvalid_and_new_write_same_cycle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |-> !(s_awvalid && s_awready && s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_no_rvalid_and_new_read_same_cycle (roi=0.617) ---
    // In a single-transaction slave, completing a read response and starting a new read in the same cycle may indicate timing or FSM issues.
    p_protocol_compliance_no_rvalid_and_new_read_same_cycle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |-> !(s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_write_address_in_valid_range (roi=0.642) ---
    // Write addresses should target one of the four defined registers (0x0, 0x4, 0x8, 0xC). Out-of-range addresses indicate protocol violation or addressing error.
    p_protocol_compliance_write_address_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> s_awaddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC}
        );
    // --- p_protocol_compliance_read_address_in_valid_range (roi=0.642) ---
    // Read addresses should target one of the four defined registers (0x0, 0x4, 0x8, 0xC). Out-of-range addresses indicate protocol violation or addressing error.
    p_protocol_compliance_read_address_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> s_araddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC}
        );
    // --- p_protocol_compliance_no_concurrent_bvalid_rvalid (roi=0.629) ---
    // Safety property: Write response and read data should not be asserted simultaneously in a simple slave with independent read/write FSMs, indicating potential FSM corruption.
    p_protocol_compliance_no_concurrent_bvalid_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !(s_bvalid && s_rvalid)
        );
    // --- p_protocol_compliance_wstrb_lower_byte_alignment (roi=0.617) ---
    // If byte 0 strobe is active, address must be aligned such that byte 0 is accessible (word-aligned for standard 32-bit registers).
    p_protocol_compliance_wstrb_lower_byte_alignment: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wstrb[0]) |-> s_awaddr[1:0] inside {2'b00}
        );
    // --- p_protocol_compliance_control_register_write_strobes (roi=0.654) ---
    // When writing to control register (0x0), at least one strobe bit must be set to perform a meaningful write operation.
    p_protocol_compliance_control_register_write_strobes: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_awaddr[3:0] == 4'h0 && s_wvalid && s_wready) |-> (|s_wstrb)
        );
    // --- p_protocol_compliance_data_reg0_write_strobes (roi=0.654) ---
    // When writing to data register 0 (0x8), at least one strobe bit must be set to perform a meaningful write operation.
    p_protocol_compliance_data_reg0_write_strobes: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_awaddr[3:0] == 4'h8 && s_wvalid && s_wready) |-> (|s_wstrb)
        );
    // --- p_protocol_compliance_data_reg1_write_strobes (roi=0.654) ---
    // When writing to data register 1 (0xC), at least one strobe bit must be set to perform a meaningful write operation.
    p_protocol_compliance_data_reg1_write_strobes: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_awaddr[3:0] == 4'hC && s_wvalid && s_wready) |-> (|s_wstrb)
        );
    // --- p_protocol_compliance_read_only_register_write_attempt (roi=0.654) ---
    // Even when attempting to write to read-only status register (0x4), slave should complete the transaction with OKAY response (write is ignored).
    p_protocol_compliance_read_only_register_write_attempt: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_awaddr[3:0] == 4'h4) |-> ##[0:16] (s_bvalid && s_bresp == 2'b00)
        );
    // --- p_protocol_compliance_multiple_pending_write_phases (roi=0.629) ---
    // After accepting write address but before write data completes, no new write address should be accepted (single outstanding transaction limit).
    p_protocol_compliance_multiple_pending_write_phases: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !(s_wvalid && s_wready)) |-> ##1 !s_awvalid until_with (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_reset_clears_bvalid (roi=0.667) ---
    // After reset deassertion, BVALID should be low, ensuring clean startup state with no pending write responses.
    p_protocol_compliance_reset_clears_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_bvalid
        );
    // --- p_protocol_compliance_reset_clears_rvalid (roi=0.667) ---
    // After reset deassertion, RVALID should be low, ensuring clean startup state with no pending read data.
    p_protocol_compliance_reset_clears_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_rvalid
        );
    // --- p_protocol_compliance_reset_clears_awready (roi=0.654) ---
    // After reset deassertion, AWREADY should be low initially, awaiting FSM to reach ready state.
    p_protocol_compliance_reset_clears_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_awready
        );
    // --- p_protocol_compliance_reset_clears_wready (roi=0.654) ---
    // After reset deassertion, WREADY should be low initially, awaiting FSM to reach ready state.
    p_protocol_compliance_reset_clears_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_wready
        );
    // --- p_protocol_compliance_reset_clears_arready (roi=0.654) ---
    // After reset deassertion, ARREADY should be low initially, awaiting FSM to reach ready state.
    p_protocol_compliance_reset_clears_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_arready
        );

endmodule // sva_protocol_compliance_checker
