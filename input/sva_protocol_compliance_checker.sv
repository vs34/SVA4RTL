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


endmodule // sva_protocol_compliance_checker
