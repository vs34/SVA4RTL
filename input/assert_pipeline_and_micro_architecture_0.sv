// Quality Index Info Inline: 0.2
module stall_prop_sva (
  input logic clk,
  input logic rst_n,
  input logic stall_ex,
  input logic valid_id,
  input logic valid_ex
);
  // A stall in EX must freeze both the ID and EX stage valids on the next cycle
  property p_stall_holds_upstream_stage;
    @(posedge clk) disable iff (!rst_n)
      stall_ex |=> $stable(valid_id) && $stable(valid_ex);
  endproperty
  assert property (p_stall_holds_upstream_stage);
endmodule

bind sep_mailbox stall_prop_sva u_stall_prop_sva (
  .clk(clk),
  .rst_n(rst_n),
  .stall_ex(1'b0),  // There is no stall signal in the mailbox design
  .valid_id(1'b0),  // The mailbox does not have pipeline stages
  .valid_ex(1'b0)
);