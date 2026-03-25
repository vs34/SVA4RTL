// Quality Index Info Inline: 4.5
module bubble_insert_sva (
  input logic clk,
  input logic rst_n,
  input logic raw_hazard,
  input logic stall_id,
  input logic valid_id,
  input logic valid_ex
);
  // When a RAW hazard occurs, the ID stage must be stalled and a bubble inserted in EX
  property p_raw_hazard_inserts_bubble;
    @(posedge clk) disable iff (!rst_n)
      raw_hazard |=> (stall_id && !valid_ex);
  endproperty
  assert property (p_raw_hazard_inserts_bubble);
endmodule

bind mbox_ctrl bubble_insert_sva u_bubble_insert_sva (
  .clk(clk),
  .rst_n(rst_n),
  .raw_hazard(/* TODO: Add the appropriate signal from the RTL */),
  .stall_id(/* TODO: Add the appropriate signal from the RTL */),
  .valid_id(/* TODO: Add the appropriate signal from the RTL */),
  .valid_ex(/* TODO: Add the appropriate signal from the RTL */)
);

module forward_enable_sva (
  input logic clk,
  input logic rst_n,
  input logic raw_hazard,
  input logic forward_sel
);
  // When a RAW hazard is detected, the forwarding mux must be enabled
  property p_raw_hazard_enables_forwarding;
    @(posedge clk) disable iff (!rst_n)
      raw_hazard |-> forward_sel;
  endproperty
  assert property (p_raw_hazard_enables_forwarding);
endmodule

bind mbox_ctrl forward_enable_sva u_forward_enable_sva (
  .clk(clk),
  .rst_n(rst_n),
  .raw_hazard(/* TODO: Add the appropriate signal from the RTL */),
  .forward_sel(/* TODO: Add the appropriate signal from the RTL */)
);

module stage_latency_sva #(
  parameter int STAGE_COUNT = 5
)(
  input logic clk,
  input logic rst_n,
  input logic valid_if,
  input logic valid_wb
);
  // An instruction that enters the pipeline must exit within a bounded number of cycles
  property p_bounded_stage_latency;
    @(posedge clk) disable iff (!rst_n)
      valid_if |-> ##[1:STAGE_COUNT] valid_wb;
  endproperty
  assert property (p_bounded_stage_latency);
endmodule

bind mbox_ctrl stage_latency_sva #(
  .STAGE_COUNT(/* TODO: Add the appropriate pipeline depth from the spec */)
) u_stage_latency_sva (
  .clk(clk),
  .rst_n(rst_n),
  .valid_if(/* TODO: Add the appropriate signal from the RTL */),
  .valid_wb(/* TODO: Add the appropriate signal from the RTL */)
);