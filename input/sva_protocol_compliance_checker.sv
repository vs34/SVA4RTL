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
    p_protocol_compliance_c904a1aa3923: assert property (
            // Protocol compliance assertions for axi_lite_slave
            // Target: c904a1aa3923 -- AXI4-Lite slave compliance
    
    
    
            // Protocol rule: AWVALID and WVALID may assert in any order or simultaneously
            // Protocol rule: AWREADY and WREADY may be asserted independently
            // Protocol rule: BVALID must remain asserted until BREADY is observed high
            // Protocol rule: RVALID must remain asserted until RREADY is observed high
            // Protocol rule: Single-beat transactions only (no burst support)
            // Protocol rule: Write response (BRESP) always OKAY per code comment
            // Protocol rule: Read data is registered for timing closure
        );
    // --- p_protocol_compliance_awvalid_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires AWVALID remain asserted until AWREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_awvalid_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> s_awvalid
        );
    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WVALID remain asserted until WREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARVALID remain asserted until ARREADY handshake completes. This is a fundamental handshake stability requirement.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BVALID remain asserted until BREADY is observed high. This ensures write response stability.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RVALID remain asserted until RREADY is observed high. This ensures read data stability.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_awaddr_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires all AW channel signals remain stable while AWVALID is asserted and AWREADY is low. Address must not change mid-handshake.
    p_protocol_compliance_awaddr_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awaddr)
        );
    // --- p_protocol_compliance_awprot_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires all AW channel signals remain stable while AWVALID is asserted and AWREADY is low. Protection bits must not change mid-handshake.
    p_protocol_compliance_awprot_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awprot)
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires all W channel signals remain stable while WVALID is asserted and WREADY is low. Write data must not change mid-handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires all W channel signals remain stable while WVALID is asserted and WREADY is low. Write strobes must not change mid-handshake.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires all AR channel signals remain stable while ARVALID is asserted and ARREADY is low. Address must not change mid-handshake.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires all AR channel signals remain stable while ARVALID is asserted and ARREADY is low. Protection bits must not change mid-handshake.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires all B channel signals remain stable while BVALID is asserted and BREADY is low. Response must not change mid-handshake.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires all R channel signals remain stable while RVALID is asserted and RREADY is low. Read data must not change mid-handshake.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires all R channel signals remain stable while RVALID is asserted and RREADY is low. Response must not change mid-handshake.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_eventually_deasserts (roi=0.654) ---
    // Liveness property: BVALID must eventually deassert to allow new write transactions. Without this, the slave could deadlock holding BVALID high forever.
    p_protocol_compliance_bvalid_eventually_deasserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> strong(##[1:$] !s_bvalid)
        );
    // --- p_protocol_compliance_rvalid_eventually_deasserts (roi=0.654) ---
    // Liveness property: RVALID must eventually deassert to allow new read transactions. Without this, the slave could deadlock holding RVALID high forever.
    p_protocol_compliance_rvalid_eventually_deasserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> strong(##[1:$] !s_rvalid)
        );
    // --- p_protocol_compliance_write_resp_after_both_channels (roi=0.667) ---
    // Safety and liveness: After both AW and W channels complete, a write response must eventually be generated. This ensures forward progress in write transactions.
    p_protocol_compliance_write_resp_after_both_channels: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) ##0 (s_wvalid && s_wready) |-> ##[1:$] (s_bvalid && s_bready)
        );
    // --- p_protocol_compliance_read_data_after_arvalid (roi=0.667) ---
    // Safety and liveness: After AR channel completes, read data must eventually be provided. This ensures forward progress in read transactions.
    p_protocol_compliance_read_data_after_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:$] (s_rvalid && s_rready)
        );
    // --- p_protocol_compliance_no_bvalid_without_write_transaction (roi=0.629) ---
    // Safety property: BVALID should not assert unless both AW and W channels have been serviced. This prevents spurious write responses.
    p_protocol_compliance_no_bvalid_without_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_bvalid && !$past(s_bvalid) throughout (##1 !s_bvalid)[*0:$]) |-> !s_bvalid throughout (##1 !(s_awvalid && s_awready && s_wvalid && s_wready))[*0:$]
        );
    // --- p_protocol_compliance_no_rvalid_without_read_transaction (roi=0.629) ---
    // Safety property: RVALID should not assert unless AR channel has been serviced. This prevents spurious read responses.
    p_protocol_compliance_no_rvalid_without_read_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_rvalid && !$past(s_rvalid) throughout (##1 !s_rvalid)[*0:$]) |-> !s_rvalid throughout (##1 !(s_arvalid && s_arready))[*0:$]
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.667) ---
    // Per design summary, write response is always OKAY. BRESP should always be 2'b00 (OKAY) when BVALID is asserted.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00)
        );
    // --- p_protocol_compliance_bvalid_clear_after_handshake (roi=0.667) ---
    // Safety property: BVALID must deassert in the cycle after BREADY handshake completes. This ensures single-beat transaction semantics.
    p_protocol_compliance_bvalid_clear_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid
        );
    // --- p_protocol_compliance_rvalid_clear_after_handshake (roi=0.667) ---
    // Safety property: RVALID must deassert in the cycle after RREADY handshake completes. This ensures single-beat transaction semantics.
    p_protocol_compliance_rvalid_clear_after_handshake: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid
        );
    // --- p_protocol_compliance_awready_dependency_on_state (roi=0.642) ---
    // State machine constraint: After accepting an address, AWREADY should not be reasserted until the write response completes, preventing overlapping transactions in this single-transaction slave.
    p_protocol_compliance_awready_dependency_on_state: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |=> !s_awready throughout (##1 s_bvalid && s_bready)[->1]
        );
    // --- p_protocol_compliance_wready_dependency_on_state (roi=0.642) ---
    // State machine constraint: After accepting write data, WREADY should not be reasserted until the write response completes, preventing overlapping transactions in this single-transaction slave.
    p_protocol_compliance_wready_dependency_on_state: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready) |=> !s_wready throughout (##1 s_bvalid && s_bready)[->1]
        );
    // --- p_protocol_compliance_arready_dependency_on_state (roi=0.642) ---
    // State machine constraint: After accepting read address, ARREADY should not be reasserted until the read data completes, preventing overlapping transactions in this single-transaction slave.
    p_protocol_compliance_arready_dependency_on_state: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |=> !s_arready throughout (##1 s_rvalid && s_rready)[->1]
        );
    // --- p_protocol_compliance_no_simultaneous_bvalid_new_write (roi=0.654) ---
    // Single-beat transaction enforcement: While BVALID is asserted, a new write transaction should not be accepted simultaneously. Ensures sequential transaction processing.
    p_protocol_compliance_no_simultaneous_bvalid_new_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !(s_awvalid && s_awready && s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_no_simultaneous_rvalid_new_read (roi=0.654) ---
    // Single-beat transaction enforcement: While RVALID is asserted, a new read transaction should not be accepted simultaneously. Ensures sequential transaction processing.
    p_protocol_compliance_no_simultaneous_rvalid_new_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !(s_arvalid && s_arready)
        );
    // --- p_protocol_compliance_awready_eventually_asserts_when_idle (roi=0.629) ---
    // Liveness with bounded timing: When slave is idle and AWVALID arrives, AWREADY should assert within reasonable time (16 cycles). Prevents deadlock.
    p_protocol_compliance_awready_eventually_asserts_when_idle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_bvalid && !s_awready && s_awvalid) |-> ##[1:16] s_awready
        );
    // --- p_protocol_compliance_wready_eventually_asserts_when_idle (roi=0.629) ---
    // Liveness with bounded timing: When slave is idle and WVALID arrives, WREADY should assert within reasonable time (16 cycles). Prevents deadlock.
    p_protocol_compliance_wready_eventually_asserts_when_idle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_bvalid && !s_wready && s_wvalid) |-> ##[1:16] s_wready
        );
    // --- p_protocol_compliance_arready_eventually_asserts_when_idle (roi=0.629) ---
    // Liveness with bounded timing: When slave is idle and ARVALID arrives, ARREADY should assert within reasonable time (16 cycles). Prevents deadlock.
    p_protocol_compliance_arready_eventually_asserts_when_idle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_rvalid && !s_arready && s_arvalid) |-> ##[1:16] s_arready
        );
    // --- p_protocol_compliance_bvalid_asserts_bounded_after_write (roi=0.642) ---
    // Timing constraint: After both write channels complete, BVALID should assert within bounded time (8 cycles). Ensures timely response generation.
    p_protocol_compliance_bvalid_asserts_bounded_after_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              ((s_awvalid && s_awready) ##0 (s_wvalid && s_wready)) |-> ##[1:8] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_asserts_bounded_after_read (roi=0.642) ---
    // Timing constraint: After read address is accepted, RVALID should assert within bounded time (8 cycles). Ensures timely data delivery considering registered output.
    p_protocol_compliance_rvalid_asserts_bounded_after_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:8] s_rvalid
        );
    // --- p_protocol_compliance_no_bvalid_pulse_without_bready (roi=0.642) ---
    // Protocol correctness: BVALID rising edge should only occur when proceeding toward handshake completion. Prevents protocol violations.
    p_protocol_compliance_no_bvalid_pulse_without_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_bvalid ##1 s_bvalid) |-> s_bready || (s_bvalid throughout ##1 s_bready[->1])
        );
    // --- p_protocol_compliance_no_rvalid_pulse_without_rready (roi=0.642) ---
    // Protocol correctness: RVALID rising edge should only occur when proceeding toward handshake completion. Prevents protocol violations.
    p_protocol_compliance_no_rvalid_pulse_without_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_rvalid ##1 s_rvalid) |-> s_rready || (s_rvalid throughout ##1 s_rready[->1])
        );
    // --- p_protocol_compliance_write_channels_independence (roi=0.654) ---
    // Protocol flexibility: AW and W channels can complete in any order. This tests that W can complete after AW without issue.
    p_protocol_compliance_write_channels_independence: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) ##1 (!s_awvalid && s_wvalid) |-> ##[0:$] (s_wvalid && s_wready)
        );
    // --- p_protocol_compliance_write_channels_simultaneous (roi=0.654) ---
    // Protocol flexibility: AW and W channels can complete simultaneously. This tests correct response generation for simultaneous completion.
    p_protocol_compliance_write_channels_simultaneous: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_wvalid && s_awready && s_wready) |-> ##[1:8] s_bvalid
        );
    // --- p_protocol_compliance_awready_not_dependent_on_wvalid (roi=0.642) ---
    // Channel independence: AWREADY can be asserted independently of WVALID per AXI4-Lite spec. Slave should not wait for WVALID before accepting address.
    p_protocol_compliance_awready_not_dependent_on_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_wvalid) |-> ##[0:16] (s_awready)
        );
    // --- p_protocol_compliance_wready_not_dependent_on_awvalid (roi=0.642) ---
    // Channel independence: WREADY can be asserted independently of AWVALID per AXI4-Lite spec. Slave should not wait for AWVALID before accepting data.
    p_protocol_compliance_wready_not_dependent_on_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_awvalid) |-> ##[0:16] (s_wready)
        );
    // --- p_protocol_compliance_no_awready_glitch (roi=0.617) ---
    // Signal integrity: AWREADY should not glitch or pulse unnecessarily. It should remain stable or only change in response to AWVALID.
    p_protocol_compliance_no_awready_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_awready) |-> s_awready || $past(s_awvalid)
        );
    // --- p_protocol_compliance_no_wready_glitch (roi=0.617) ---
    // Signal integrity: WREADY should not glitch or pulse unnecessarily. It should remain stable or only change in response to WVALID.
    p_protocol_compliance_no_wready_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_wready) |-> s_wready || $past(s_wvalid)
        );
    // --- p_protocol_compliance_no_arready_glitch (roi=0.617) ---
    // Signal integrity: ARREADY should not glitch or pulse unnecessarily. It should remain stable or only change in response to ARVALID.
    p_protocol_compliance_no_arready_glitch: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_arready) |-> s_arready || $past(s_arvalid)
        );
    // --- p_protocol_compliance_reset_clears_bvalid (roi=0.679) ---
    // Reset behavior: Coming out of reset, BVALID must be low to ensure clean startup state.
    p_protocol_compliance_reset_clears_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_bvalid
        );
    // --- p_protocol_compliance_reset_clears_rvalid (roi=0.679) ---
    // Reset behavior: Coming out of reset, RVALID must be low to ensure clean startup state.
    p_protocol_compliance_reset_clears_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !rst_n |=> !s_rvalid
        );
    // --- p_protocol_compliance_wstrb_valid_bits_only (roi=0.617) ---
    // Byte-enable sanity: WSTRB should only have valid combinations for 32-bit aligned accesses. Invalid strobe patterns indicate protocol violations.
    p_protocol_compliance_wstrb_valid_bits_only: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000, 4'b0011, 4'b1100, 4'b1111, 4'b0000})
        );
    // --- p_protocol_compliance_addr_alignment_write (roi=0.605) ---
    // Address alignment: For 32-bit registers, addresses should be word-aligned. Slave should reject misaligned write addresses.
    p_protocol_compliance_addr_alignment_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && (s_awaddr[1:0] != 2'b00)) |-> ##[0:$] !(s_awready)
        );
    // --- p_protocol_compliance_addr_alignment_read (roi=0.605) ---
    // Address alignment: For 32-bit registers, addresses should be word-aligned. Slave should reject misaligned read addresses.
    p_protocol_compliance_addr_alignment_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && (s_araddr[1:0] != 2'b00)) |-> ##[0:$] !(s_arready)
        );
    // --- p_protocol_compliance_valid_register_address_write (roi=0.654) ---
    // Address decode: Only four registers exist at offsets 0x00, 0x04, 0x08, 0x0C. Write addresses should only target these valid offsets.
    p_protocol_compliance_valid_register_address_write: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
        );
    // --- p_protocol_compliance_valid_register_address_read (roi=0.654) ---
    // Address decode: Only four registers exist at offsets 0x00, 0x04, 0x08, 0x0C. Read addresses should only target these valid offsets.
    p_protocol_compliance_valid_register_address_read: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[3:0] inside {4'h0, 4'h4, 4'h8, 4'hC})
        );
    // --- p_protocol_compliance_no_multiple_bvalid_assertions (roi=0.642) ---
    // Transaction ordering: After completing one write response, BVALID should not reassert until a new complete write transaction is received.
    p_protocol_compliance_no_multiple_bvalid_assertions: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid throughout (##1 (s_awvalid && s_awready && s_wvalid && s_wready))[->1]
        );
    // --- p_protocol_compliance_no_multiple_rvalid_assertions (roi=0.642) ---
    // Transaction ordering: After completing one read response, RVALID should not reassert until a new read address is received.
    p_protocol_compliance_no_multiple_rvalid_assertions: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid throughout (##1 (s_arvalid && s_arready))[->1]
        );
    // --- p_protocol_compliance_awprot_no_x_or_z (roi=0.654) ---
    // Signal validity: AWPROT should not contain X or Z values when AWVALID is asserted. Ensures clean protocol signal values.
    p_protocol_compliance_awprot_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awprot)
        );
    // --- p_protocol_compliance_arprot_no_x_or_z (roi=0.654) ---
    // Signal validity: ARPROT should not contain X or Z values when ARVALID is asserted. Ensures clean protocol signal values.
    p_protocol_compliance_arprot_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_arprot)
        );
    // --- p_protocol_compliance_awaddr_no_x_or_z (roi=0.667) ---
    // Signal validity: AWADDR should not contain X or Z values when AWVALID is asserted. Ensures deterministic address decode.
    p_protocol_compliance_awaddr_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awaddr)
        );
    // --- p_protocol_compliance_araddr_no_x_or_z (roi=0.667) ---
    // Signal validity: ARADDR should not contain X or Z values when ARVALID is asserted. Ensures deterministic address decode.
    p_protocol_compliance_araddr_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_araddr)
        );
    // --- p_protocol_compliance_wdata_no_x_or_z (roi=0.667) ---
    // Signal validity: WDATA should not contain X or Z values when WVALID is asserted. Ensures deterministic register writes.
    p_protocol_compliance_wdata_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_no_x_or_z (roi=0.667) ---
    // Signal validity: WSTRB should not contain X or Z values when WVALID is asserted. Ensures deterministic byte-enable logic.
    p_protocol_compliance_wstrb_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wstrb)
        );
    // --- p_protocol_compliance_bresp_no_x_or_z (roi=0.667) ---
    // Signal validity: BRESP should not contain X or Z values when BVALID is asserted. Ensures clean response signal.
    p_protocol_compliance_bresp_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp)
        );
    // --- p_protocol_compliance_rresp_no_x_or_z (roi=0.667) ---
    // Signal validity: RRESP should not contain X or Z values when RVALID is asserted. Ensures clean response signal.
    p_protocol_compliance_rresp_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp)
        );
    // --- p_protocol_compliance_rdata_no_x_or_z (roi=0.667) ---
    // Signal validity: RDATA should not contain X or Z values when RVALID is asserted. Ensures deterministic read data.
    p_protocol_compliance_rdata_no_x_or_z: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata)
        );

endmodule // sva_protocol_compliance_checker
