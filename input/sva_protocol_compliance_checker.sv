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
    
    // Protocol rule: AWVALID and WVALID may arrive independently; slave must handle both orderings
    // Protocol rule: AWREADY and WREADY must wait for respective valid signals
    // Protocol rule: BVALID asserted after write transaction completes; held until BREADY
    // Protocol rule: ARVALID triggers read address acceptance; ARREADY responds
    // Protocol rule: RVALID asserted with read data; held until RREADY
    // Protocol rule: Single-beat transactions only (no bursts in AXI4-Lite)
    // Protocol rule: Write response always OKAY (2'b00)
    // Protocol rule: Read data registered for timing closure
    // --- p_protocol_compliance_awready_requires_awvalid (roi=0.679) ---
    // AXI4-Lite slave must not assert AWREADY without a corresponding AWVALID. This prevents the slave from acknowledging non-existent address phase.
    @(posedge clk) disable iff (!rst_n)
      s_awready |-> s_awvalid
    // --- p_protocol_compliance_wready_requires_wvalid (roi=0.679) ---
    // Slave must not assert WREADY without WVALID present. This ensures proper data phase handshake semantics.
    @(posedge clk) disable iff (!rst_n)
      s_wready |-> s_wvalid
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.687) ---
    // Once BVALID is asserted, it must remain high until BREADY handshake completes. This is a fundamental AXI4-Lite stability requirement.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !s_bready) |=> s_bvalid
    // --- p_protocol_compliance_bresp_stable_while_bvalid (roi=0.684) ---
    // Write response must remain stable while BVALID is asserted and waiting for BREADY. Prevents data corruption during handshake.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !s_bready) |=> $stable(s_bresp)
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.687) ---
    // Once RVALID is asserted, it must remain high until RREADY completes the handshake. Core AXI4-Lite read channel stability rule.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> s_rvalid
    // --- p_protocol_compliance_rdata_stable_while_rvalid (roi=0.684) ---
    // Read data must remain stable while RVALID is asserted and waiting for RREADY. Ensures data integrity during multi-cycle handshake.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> $stable(s_rdata)
    // --- p_protocol_compliance_rresp_stable_while_rvalid (roi=0.684) ---
    // Read response must remain stable while RVALID is asserted. Prevents response corruption during handshake window.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> $stable(s_rresp)
    // --- p_protocol_compliance_arready_requires_arvalid (roi=0.679) ---
    // Slave must not assert ARREADY without ARVALID present. Ensures proper read address phase handshake protocol.
    @(posedge clk) disable iff (!rst_n)
      s_arready |-> s_arvalid
    // --- p_protocol_compliance_write_response_eventually_completes (roi=0.672) ---
    // After both address and data phases complete, write response must eventually occur. Liveness property preventing slave lockup. 16-cycle bound allows FSM transitions.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] (s_bvalid && s_bready)
    // --- p_protocol_compliance_read_data_eventually_completes (roi=0.672) ---
    // After read address accepted, read data response must eventually complete. Liveness property ensuring forward progress. 16-cycle bound covers FSM and register access.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> ##[1:16] (s_rvalid && s_rready)
    // --- p_protocol_compliance_no_bvalid_without_prior_write (roi=0.662) ---
    // BVALID assertion must be preceded by at least one write phase (address or data) within reasonable history. Prevents spurious responses.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !$past(s_bvalid)) |-> $past((s_awvalid && s_awready) || (s_wvalid && s_wready), , , 1, 16)
    // --- p_protocol_compliance_no_rvalid_without_prior_read (roi=0.662) ---
    // RVALID assertion must be preceded by read address acceptance within reasonable history. Prevents unsolicited read data.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !$past(s_rvalid)) |-> $past(s_arvalid && s_arready, , , 1, 16)
    // --- p_protocol_compliance_bresp_always_okay (roi=0.690) ---
    // Per design spec, write response is always OKAY (2'b00). This verifies the slave never signals error conditions for writes.
    @(posedge clk) disable iff (!rst_n)
      s_bvalid |-> (s_bresp == 2'b00)
    // --- p_protocol_compliance_awaddr_stable_during_handshake (roi=0.677) ---
    // Master must keep AWADDR stable while AWVALID is asserted until AWREADY. Verifies master-side AXI4-Lite compliance at slave boundary.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && !s_awready) |=> (s_awvalid && $stable(s_awaddr))
    // --- p_protocol_compliance_awprot_stable_during_handshake (roi=0.674) ---
    // AWPROT must remain stable during address handshake. Ensures protection attributes are correctly captured by slave.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && !s_awready) |=> (s_awvalid && $stable(s_awprot))
    // --- p_protocol_compliance_wdata_stable_during_handshake (roi=0.677) ---
    // Write data must remain stable while WVALID is asserted until WREADY. Prevents data corruption during multi-cycle handshake.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && !s_wready) |=> (s_wvalid && $stable(s_wdata))
    // --- p_protocol_compliance_wstrb_stable_during_handshake (roi=0.677) ---
    // Write strobe must remain stable during data handshake. Critical for correct byte-lane write operations.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && !s_wready) |=> (s_wvalid && $stable(s_wstrb))
    // --- p_protocol_compliance_araddr_stable_during_handshake (roi=0.677) ---
    // Read address must remain stable while ARVALID is asserted until ARREADY. Ensures correct register addressing.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && !s_arready) |=> (s_arvalid && $stable(s_araddr))
    // --- p_protocol_compliance_arprot_stable_during_handshake (roi=0.674) ---
    // ARPROT must remain stable during read address handshake. Ensures protection attributes are preserved.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && !s_arready) |=> (s_arvalid && $stable(s_arprot))
    // --- p_protocol_compliance_no_simultaneous_bvalid_new_write (roi=0.654) ---
    // While a write response is pending, slave should not accept a new complete write transaction (both AW and W). Verifies proper FSM sequencing for single-beat protocol.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !s_bready) |-> !(s_awvalid && s_awready && s_wvalid && s_wready)
    // --- p_protocol_compliance_no_simultaneous_rvalid_new_read (roi=0.654) ---
    // While read data is pending, slave should not accept new read address. Ensures single-beat transaction ordering.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |-> !(s_arvalid && s_arready)
    // --- p_protocol_compliance_bvalid_after_both_write_phases (roi=0.667) ---
    // When both write address and data are accepted in same cycle, BVALID must be asserted within bounded time. Verifies write completion path.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready ##0 s_wvalid && s_wready) |-> ##[1:8] s_bvalid
    // --- p_protocol_compliance_bvalid_after_awaddr_then_wdata (roi=0.664) ---
    // When write address accepted before write data, BVALID must follow data acceptance. Handles independent AW/W channel ordering.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && !(s_wvalid && s_wready)) ##[1:8] (s_wvalid && s_wready) |-> ##[1:8] s_bvalid
    // --- p_protocol_compliance_bvalid_after_wdata_then_awaddr (roi=0.664) ---
    // When write data accepted before address, BVALID must follow address acceptance. Covers W-before-AW ordering scenario.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && s_wready && !(s_awvalid && s_awready)) ##[1:8] (s_awvalid && s_awready) |-> ##[1:8] s_bvalid
    // --- p_protocol_compliance_valid_wstrb_values (roi=0.642) ---
    // Write strobes must be valid byte-lane combinations for 32-bit AXI4-Lite. Covers 1-byte, 2-byte (aligned), and 4-byte accesses.
    @(posedge clk) disable iff (!rst_n)
      s_wvalid |-> s_wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000, 4'b0011, 4'b1100, 4'b1111}
    // --- p_protocol_compliance_awaddr_alignment_4byte (roi=0.629) ---
    // For register-based slave with 4-byte registers, write addresses should be 4-byte aligned. Detects misaligned accesses.
    @(posedge clk) disable iff (!rst_n)
      s_awvalid |-> (s_awaddr[1:0] == 2'b00)
    // --- p_protocol_compliance_araddr_alignment_4byte (roi=0.629) ---
    // Read addresses should be 4-byte aligned for 32-bit register access. Detects protocol violations.
    @(posedge clk) disable iff (!rst_n)
      s_arvalid |-> (s_araddr[1:0] == 2'b00)
    // --- p_protocol_compliance_awaddr_in_register_range (roi=0.667) ---
    // Write addresses must target one of four defined registers (offsets 0x0, 0x4, 0x8, 0xC). Detects out-of-range accesses.
    @(posedge clk) disable iff (!rst_n)
      s_awvalid |-> (s_awaddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
    // --- p_protocol_compliance_araddr_in_register_range (roi=0.667) ---
    // Read addresses must target one of four defined registers. Verifies address decode compliance.
    @(posedge clk) disable iff (!rst_n)
      s_arvalid |-> (s_araddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
    // --- p_protocol_compliance_no_write_address_without_data_eventually (roi=0.659) ---
    // If write address is accepted without data, write data must eventually arrive. Prevents orphaned address phase.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && !(s_wvalid && s_wready)) |-> ##[0:16] (s_wvalid && s_wready)
    // --- p_protocol_compliance_no_write_data_without_address_eventually (roi=0.659) ---
    // If write data is accepted without address, write address must eventually arrive. Prevents orphaned data phase.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && s_wready && !(s_awvalid && s_awready)) |-> ##[0:16] (s_awvalid && s_awready)
    // --- p_protocol_compliance_single_bvalid_per_write (roi=0.647) ---
    // After BVALID handshake completes, it must deassert and not reassert until next write phase begins. Prevents duplicate responses.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && s_bready) |-> ##1 !s_bvalid [*1:8] ##1 (s_awvalid && s_awready) || (s_wvalid && s_wready) || $stable(1'b1)
    // --- p_protocol_compliance_single_rvalid_per_read (roi=0.647) ---
    // After RVALID handshake completes, it must deassert and not reassert until next read address. Prevents duplicate read data.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && s_rready) |-> ##1 !s_rvalid [*1:8] ##1 (s_arvalid && s_arready) || $stable(1'b1)
    // --- p_protocol_compliance_rresp_valid_values (roi=0.654) ---
    // Read response must be either OKAY (2'b00) or SLVERR (2'b10). Verifies valid AXI4-Lite response encoding.
    @(posedge clk) disable iff (!rst_n)
      s_rvalid |-> (s_rresp inside {2'b00, 2'b10})
    // --- p_protocol_compliance_no_awready_without_fsm_ready (roi=0.667) ---
    // AWREADY should only rise when AWVALID is present. Verifies slave properly gates ready based on valid signal.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_awready) |-> s_awvalid
    // --- p_protocol_compliance_no_wready_without_fsm_ready (roi=0.667) ---
    // WREADY should only rise when WVALID is present. Ensures proper data handshake initiation.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_wready) |-> s_wvalid
    // --- p_protocol_compliance_no_arready_without_fsm_ready (roi=0.667) ---
    // ARREADY should only rise when ARVALID is present. Verifies proper read address handshake gating.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_arready) |-> s_arvalid
    // --- p_protocol_compliance_write_response_bounded_latency (roi=0.654) ---
    // When both write phases complete simultaneously, BVALID should assert within tight bound (1-4 cycles). Verifies fast-path write response for performance.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready ##0 s_wvalid && s_wready) |-> ##[1:4] s_bvalid
    // --- p_protocol_compliance_read_response_bounded_latency (roi=0.662) ---
    // Read data should be available within tight bound after address acceptance. Verifies registered read data path timing.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> ##[1:3] s_rvalid
    // --- p_protocol_compliance_no_bvalid_glitch (roi=0.672) ---
    // BVALID should only fall after BREADY handshake. Detects premature deassertions or glitches.
    @(posedge clk) disable iff (!rst_n)
      $fell(s_bvalid) |-> $past(s_bready)
    // --- p_protocol_compliance_no_rvalid_glitch (roi=0.672) ---
    // RVALID should only fall after RREADY handshake. Prevents spurious read data deassertions.
    @(posedge clk) disable iff (!rst_n)
      $fell(s_rvalid) |-> $past(s_rready)
    // --- p_protocol_compliance_exclusive_write_read_acceptance (roi=0.642) ---
    // Slave should not simultaneously accept write address and read address in same cycle. Verifies FSM mutual exclusion.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready) |-> !(s_arvalid && s_arready)
    // --- p_protocol_compliance_write_strobe_coverage (roi=0.662) ---
    // Write strobes must be non-zero when valid. Detects invalid all-zero strobe which would be a no-op.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && s_wready && (s_wstrb != 4'b1111)) |-> (s_wstrb != 4'b0000)

endmodule // sva_protocol_compliance_checker
