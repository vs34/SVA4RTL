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

bind sep_mailbox flush_sva u_flush_sva (
  .clk(clk),
  .rst_n(rst_n),
  .flush_pipe(1'b0),  // The mailbox design does not have a pipeline to flush
  .valid_if(1'b0),
  .valid_id(1'b0)
);