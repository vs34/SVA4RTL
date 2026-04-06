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
    // --- p_protocol_compliance_awready_waits_for_awvalid (roi=0.679) ---
    // AXI4-Lite protocol requires AWREADY must not be asserted unless AWVALID is asserted. Slave cannot initiate handshake.
    @(posedge clk) disable iff (!rst_n)
      !s_awvalid |-> !s_awready
    // --- p_protocol_compliance_wready_waits_for_wvalid (roi=0.679) ---
    // AXI4-Lite protocol requires WREADY must not be asserted unless WVALID is asserted. Slave cannot initiate handshake.
    @(posedge clk) disable iff (!rst_n)
      !s_wvalid |-> !s_wready
    // --- p_protocol_compliance_arready_waits_for_arvalid (roi=0.679) ---
    // AXI4-Lite protocol requires ARREADY must not be asserted unless ARVALID is asserted. Slave cannot initiate handshake.
    @(posedge clk) disable iff (!rst_n)
      !s_arvalid |-> !s_arready
    // --- p_protocol_compliance_bvalid_held_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BVALID once asserted must remain high until BREADY handshake occurs. Ensures stable write response.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !s_bready) |=> s_bvalid
    // --- p_protocol_compliance_rvalid_held_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RVALID once asserted must remain high until RREADY handshake occurs. Ensures stable read data.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> s_rvalid
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BRESP must remain stable while BVALID is asserted and BREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && !s_bready) |=> $stable(s_bresp)
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RDATA must remain stable while RVALID is asserted and RREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> $stable(s_rdata)
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RRESP must remain stable while RVALID is asserted and RREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && !s_rready) |=> $stable(s_rresp)
    // --- p_protocol_compliance_write_response_always_okay (roi=0.667) ---
    // Design specification states write response is always OKAY (2'b00). Verifies correct constant response generation.
    @(posedge clk) disable iff (!rst_n)
      s_bvalid |-> (s_bresp == 2'b00)
    // --- p_protocol_compliance_bvalid_eventually_after_write_complete (roi=0.654) ---
    // Liveness property: After both AW and W channels complete simultaneously, BVALID must eventually be asserted within reasonable time (10 cycles).
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:10] s_bvalid
    // --- p_protocol_compliance_bvalid_eventually_after_aw_then_w (roi=0.654) ---
    // Liveness property: After AW completes first, then W completes, BVALID must eventually be asserted within 10 cycles.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && !s_wvalid) ##[0:$] (s_wvalid && s_wready) |-> ##[1:10] s_bvalid
    // --- p_protocol_compliance_bvalid_eventually_after_w_then_aw (roi=0.654) ---
    // Liveness property: After W completes first, then AW completes, BVALID must eventually be asserted within 10 cycles. Handles independent arrival ordering.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && s_wready && !s_awvalid) ##[0:$] (s_awvalid && s_awready) |-> ##[1:10] s_bvalid
    // --- p_protocol_compliance_rvalid_eventually_after_read_addr (roi=0.654) ---
    // Liveness property: After read address handshake, RVALID must eventually be asserted within 10 cycles. Ensures forward progress.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> ##[1:10] s_rvalid
    // --- p_protocol_compliance_no_bvalid_without_prior_write (roi=0.642) ---
    // Safety property: BVALID cannot appear without a prior complete write transaction (both AW and W channels). Prevents spurious responses.
    @(posedge clk) disable iff (!rst_n)
      !s_bvalid throughout (##1 s_bvalid) |-> ##[0:$] (s_awvalid && s_awready) && ##[0:$] (s_wvalid && s_wready)
    // --- p_protocol_compliance_no_rvalid_without_prior_read (roi=0.642) ---
    // Safety property: A new RVALID assertion requires a prior read address handshake. Prevents spurious read data.
    @(posedge clk) disable iff (!rst_n)
      $fell(s_rvalid) ##1 s_rvalid |-> (s_arvalid && s_arready)[->1]
    // --- p_protocol_compliance_awaddr_stable_during_awvalid (roi=0.679) ---
    // AXI4-Lite protocol requires AWADDR must remain stable while AWVALID is high and AWREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && !s_awready) |=> (s_awvalid && $stable(s_awaddr))
    // --- p_protocol_compliance_awprot_stable_during_awvalid (roi=0.679) ---
    // AXI4-Lite protocol requires AWPROT must remain stable while AWVALID is high and AWREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && !s_awready) |=> (s_awvalid && $stable(s_awprot))
    // --- p_protocol_compliance_wdata_stable_during_wvalid (roi=0.679) ---
    // AXI4-Lite protocol requires WDATA must remain stable while WVALID is high and WREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && !s_wready) |=> (s_wvalid && $stable(s_wdata))
    // --- p_protocol_compliance_wstrb_stable_during_wvalid (roi=0.679) ---
    // AXI4-Lite protocol requires WSTRB must remain stable while WVALID is high and WREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && !s_wready) |=> (s_wvalid && $stable(s_wstrb))
    // --- p_protocol_compliance_araddr_stable_during_arvalid (roi=0.679) ---
    // AXI4-Lite protocol requires ARADDR must remain stable while ARVALID is high and ARREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && !s_arready) |=> (s_arvalid && $stable(s_araddr))
    // --- p_protocol_compliance_arprot_stable_during_arvalid (roi=0.679) ---
    // AXI4-Lite protocol requires ARPROT must remain stable while ARVALID is high and ARREADY is low.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && !s_arready) |=> (s_arvalid && $stable(s_arprot))
    // --- p_protocol_compliance_no_simultaneous_bvalid_rvalid_from_idle (roi=0.629) ---
    // Safety property: Both BVALID and RVALID should not rise simultaneously from idle state, as they serve independent read/write paths.
    @(posedge clk) disable iff (!rst_n)
      (!s_bvalid && !s_rvalid) |-> ##1 !(s_bvalid && s_rvalid && $rose(s_bvalid) && $rose(s_rvalid))
    // --- p_protocol_compliance_single_beat_write_one_bvalid (roi=0.642) ---
    // AXI4-Lite single-beat transaction: One write produces exactly one BVALID response that completes and deasserts. Prevents multiple responses.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:$] (s_bvalid && s_bready)[->1] ##1 !s_bvalid[*1:10]
    // --- p_protocol_compliance_single_beat_read_one_rvalid (roi=0.642) ---
    // AXI4-Lite single-beat transaction: One read produces exactly one RVALID response that completes and deasserts. Prevents multiple responses.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> ##[1:$] (s_rvalid && s_rready)[->1] ##1 !s_rvalid[*1:10]
    // --- p_protocol_compliance_aligned_write_address_4bytes (roi=0.654) ---
    // Design has 4 registers at 4-byte boundaries (0x00, 0x04, 0x08, 0x0C). Write addresses should be 4-byte aligned for proper register access.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready) |-> (s_awaddr[1:0] == 2'b00)
    // --- p_protocol_compliance_aligned_read_address_4bytes (roi=0.654) ---
    // Design has 4 registers at 4-byte boundaries (0x00, 0x04, 0x08, 0x0C). Read addresses should be 4-byte aligned for proper register access.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> (s_araddr[1:0] == 2'b00)
    // --- p_protocol_compliance_valid_write_address_range (roi=0.667) ---
    // Design implements exactly 4 registers at offsets 0x00, 0x04, 0x08, 0x0C. Valid write addresses must target these locations only.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready) |-> (s_awaddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
    // --- p_protocol_compliance_valid_read_address_range (roi=0.667) ---
    // Design implements exactly 4 registers at offsets 0x00, 0x04, 0x08, 0x0C. Valid read addresses must target these locations only.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> (s_araddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
    // --- p_protocol_compliance_wstrb_valid_encoding (roi=0.654) ---
    // Write strobe must have at least one bit set during valid write. All-zero strobe is invalid as it indicates no bytes written.
    @(posedge clk) disable iff (!rst_n)
      (s_wvalid && s_wready) |-> (s_wstrb != 4'b0000)
    // --- p_protocol_compliance_no_awready_pulse_without_awvalid (roi=0.667) ---
    // Safety property: AWREADY cannot rise without AWVALID being present. Prevents illegal handshake initiation by slave.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_awready) |-> s_awvalid
    // --- p_protocol_compliance_no_wready_pulse_without_wvalid (roi=0.667) ---
    // Safety property: WREADY cannot rise without WVALID being present. Prevents illegal handshake initiation by slave.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_wready) |-> s_wvalid
    // --- p_protocol_compliance_no_arready_pulse_without_arvalid (roi=0.667) ---
    // Safety property: ARREADY cannot rise without ARVALID being present. Prevents illegal handshake initiation by slave.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_arready) |-> s_arvalid
    // --- p_protocol_compliance_bvalid_clears_after_handshake (roi=0.667) ---
    // After write response handshake completes, BVALID must deassert in next cycle. Prevents stuck BVALID.
    @(posedge clk) disable iff (!rst_n)
      (s_bvalid && s_bready) |=> !s_bvalid
    // --- p_protocol_compliance_rvalid_clears_after_handshake (roi=0.667) ---
    // After read data handshake completes, RVALID must deassert in next cycle. Prevents stuck RVALID.
    @(posedge clk) disable iff (!rst_n)
      (s_rvalid && s_rready) |=> !s_rvalid
    // --- p_protocol_compliance_no_new_write_during_active_write (roi=0.629) ---
    // Safety property: During active write transaction (after AW accepted, before B completes), no new write address should be accepted. Single outstanding transaction only.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready) ##1 (!s_bvalid || !s_bready)[*0:$] ##0 s_bvalid |-> !s_awvalid throughout (##1 s_bvalid && s_bready)
    // --- p_protocol_compliance_no_new_read_during_active_read (roi=0.629) ---
    // Safety property: During active read transaction (after AR accepted, before R completes), no new read address should be accepted. Single outstanding transaction only.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) ##1 (!s_rvalid || !s_rready)[*0:$] ##0 s_rvalid |-> !s_arvalid throughout (##1 s_rvalid && s_rready)
    // --- p_protocol_compliance_write_data_before_response (roi=0.654) ---
    // Safety property: BVALID can only appear after write data has been accepted (W handshake occurred). Ensures proper transaction ordering.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_bvalid) |-> (s_wvalid && s_wready)[->1] ##[0:$] 1
    // --- p_protocol_compliance_write_addr_before_response (roi=0.654) ---
    // Safety property: BVALID can only appear after write address has been accepted (AW handshake occurred). Ensures proper transaction ordering.
    @(posedge clk) disable iff (!rst_n)
      $rose(s_bvalid) |-> (s_awvalid && s_awready)[->1] ##[0:$] 1
    // --- p_protocol_compliance_rresp_always_okay_or_slverr (roi=0.654) ---
    // AXI4-Lite read responses must be either OKAY (2'b00) or SLVERR (2'b10). No burst responses like EXOKAY allowed.
    @(posedge clk) disable iff (!rst_n)
      s_rvalid |-> (s_rresp inside {2'b00, 2'b10})
    // --- p_protocol_compliance_bvalid_not_during_reset (roi=0.667) ---
    // Safety property: When reset is active (rst_n low), BVALID must be deasserted. Verified through disable iff mechanism.
    @(posedge clk) disable iff (!rst_n)
      1 |-> !s_bvalid
    // --- p_protocol_compliance_rvalid_not_during_reset (roi=0.667) ---
    // Safety property: When reset is active (rst_n low), RVALID must be deasserted. Verified through disable iff mechanism.
    @(posedge clk) disable iff (!rst_n)
      1 |-> !s_rvalid
    // --- p_protocol_compliance_awready_not_during_reset (roi=0.667) ---
    // Safety property: When reset is active (rst_n low), AWREADY must be deasserted to prevent accepting transactions.
    @(posedge clk) disable iff (!rst_n)
      1 |-> !s_awready
    // --- p_protocol_compliance_wready_not_during_reset (roi=0.667) ---
    // Safety property: When reset is active (rst_n low), WREADY must be deasserted to prevent accepting transactions.
    @(posedge clk) disable iff (!rst_n)
      1 |-> !s_wready
    // --- p_protocol_compliance_arready_not_during_reset (roi=0.667) ---
    // Safety property: When reset is active (rst_n low), ARREADY must be deasserted to prevent accepting transactions.
    @(posedge clk) disable iff (!rst_n)
      1 |-> !s_arready
    // --- p_protocol_compliance_max_write_latency_bound (roi=0.617) ---
    // Liveness property: Write transaction must complete within bounded time (100 cycles) to prevent deadlock. Ensures system liveness.
    @(posedge clk) disable iff (!rst_n)
      (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:100] (s_bvalid && s_bready)
    // --- p_protocol_compliance_max_read_latency_bound (roi=0.617) ---
    // Liveness property: Read transaction must complete within bounded time (100 cycles) to prevent deadlock. Ensures system liveness.
    @(posedge clk) disable iff (!rst_n)
      (s_arvalid && s_arready) |-> ##[1:100] (s_rvalid && s_rready)

endmodule // sva_protocol_compliance_checker
