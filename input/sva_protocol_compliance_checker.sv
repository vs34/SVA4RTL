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

    // --- p_protocol_compliance_awvalid_stable_until_awready (roi=0.487) ---
    // AXI4-Lite requires AWVALID remain asserted until AWREADY is sampled high. This ensures master doesn't withdraw the write address request prematurely.
    p_protocol_compliance_awvalid_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> s_awvalid;
        );
    // --- p_protocol_compliance_awaddr_stable_until_awready (roi=0.487) ---
    // AXI4-Lite requires AWADDR remain stable while AWVALID is high and AWREADY is low. Address must not change during handshake.
    p_protocol_compliance_awaddr_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awaddr);
        );
    // --- p_protocol_compliance_awprot_stable_until_awready (roi=0.487) ---
    // AXI4-Lite requires AWPROT remain stable while AWVALID is high and AWREADY is low. Protection attributes must not change during handshake.
    p_protocol_compliance_awprot_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awprot);
        );
    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.487) ---
    // AXI4-Lite requires WVALID remain asserted until WREADY is sampled high. This ensures master doesn't withdraw the write data prematurely.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid;
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.487) ---
    // AXI4-Lite requires WDATA remain stable while WVALID is high and WREADY is low. Write data must not change during handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata);
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.487) ---
    // AXI4-Lite requires WSTRB remain stable while WVALID is high and WREADY is low. Write strobes must not change during handshake.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb);
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.487) ---
    // AXI4-Lite requires BVALID remain asserted until BREADY is sampled high. Slave must not withdraw write response prematurely.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid;
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.487) ---
    // AXI4-Lite requires BRESP remain stable while BVALID is high and BREADY is low. Write response must not change during handshake.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp);
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.487) ---
    // AXI4-Lite requires ARVALID remain asserted until ARREADY is sampled high. Master must not withdraw read address request prematurely.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid;
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.487) ---
    // AXI4-Lite requires ARADDR remain stable while ARVALID is high and ARREADY is low. Read address must not change during handshake.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr);
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.487) ---
    // AXI4-Lite requires ARPROT remain stable while ARVALID is high and ARREADY is low. Read protection attributes must not change during handshake.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot);
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.487) ---
    // AXI4-Lite requires RVALID remain asserted until RREADY is sampled high. Slave must not withdraw read data prematurely.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid;
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.487) ---
    // AXI4-Lite requires RDATA remain stable while RVALID is high and RREADY is low. Read data must not change during handshake.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata);
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.487) ---
    // AXI4-Lite requires RRESP remain stable while RVALID is high and RREADY is low. Read response must not change during handshake.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp);
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.495) ---
    // Design specification states BRESP always returns OKAY (2'b00). Slave never generates error responses for writes.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00);
        );
    // --- p_protocol_compliance_rresp_always_okay (roi=0.475) ---
    // For consistent slave behavior, read responses should also return OKAY. Slave supports all address ranges and never errors.
    p_protocol_compliance_rresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> (s_rresp == 2'b00);
        );
    // --- p_protocol_compliance_bvalid_requires_prior_awvalid_wvalid (roi=0.463) ---
    // Write response can only be issued after both write address and write data have been accepted. BVALID must not assert without prior AWVALID and WVALID handshakes.
    p_protocol_compliance_bvalid_requires_prior_awvalid_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_awvalid && s_awready, 1, 1) || $past(s_wvalid && s_wready, 1, 1) || ($past(s_awvalid) && $past(s_wvalid));
        );
    // --- p_protocol_compliance_rvalid_requires_prior_arvalid (roi=0.475) ---
    // Read response can only be issued after read address has been accepted. RVALID must not assert without prior ARVALID handshake.
    p_protocol_compliance_rvalid_requires_prior_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_rvalid) |-> $past(s_arvalid && s_arready, 1, 1);
        );
    // --- p_protocol_compliance_bvalid_eventually_deasserts (roi=0.438) ---
    // Liveness property: if slave asserts BVALID, master should eventually assert BREADY within reasonable time (16 cycles). Prevents deadlock.
    p_protocol_compliance_bvalid_eventually_deasserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> strong(##[0:15] s_bready);
        );
    // --- p_protocol_compliance_rvalid_eventually_deasserts (roi=0.438) ---
    // Liveness property: if slave asserts RVALID, master should eventually assert RREADY within reasonable time (16 cycles). Prevents deadlock.
    p_protocol_compliance_rvalid_eventually_deasserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> strong(##[0:15] s_rready);
        );
    // --- p_protocol_compliance_no_bvalid_without_write_transaction (roi=0.450) ---
    // Safety property: BVALID cannot spontaneously assert without a preceding write transaction (AWVALID or WVALID within last 16 cycles).
    // SKIPPED (unsupported operator): p_protocol_compliance_no_bvalid_without_write_transaction
    // p_protocol_compliance_no_bvalid_without_write_transaction: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           !s_bvalid throughout (##1 $rose(s_bvalid)) |-> $past((s_awvalid || s_wvalid), 1, 16);
    //     );
    // --- p_protocol_compliance_no_rvalid_without_read_transaction (roi=0.450) ---
    // Safety property: RVALID cannot spontaneously assert without a preceding read transaction (ARVALID within last 16 cycles).
    // SKIPPED (unsupported operator): p_protocol_compliance_no_rvalid_without_read_transaction
    // p_protocol_compliance_no_rvalid_without_read_transaction: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           !s_rvalid throughout (##1 $rose(s_rvalid)) |-> $past(s_arvalid, 1, 16);
    //     );
    // --- p_protocol_compliance_bvalid_clears_after_bready (roi=0.480) ---
    // After write response handshake completes, BVALID must deassert in the next cycle. Ensures single-beat transaction semantics.
    p_protocol_compliance_bvalid_clears_after_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid;
        );
    // --- p_protocol_compliance_rvalid_clears_after_rready (roi=0.480) ---
    // After read response handshake completes, RVALID must deassert in the next cycle. Ensures single-beat transaction semantics.
    p_protocol_compliance_rvalid_clears_after_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid;
        );
    // --- p_protocol_compliance_awready_deasserts_after_handshake (roi=0.463) ---
    // After accepting write address, AWREADY should deassert unless new AWVALID arrives. Prevents accepting phantom addresses.
    p_protocol_compliance_awready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready || s_awvalid;
        );
    // --- p_protocol_compliance_wready_deasserts_after_handshake (roi=0.463) ---
    // After accepting write data, WREADY should deassert unless new WVALID arrives. Prevents accepting phantom data.
    p_protocol_compliance_wready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready || s_wvalid;
        );
    // --- p_protocol_compliance_arready_deasserts_after_handshake (roi=0.463) ---
    // After accepting read address, ARREADY should deassert unless new ARVALID arrives. Prevents accepting phantom addresses.
    p_protocol_compliance_arready_deasserts_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready || s_arvalid;
        );
    // --- p_protocol_compliance_write_response_bounded_latency (roi=0.455) ---
    // After both write address and data are accepted simultaneously, slave should issue write response within 8 cycles. Ensures bounded response latency.
    p_protocol_compliance_write_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:8] s_bvalid;
        );
    // --- p_protocol_compliance_read_response_bounded_latency (roi=0.463) ---
    // After read address is accepted, slave should issue read response within 8 cycles. Ensures bounded read latency.
    p_protocol_compliance_read_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:8] s_rvalid;
        );
    // --- p_protocol_compliance_no_double_bvalid (roi=0.475) ---
    // Safety property: BVALID cannot re-assert while already high and waiting for BREADY. Prevents duplicate responses.
    p_protocol_compliance_no_double_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> ##1 !$rose(s_bvalid);
        );
    // --- p_protocol_compliance_no_double_rvalid (roi=0.475) ---
    // Safety property: RVALID cannot re-assert while already high and waiting for RREADY. Prevents duplicate responses.
    p_protocol_compliance_no_double_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> ##1 !$rose(s_rvalid);
        );
    // --- p_protocol_compliance_wstrb_valid_when_wvalid (roi=0.470) ---
    // When write data is valid, at least one byte strobe must be active. All-zero strobes would be a meaningless write.
    p_protocol_compliance_wstrb_valid_when_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb != 4'b0000);
        );
    // --- p_protocol_compliance_awaddr_word_aligned_check (roi=0.468) ---
    // AXI4-Lite with 32-bit data typically requires word-aligned addresses. Check that bottom 2 bits are zero for proper register access.
    p_protocol_compliance_awaddr_word_aligned_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_araddr_word_aligned_check (roi=0.468) ---
    // AXI4-Lite with 32-bit data typically requires word-aligned addresses. Check that bottom 2 bits are zero for proper register access.
    p_protocol_compliance_araddr_word_aligned_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_awaddr_in_valid_range (roi=0.463) ---
    // Design has 4 registers at offsets 0x00, 0x04, 0x08, 0x0C. Write addresses should be within 16-byte range (upper 28 bits zero).
    p_protocol_compliance_awaddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[31:4] == 28'h0000000);
        );
    // --- p_protocol_compliance_araddr_in_valid_range (roi=0.463) ---
    // Design has 4 registers at offsets 0x00, 0x04, 0x08, 0x0C. Read addresses should be within 16-byte range (upper 28 bits zero).
    p_protocol_compliance_araddr_in_valid_range: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[31:4] == 28'h0000000);
        );
    // --- p_protocol_compliance_no_simultaneous_read_write_response (roi=0.450) ---
    // Safety property: slave should not simultaneously start both read and write responses in the same cycle. Indicates FSM corruption.
    p_protocol_compliance_no_simultaneous_read_write_response: assert property (
            @(posedge clk) disable iff (!rst_n)
              !(s_bvalid && s_rvalid && $rose(s_bvalid) && $rose(s_rvalid));
        );
    // --- p_protocol_compliance_bvalid_not_before_both_accepted (roi=0.458) ---
    // Write response validity check: both AW and W channels must have completed handshake within last 8 cycles before BVALID asserts.
    p_protocol_compliance_bvalid_not_before_both_accepted: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready, 1, 8) && $past(s_wvalid && s_wready, 1, 8);
        );
    // --- p_protocol_compliance_awready_not_when_bvalid_pending (roi=0.445) ---
    // Slave should not accept new write address while previous write response is pending. Ensures transaction ordering.
    p_protocol_compliance_awready_not_when_bvalid_pending: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !s_awready;
        );
    // --- p_protocol_compliance_wready_not_when_bvalid_pending (roi=0.445) ---
    // Slave should not accept new write data while previous write response is pending. Ensures transaction ordering.
    p_protocol_compliance_wready_not_when_bvalid_pending: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !s_wready;
        );
    // --- p_protocol_compliance_arready_not_when_rvalid_pending (roi=0.445) ---
    // Slave should not accept new read address while previous read response is pending. Ensures transaction ordering.
    p_protocol_compliance_arready_not_when_rvalid_pending: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> !s_arready;
        );
    // --- p_protocol_compliance_independent_aw_w_acceptance (roi=0.425) ---
    // Write address can be accepted independently of write data. This property documents the independence requirement.
    p_protocol_compliance_independent_aw_w_acceptance: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) |=> 1'b1;
        );
    // --- p_protocol_compliance_independent_w_aw_acceptance (roi=0.425) ---
    // Write data can be accepted independently of write address. This property documents the independence requirement.
    p_protocol_compliance_independent_w_aw_acceptance: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) |=> 1'b1;
        );
    // --- p_protocol_compliance_reset_clears_bvalid (roi=0.487) ---
    // During reset, BVALID must be deasserted. Ensures clean reset state for write response channel.
    p_protocol_compliance_reset_clears_bvalid: assert property (
            @(posedge clk)
              !rst_n |-> !s_bvalid;
        );
    // --- p_protocol_compliance_reset_clears_rvalid (roi=0.487) ---
    // During reset, RVALID must be deasserted. Ensures clean reset state for read response channel.
    p_protocol_compliance_reset_clears_rvalid: assert property (
            @(posedge clk)
              !rst_n |-> !s_rvalid;
        );
    // --- p_protocol_compliance_reset_clears_awready (roi=0.480) ---
    // During reset, AWREADY must be deasserted. Slave should not accept write addresses while in reset.
    p_protocol_compliance_reset_clears_awready: assert property (
            @(posedge clk)
              !rst_n |-> !s_awready;
        );
    // --- p_protocol_compliance_reset_clears_wready (roi=0.480) ---
    // During reset, WREADY must be deasserted. Slave should not accept write data while in reset.
    p_protocol_compliance_reset_clears_wready: assert property (
            @(posedge clk)
              !rst_n |-> !s_wready;
        );
    // --- p_protocol_compliance_reset_clears_arready (roi=0.480) ---
    // During reset, ARREADY must be deasserted. Slave should not accept read addresses while in reset.
    p_protocol_compliance_reset_clears_arready: assert property (
            @(posedge clk)
              !rst_n |-> !s_arready;
        );
    // --- p_protocol_compliance_single_cycle_aw_handshake_possible (roi=0.412) ---
    // Documents that single-cycle AW handshake is legal. When both AWVALID and AWREADY are high, transaction completes.
    p_protocol_compliance_single_cycle_aw_handshake_possible: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> 1'b1;
        );
    // --- p_protocol_compliance_single_cycle_w_handshake_possible (roi=0.412) ---
    // Documents that single-cycle W handshake is legal. When both WVALID and WREADY are high, transaction completes.
    p_protocol_compliance_single_cycle_w_handshake_possible: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |-> 1'b1;
        );
    // --- p_protocol_compliance_single_cycle_b_handshake_possible (roi=0.412) ---
    // Documents that single-cycle B handshake is legal. When both BVALID and BREADY are high, transaction completes.
    p_protocol_compliance_single_cycle_b_handshake_possible: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |-> 1'b1;
        );
    // --- p_protocol_compliance_single_cycle_ar_handshake_possible (roi=0.412) ---
    // Documents that single-cycle AR handshake is legal. When both ARVALID and ARREADY are high, transaction completes.
    p_protocol_compliance_single_cycle_ar_handshake_possible: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> 1'b1;
        );
    // --- p_protocol_compliance_single_cycle_r_handshake_possible (roi=0.412) ---
    // Documents that single-cycle R handshake is legal. When both RVALID and RREADY are high, transaction completes.
    p_protocol_compliance_single_cycle_r_handshake_possible: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |-> 1'b1;
        );

endmodule // sva_protocol_compliance_checker
