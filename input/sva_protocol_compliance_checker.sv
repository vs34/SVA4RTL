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

    // --- p_protocol_compliance_awvalid_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires AWVALID to remain asserted until AWREADY is observed high. This ensures the master cannot withdraw the address request prematurely.
    p_protocol_compliance_awvalid_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> s_awvalid
        );
    // --- p_protocol_compliance_awaddr_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires AWADDR to remain stable while AWVALID is asserted and AWREADY is low. Address cannot change mid-handshake.
    p_protocol_compliance_awaddr_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awaddr)
        );
    // --- p_protocol_compliance_awprot_stable_until_awready (roi=0.679) ---
    // AXI4-Lite protocol requires AWPROT to remain stable while AWVALID is asserted and AWREADY is low. Protection attributes cannot change mid-handshake.
    p_protocol_compliance_awprot_stable_until_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_awready) |=> $stable(s_awprot)
        );
    // --- p_protocol_compliance_wvalid_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY is observed high. Write data cannot be withdrawn before acceptance.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WDATA to remain stable while WVALID is asserted and WREADY is low. Data cannot change mid-handshake.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata)
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.679) ---
    // AXI4-Lite protocol requires WSTRB to remain stable while WVALID is asserted and WREADY is low. Write strobes cannot change mid-handshake.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb)
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BVALID to remain asserted until BREADY is observed high. Slave cannot withdraw write response before master acceptance.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.679) ---
    // AXI4-Lite protocol requires BRESP to remain stable while BVALID is asserted and BREADY is low. Response cannot change mid-handshake.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp)
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARVALID to remain asserted until ARREADY is observed high. Master cannot withdraw read address request prematurely.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARADDR to remain stable while ARVALID is asserted and ARREADY is low. Read address cannot change mid-handshake.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr)
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.679) ---
    // AXI4-Lite protocol requires ARPROT to remain stable while ARVALID is asserted and ARREADY is low. Protection attributes cannot change mid-handshake.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot)
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RVALID to remain asserted until RREADY is observed high. Slave cannot withdraw read data before master acceptance.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RDATA to remain stable while RVALID is asserted and RREADY is low. Read data cannot change mid-handshake.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata)
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.679) ---
    // AXI4-Lite protocol requires RRESP to remain stable while RVALID is asserted and RREADY is low. Read response cannot change mid-handshake.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp)
        );
    // --- p_protocol_compliance_bvalid_follows_write_transaction (roi=0.667) ---
    // When both address and data phases complete simultaneously, the slave must eventually assert BVALID to complete the write transaction. This ensures liveness.
    p_protocol_compliance_bvalid_follows_write_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:$] s_bvalid
        );
    // --- p_protocol_compliance_bvalid_follows_awready_then_wready (roi=0.667) ---
    // When address phase completes before data phase, the slave must eventually assert BVALID after the data handshake completes. Ensures write completion.
    p_protocol_compliance_bvalid_follows_awready_then_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) ##[1:$] (s_wvalid && s_wready) |-> ##[1:$] s_bvalid
        );
    // --- p_protocol_compliance_bvalid_follows_wready_then_awready (roi=0.667) ---
    // When data phase completes before address phase, the slave must eventually assert BVALID after the address handshake completes. Ensures write completion.
    p_protocol_compliance_bvalid_follows_wready_then_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) ##[1:$] (s_awvalid && s_awready) |-> ##[1:$] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_follows_read_transaction (roi=0.667) ---
    // When read address handshake completes, the slave must eventually assert RVALID to provide read data. This ensures read transaction liveness.
    p_protocol_compliance_rvalid_follows_read_transaction: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:$] s_rvalid
        );
    // --- p_protocol_compliance_bvalid_not_before_aw_and_w (roi=0.654) ---
    // BVALID cannot assert unless at least the address phase has been completed. Prevents premature write response generation.
    p_protocol_compliance_bvalid_not_before_aw_and_w: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready, 1) || $past(s_awvalid && s_awready && s_wvalid && s_wready, 1)
        );
    // --- p_protocol_compliance_rvalid_not_before_arready (roi=0.654) ---
    // RVALID cannot assert unless the read address phase has been completed. Prevents premature read response generation.
    p_protocol_compliance_rvalid_not_before_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> $past(s_arvalid && s_arready, 1)
        );
    // --- p_protocol_compliance_bvalid_clears_on_bready (roi=0.654) ---
    // After write response handshake completes, BVALID must deassert in the next cycle (unless another transaction is ready). Ensures proper transaction completion.
    p_protocol_compliance_bvalid_clears_on_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid
        );
    // --- p_protocol_compliance_rvalid_clears_on_rready (roi=0.654) ---
    // After read response handshake completes, RVALID must deassert in the next cycle (unless another transaction is ready). Ensures proper transaction completion.
    p_protocol_compliance_rvalid_clears_on_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid
        );
    // --- p_protocol_compliance_no_bvalid_without_prior_awvalid (roi=0.642) ---
    // BVALID should not appear without a preceding write address phase within a reasonable window. Checks for spurious write responses.
    p_protocol_compliance_no_bvalid_without_prior_awvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_bvalid) |-> $past(s_awvalid, 1) || $past(s_awvalid, 2) || $past(s_awvalid, 3) || $past(s_awvalid, 4) || $past(s_awvalid, 5)
        );
    // --- p_protocol_compliance_no_rvalid_without_prior_arvalid (roi=0.642) ---
    // RVALID should not appear without a preceding read address phase within a reasonable window. Checks for spurious read responses.
    p_protocol_compliance_no_rvalid_without_prior_arvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(s_rvalid) |-> $past(s_arvalid, 1) || $past(s_arvalid, 2) || $past(s_arvalid, 3) || $past(s_arvalid, 4) || $past(s_arvalid, 5)
        );
    // --- p_protocol_compliance_awready_no_depend_on_bready (roi=0.629) ---
    // AWREADY must not have circular dependency on BREADY to avoid deadlock. The slave should be able to accept new address even if previous response is pending.
    p_protocol_compliance_awready_no_depend_on_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid && !s_bready |-> ##[0:2] s_awready
        );
    // --- p_protocol_compliance_wready_no_depend_on_bready (roi=0.629) ---
    // WREADY must not have circular dependency on BREADY to avoid deadlock. The slave should be able to accept write data even if previous response is pending.
    p_protocol_compliance_wready_no_depend_on_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid && !s_bready |-> ##[0:2] s_wready
        );
    // --- p_protocol_compliance_arready_no_depend_on_rready (roi=0.629) ---
    // ARREADY must not have circular dependency on RREADY to avoid deadlock. The slave should be able to accept new read address even if previous data is pending.
    p_protocol_compliance_arready_no_depend_on_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid && !s_rready |-> ##[0:2] s_arready
        );
    // --- p_protocol_compliance_write_channel_independence (roi=0.642) ---
    // Write address channel should not permanently block waiting for write data channel. Ensures forward progress and channel independence per AXI4-Lite spec.
    p_protocol_compliance_write_channel_independence: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && !s_wvalid) |-> ##[0:$] (s_awready || (s_wvalid && s_wready))
        );
    // --- p_protocol_compliance_read_write_channel_independence (roi=0.629) ---
    // Read and write channels must be able to make independent forward progress. One channel should not permanently block the other to avoid deadlock.
    p_protocol_compliance_read_write_channel_independence: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_awvalid) |-> ##[1:5] (s_arready || s_awready)
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.667) ---
    // Design documentation states write response is always OKAY. Verify that BRESP is always 2'b00 (OKAY response) when BVALID is asserted.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> s_bresp == 2'b00
        );
    // --- p_protocol_compliance_no_x_on_awaddr_when_valid (roi=0.667) ---
    // When AWVALID is asserted, AWADDR must not contain X or Z values. Ensures valid address signaling.
    p_protocol_compliance_no_x_on_awaddr_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> !$isunknown(s_awaddr)
        );
    // --- p_protocol_compliance_no_x_on_wdata_when_valid (roi=0.667) ---
    // When WVALID is asserted, WDATA must not contain X or Z values. Ensures valid data signaling.
    p_protocol_compliance_no_x_on_wdata_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wdata)
        );
    // --- p_protocol_compliance_no_x_on_wstrb_when_valid (roi=0.667) ---
    // When WVALID is asserted, WSTRB must not contain X or Z values. Ensures valid strobe signaling.
    p_protocol_compliance_no_x_on_wstrb_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> !$isunknown(s_wstrb)
        );
    // --- p_protocol_compliance_no_x_on_araddr_when_valid (roi=0.667) ---
    // When ARVALID is asserted, ARADDR must not contain X or Z values. Ensures valid address signaling.
    p_protocol_compliance_no_x_on_araddr_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> !$isunknown(s_araddr)
        );
    // --- p_protocol_compliance_no_x_on_rdata_when_valid (roi=0.667) ---
    // When RVALID is asserted, RDATA must not contain X or Z values. Ensures valid read data output.
    p_protocol_compliance_no_x_on_rdata_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata)
        );
    // --- p_protocol_compliance_no_x_on_bresp_when_valid (roi=0.667) ---
    // When BVALID is asserted, BRESP must not contain X or Z values. Ensures valid write response signaling.
    p_protocol_compliance_no_x_on_bresp_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp)
        );
    // --- p_protocol_compliance_no_x_on_rresp_when_valid (roi=0.667) ---
    // When RVALID is asserted, RRESP must not contain X or Z values. Ensures valid read response signaling.
    p_protocol_compliance_no_x_on_rresp_when_valid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp)
        );
    // --- p_protocol_compliance_wstrb_nonzero_when_wvalid (roi=0.617) ---
    // Write strobe should not be all zeros when WVALID is asserted, as this would indicate no bytes are being written. Catches potential protocol errors.
    p_protocol_compliance_wstrb_nonzero_when_wvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb != 4'b0000)
        );
    // --- p_protocol_compliance_bvalid_bounded_latency (roi=0.617) ---
    // Write response should appear within a bounded time after both address and data phases complete. Prevents unbounded latency and ensures reasonable response time.
    p_protocol_compliance_bvalid_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid
        );
    // --- p_protocol_compliance_rvalid_bounded_latency (roi=0.617) ---
    // Read data should appear within a bounded time after address phase completes. Prevents unbounded latency and ensures reasonable response time.
    p_protocol_compliance_rvalid_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid
        );
    // --- p_protocol_compliance_awready_eventually_asserts (roi=0.629) ---
    // When AWVALID is asserted, AWREADY must eventually respond to prevent indefinite stalling. Ensures liveness and prevents deadlock.
    p_protocol_compliance_awready_eventually_asserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> ##[0:32] s_awready
        );
    // --- p_protocol_compliance_wready_eventually_asserts (roi=0.629) ---
    // When WVALID is asserted, WREADY must eventually respond to prevent indefinite stalling. Ensures liveness and prevents deadlock.
    p_protocol_compliance_wready_eventually_asserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> ##[0:32] s_wready
        );
    // --- p_protocol_compliance_arready_eventually_asserts (roi=0.629) ---
    // When ARVALID is asserted, ARREADY must eventually respond to prevent indefinite stalling. Ensures liveness and prevents deadlock.
    p_protocol_compliance_arready_eventually_asserts: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> ##[0:32] s_arready
        );
    // --- p_protocol_compliance_no_bvalid_when_idle (roi=0.617) ---
    // BVALID should not be asserted when no write transaction is in progress or recently completed. Catches spurious response generation.
    p_protocol_compliance_no_bvalid_when_idle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_awvalid && !s_wvalid && !$past(s_awvalid, 1) && !$past(s_wvalid, 1) && !$past(s_awvalid, 2) && !$past(s_wvalid, 2)) |-> !s_bvalid
        );
    // --- p_protocol_compliance_no_rvalid_when_idle (roi=0.617) ---
    // RVALID should not be asserted when no read transaction is in progress or recently completed. Catches spurious read data generation.
    p_protocol_compliance_no_rvalid_when_idle: assert property (
            @(posedge clk) disable iff (!rst_n)
              (!s_arvalid && !$past(s_arvalid, 1) && !$past(s_arvalid, 2)) |-> !s_rvalid
        );
    // --- p_protocol_compliance_single_bvalid_per_write (roi=0.605) ---
    // After a write response completes, BVALID should not reassert until a new complete write transaction occurs. Ensures one-to-one correspondence between writes and responses.
    // SKIPPED (unsupported operator): p_protocol_compliance_single_bvalid_per_write
    // p_protocol_compliance_single_bvalid_per_write: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_bvalid && s_bready) |-> ##1 (!s_bvalid throughout ##[0:3] !(s_awvalid && s_awready && s_wvalid && s_wready))
    //     );
    // --- p_protocol_compliance_single_rvalid_per_read (roi=0.605) ---
    // After a read response completes, RVALID should not reassert until a new read address transaction occurs. Ensures one-to-one correspondence between reads and responses.
    // SKIPPED (unsupported operator): p_protocol_compliance_single_rvalid_per_read
    // p_protocol_compliance_single_rvalid_per_read: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_rvalid && s_rready) |-> ##1 (!s_rvalid throughout ##[0:3] !(s_arvalid && s_arready))
    //     );
    // --- p_protocol_compliance_awready_wready_simultaneous_ok (roi=0.642) ---
    // Slave can accept both address and data in the same cycle or sequentially. Verifies that simultaneous acceptance is supported per AXI4-Lite spec.
    p_protocol_compliance_awready_wready_simultaneous_ok: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_wvalid) |-> ##[0:1] (s_awready && s_wready)
        );
    // --- p_protocol_compliance_address_alignment_check (roi=0.654) ---
    // For 32-bit data width, addresses should be word-aligned. This checks that write addresses are aligned to 4-byte boundaries as expected for the register file.
    p_protocol_compliance_address_alignment_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready) |-> (s_awaddr[1:0] == 2'b00)
        );
    // --- p_protocol_compliance_read_address_alignment_check (roi=0.654) ---
    // For 32-bit data width, read addresses should be word-aligned. This checks that read addresses are aligned to 4-byte boundaries as expected for the register file.
    p_protocol_compliance_read_address_alignment_check: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> (s_araddr[1:0] == 2'b00)
        );

endmodule // sva_protocol_compliance_checker
