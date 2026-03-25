// Quality Index Info Inline: 1.0
module mailbox_error_sva (
  input logic clk,
  input logic rst_n,
  input mbox_status_t mbox_sts
);
  // Busy should be cleared when done or error is set
  property p_busy_cleared_on_done_error;
    @(posedge clk) disable iff (!rst_n)
      (mbox_sts.done || mbox_sts.error) |-> !mbox_sts.busy;
  endproperty
  assert property (p_busy_cleared_on_done_error);

  // Done and error should be mutually exclusive
  property p_done_error_mutually_exclusive;
    @(posedge clk) disable iff (!rst_n)
      !(mbox_sts.done && mbox_sts.error);
  endproperty
  assert property (p_done_error_mutually_exclusive);
endmodule

bind sep_mailbox u_mailbox_error_sva (
  .clk(clk),
  .rst_n(rst_n),
  .mbox_sts(mbox_sts)
);