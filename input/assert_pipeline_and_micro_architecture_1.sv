// Quality Index Info Inline: 0.9
module flush_sva (
  input logic clk,
  input logic rst_n,
  input logic flush_pipe,
  input logic valid_if,
  input logic valid_id
);
  // A flush must invalidate the IF and ID stages on the next cycle
  property p_flush_clears_frontend_valids;
    @(posedge clk) disable iff (!rst_n)
      flush_pipe |=> (!valid_if && !valid_id);
  endproperty
  assert property (p_flush_clears_frontend_valids);
endmodule

bind mbox_ctrl flush_sva u_flush_sva (
  .clk(clk),
  .rst_n(rst_n),
  .flush_pipe(/* TODO: Add the appropriate signal from the RTL */),
  .valid_if(/* TODO: Add the appropriate signal from the RTL */),
  .valid_id(/* TODO: Add the appropriate signal from the RTL */)
);