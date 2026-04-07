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
    // AXI4-Lite protocol requires WVALID to remain asserted until WREADY handshake completes. This is a fundamental handshake stability requirement for the write data channel.
    p_protocol_compliance_wvalid_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> s_wvalid;
        );
    // --- p_protocol_compliance_wdata_stable_until_wready (roi=0.677) ---
    // Write data must remain stable while WVALID is asserted and before WREADY handshake completes, ensuring data integrity during the transaction.
    p_protocol_compliance_wdata_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wdata);
        );
    // --- p_protocol_compliance_wstrb_stable_until_wready (roi=0.677) ---
    // Write strobes must remain stable during the write data handshake period to ensure consistent byte-level write control.
    p_protocol_compliance_wstrb_stable_until_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && !s_wready) |=> $stable(s_wstrb);
        );
    // --- p_protocol_compliance_bvalid_stable_until_bready (roi=0.677) ---
    // Write response BVALID must remain asserted until BREADY is received, per AXI4-Lite handshake protocol requirements.
    p_protocol_compliance_bvalid_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> s_bvalid;
        );
    // --- p_protocol_compliance_bresp_stable_until_bready (roi=0.677) ---
    // Write response value must remain stable while BVALID is asserted and before BREADY handshake completes.
    p_protocol_compliance_bresp_stable_until_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |=> $stable(s_bresp);
        );
    // --- p_protocol_compliance_arvalid_stable_until_arready (roi=0.677) ---
    // Read address ARVALID must remain asserted until ARREADY handshake completes, per AXI4-Lite protocol specification.
    p_protocol_compliance_arvalid_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> s_arvalid;
        );
    // --- p_protocol_compliance_araddr_stable_until_arready (roi=0.677) ---
    // Read address must remain stable during the address handshake period until ARREADY is asserted.
    p_protocol_compliance_araddr_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_araddr);
        );
    // --- p_protocol_compliance_arprot_stable_until_arready (roi=0.677) ---
    // Read protection attributes must remain stable during the read address handshake period.
    p_protocol_compliance_arprot_stable_until_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && !s_arready) |=> $stable(s_arprot);
        );
    // --- p_protocol_compliance_rvalid_stable_until_rready (roi=0.677) ---
    // Read data RVALID must remain asserted until RREADY handshake completes, per AXI4-Lite protocol requirements.
    p_protocol_compliance_rvalid_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> s_rvalid;
        );
    // --- p_protocol_compliance_rdata_stable_until_rready (roi=0.677) ---
    // Read data must remain stable while RVALID is asserted and before RREADY handshake completes.
    p_protocol_compliance_rdata_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rdata);
        );
    // --- p_protocol_compliance_rresp_stable_until_rready (roi=0.677) ---
    // Read response must remain stable during the read data handshake period.
    p_protocol_compliance_rresp_stable_until_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |=> $stable(s_rresp);
        );
    // --- p_protocol_compliance_bvalid_after_write_address_and_data (roi=0.665) ---
    // Write response must eventually be asserted after both write address and write data handshakes complete. This is a liveness property ensuring forward progress.
    p_protocol_compliance_bvalid_after_write_address_and_data: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:$] s_bvalid;
        );
    // --- p_protocol_compliance_bvalid_after_write_address_first (roi=0.652) ---
    // When write address arrives before write data, response must eventually follow after data handshake. Handles out-of-order channel arrival.
    p_protocol_compliance_bvalid_after_write_address_first: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && !s_wvalid) |-> ##[1:$] (s_wvalid && s_wready) ##[1:$] s_bvalid;
        );
    // --- p_protocol_compliance_bvalid_after_write_data_first (roi=0.652) ---
    // When write data arrives before write address, response must eventually follow after address handshake. Ensures proper out-of-order handling.
    p_protocol_compliance_bvalid_after_write_data_first: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready && !s_awvalid) |-> ##[1:$] (s_awvalid && s_awready) ##[1:$] s_bvalid;
        );
    // --- p_protocol_compliance_no_bvalid_without_write_address (roi=0.652) ---
    // Write response must not be asserted unless a write address handshake has occurred. Prevents spurious responses.
    p_protocol_compliance_no_bvalid_without_write_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_awvalid && s_awready, 1, 1) || $past(s_awvalid && s_awready);
        );
    // --- p_protocol_compliance_no_bvalid_without_write_data (roi=0.652) ---
    // Write response must not be asserted unless a write data handshake has occurred. Ensures both write channels complete before response.
    p_protocol_compliance_no_bvalid_without_write_data: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> $past(s_wvalid && s_wready, 1, 1) || $past(s_wvalid && s_wready);
        );
    // --- p_protocol_compliance_rvalid_after_read_address (roi=0.665) ---
    // Read data response must eventually be asserted after read address handshake completes. Liveness property for read transactions.
    p_protocol_compliance_rvalid_after_read_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:$] s_rvalid;
        );
    // --- p_protocol_compliance_no_rvalid_without_read_address (roi=0.652) ---
    // Read data response must not be asserted unless a read address handshake has occurred. Prevents invalid read responses.
    p_protocol_compliance_no_rvalid_without_read_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> $past(s_arvalid && s_arready, 1, 1) || $past(s_arvalid && s_arready);
        );
    // --- p_protocol_compliance_bvalid_clears_after_bready (roi=0.640) ---
    // After write response handshake completes, BVALID must deassert and remain low until the next write response. Ensures proper transaction boundaries.
    p_protocol_compliance_bvalid_clears_after_bready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && s_bready) |=> !s_bvalid [*1:$] ##1 s_bvalid;
        );
    // --- p_protocol_compliance_rvalid_clears_after_rready (roi=0.640) ---
    // After read data handshake completes, RVALID must deassert and remain low until the next read response. Ensures proper transaction boundaries.
    p_protocol_compliance_rvalid_clears_after_rready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && s_rready) |=> !s_rvalid [*1:$] ##1 s_rvalid;
        );
    // --- p_protocol_compliance_no_concurrent_write_responses (roi=0.627) ---
    // Single-beat transactions mean only one write response can be outstanding at a time. Prevents overlapping responses.
    // SKIPPED (unsupported operator): p_protocol_compliance_no_concurrent_write_responses
    // p_protocol_compliance_no_concurrent_write_responses: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_bvalid |-> !(s_bvalid && s_bready) throughout (##1 s_bvalid[->1]);
    //     );
    // --- p_protocol_compliance_no_concurrent_read_responses (roi=0.627) ---
    // Single-beat transactions mean only one read response can be outstanding at a time. Prevents overlapping read data phases.
    // SKIPPED (unsupported operator): p_protocol_compliance_no_concurrent_read_responses
    // p_protocol_compliance_no_concurrent_read_responses: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           s_rvalid |-> !(s_rvalid && s_rready) throughout (##1 s_rvalid[->1]);
    //     );
    // --- p_protocol_compliance_awready_deasserts_after_handshake (roi=0.615) ---
    // Slave should deassert AWREADY after accepting a write address and keep it low until ready for next transaction. Ensures proper handshake sequencing.
    // SKIPPED (unsupported operator): p_protocol_compliance_awready_deasserts_after_handshake
    // p_protocol_compliance_awready_deasserts_after_handshake: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_awvalid && s_awready) |=> !s_awready until_with (s_awvalid && s_awready);
    //     );
    // --- p_protocol_compliance_wready_deasserts_after_handshake (roi=0.615) ---
    // Slave should deassert WREADY after accepting write data and keep it low until ready for next transaction.
    // SKIPPED (unsupported operator): p_protocol_compliance_wready_deasserts_after_handshake
    // p_protocol_compliance_wready_deasserts_after_handshake: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_wvalid && s_wready) |=> !s_wready until_with (s_wvalid && s_wready);
    //     );
    // --- p_protocol_compliance_arready_deasserts_after_handshake (roi=0.615) ---
    // Slave should deassert ARREADY after accepting a read address and keep it low until ready for next transaction.
    // SKIPPED (unsupported operator): p_protocol_compliance_arready_deasserts_after_handshake
    // p_protocol_compliance_arready_deasserts_after_handshake: assert property (
    //         @(posedge clk) disable iff (!rst_n)
    //           (s_arvalid && s_arready) |=> !s_arready until_with (s_arvalid && s_arready);
    //     );
    // --- p_protocol_compliance_write_response_bounded_latency (roi=0.627) ---
    // Write response should be asserted within a bounded time (16 cycles) after both write channels complete. Prevents indefinite stalls.
    p_protocol_compliance_write_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready && s_wvalid && s_wready) |-> ##[1:16] s_bvalid;
        );
    // --- p_protocol_compliance_read_response_bounded_latency (roi=0.627) ---
    // Read response should be asserted within a bounded time (16 cycles) after read address handshake. Prevents indefinite stalls in read path.
    p_protocol_compliance_read_response_bounded_latency: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_arvalid && s_arready) |-> ##[1:16] s_rvalid;
        );
    // --- p_protocol_compliance_no_x_on_awready (roi=0.665) ---
    // AWREADY must never be X or Z during normal operation, as this violates AXI4-Lite protocol and can cause simulation mismatches.
    p_protocol_compliance_no_x_on_awready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_awready);
        );
    // --- p_protocol_compliance_no_x_on_wready (roi=0.665) ---
    // WREADY must never be X or Z during normal operation to ensure proper write data handshake.
    p_protocol_compliance_no_x_on_wready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_wready);
        );
    // --- p_protocol_compliance_no_x_on_bvalid (roi=0.665) ---
    // BVALID must never be X or Z during normal operation to ensure proper write response signaling.
    p_protocol_compliance_no_x_on_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_bvalid);
        );
    // --- p_protocol_compliance_no_x_on_bresp_when_bvalid (roi=0.665) ---
    // Write response code must be valid when BVALID is asserted to provide deterministic response information.
    p_protocol_compliance_no_x_on_bresp_when_bvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> !$isunknown(s_bresp);
        );
    // --- p_protocol_compliance_no_x_on_arready (roi=0.665) ---
    // ARREADY must never be X or Z during normal operation to ensure proper read address handshake.
    p_protocol_compliance_no_x_on_arready: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_arready);
        );
    // --- p_protocol_compliance_no_x_on_rvalid (roi=0.665) ---
    // RVALID must never be X or Z during normal operation to ensure proper read data signaling.
    p_protocol_compliance_no_x_on_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              !$isunknown(s_rvalid);
        );
    // --- p_protocol_compliance_no_x_on_rdata_when_rvalid (roi=0.665) ---
    // Read data must be valid when RVALID is asserted to provide deterministic read results.
    p_protocol_compliance_no_x_on_rdata_when_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rdata);
        );
    // --- p_protocol_compliance_no_x_on_rresp_when_rvalid (roi=0.665) ---
    // Read response code must be valid when RVALID is asserted to provide deterministic response information.
    p_protocol_compliance_no_x_on_rresp_when_rvalid: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_rvalid |-> !$isunknown(s_rresp);
        );
    // --- p_protocol_compliance_bresp_always_okay (roi=0.652) ---
    // Design summary states write responses are always OKAY (2'b00). This verifies implementation matches specification.
    p_protocol_compliance_bresp_always_okay: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_bvalid |-> (s_bresp == 2'b00);
        );
    // --- p_protocol_compliance_valid_wstrb_values (roi=0.615) ---
    // Write strobes should only contain valid byte-lane combinations for 32-bit data. Prevents illegal strobe patterns.
    p_protocol_compliance_valid_wstrb_values: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_wvalid |-> (s_wstrb inside {4'b0001, 4'b0010, 4'b0100, 4'b1000, 4'b0011, 4'b1100, 4'b1111});
        );
    // --- p_protocol_compliance_awaddr_aligned (roi=0.627) ---
    // Write addresses should be word-aligned for 32-bit register access. Misaligned addresses indicate protocol violation.
    p_protocol_compliance_awaddr_aligned: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_awvalid |-> (s_awaddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_araddr_aligned (roi=0.627) ---
    // Read addresses should be word-aligned for 32-bit register access. Misaligned addresses indicate protocol violation.
    p_protocol_compliance_araddr_aligned: assert property (
            @(posedge clk) disable iff (!rst_n)
              s_arvalid |-> (s_araddr[1:0] == 2'b00);
        );
    // --- p_protocol_compliance_no_bvalid_at_reset_exit (roi=0.640) ---
    // Write response should not be asserted immediately after reset deassertion. Ensures clean initialization.
    p_protocol_compliance_no_bvalid_at_reset_exit: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_bvalid;
        );
    // --- p_protocol_compliance_no_rvalid_at_reset_exit (roi=0.640) ---
    // Read response should not be asserted immediately after reset deassertion. Ensures clean initialization.
    p_protocol_compliance_no_rvalid_at_reset_exit: assert property (
            @(posedge clk) disable iff (!rst_n)
              $rose(rst_n) |-> !s_rvalid;
        );
    // --- p_protocol_compliance_write_channels_mutually_exclusive_ready (roi=0.590) ---
    // When both write channels complete simultaneously, slave should typically deassert both READY signals. Enforces state machine behavior.
    p_protocol_compliance_write_channels_mutually_exclusive_ready: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awready && s_awvalid) && (s_wready && s_wvalid) |-> ##1 (!s_awready && !s_wready);
        );
    // --- p_protocol_compliance_bvalid_implies_no_new_write_address (roi=0.603) ---
    // While write response is pending, slave should not accept new write addresses to maintain single-transaction semantics.
    p_protocol_compliance_bvalid_implies_no_new_write_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_bvalid && !s_bready) |-> !(s_awvalid && s_awready);
        );
    // --- p_protocol_compliance_rvalid_implies_no_new_read_address (roi=0.603) ---
    // While read response is pending, slave should not accept new read addresses to maintain single-transaction semantics.
    p_protocol_compliance_rvalid_implies_no_new_read_address: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_rvalid && !s_rready) |-> !(s_arvalid && s_arready);
        );
    // --- p_protocol_compliance_write_response_after_last_channel (roi=0.615) ---
    // Write response should appear within bounded time after the last of the two write channels completes (address first scenario).
    p_protocol_compliance_write_response_after_last_channel: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_awvalid && s_awready ##1 !s_wready[*0:$] ##1 s_wvalid && s_wready) |-> ##[1:8] s_bvalid;
        );
    // --- p_protocol_compliance_write_response_after_last_channel_data_first (roi=0.615) ---
    // Write response should appear within bounded time after the last of the two write channels completes (data first scenario).
    p_protocol_compliance_write_response_after_last_channel_data_first: assert property (
            @(posedge clk) disable iff (!rst_n)
              (s_wvalid && s_wready ##1 !s_awready[*0:$] ##1 s_awvalid && s_awready) |-> ##[1:8] s_bvalid;
        );

endmodule // sva_protocol_compliance_checker
