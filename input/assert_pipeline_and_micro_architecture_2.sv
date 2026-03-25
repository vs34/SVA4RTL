// Quality Index Info Inline: 4.8
module mailbox_sva (
  input logic clk,
  input logic rst_n,
  input logic i_sep_req,
  input logic i_sep_write,
  input logic [11:0] i_sep_addr,
  input logic [31:0] i_sep_wdata,
  output logic [31:0] o_sep_rdata,
  output logic o_sep_ready,
  input logic i_host_req,
  input logic i_host_write,
  input logic [11:0] i_host_addr,
  input logic [31:0] i_host_wdata,
  output logic [31:0] o_host_rdata,
  output logic o_host_ready,
  output logic o_host_irq,
  output logic o_sep_irq
);

  // Assertion 1: Busy flag should be cleared when done or error is set
  property p_busy_cleared_on_done_error;
    @(posedge clk) disable iff (!rst_n)
      (mbox_sts.done || mbox_sts.error) |-> !mbox_sts.busy;
  endproperty
  assert property (p_busy_cleared_on_done_error);

  // Assertion 2: Done and error flags should be mutually exclusive
  property p_done_error_exclusive;
    @(posedge clk) disable iff (!rst_n)
      !(mbox_sts.done && mbox_sts.error);
  endproperty
  assert property (p_done_error_exclusive);

  // Assertion 3: SEP interrupt should be asserted when host writes command
  property p_sep_irq_on_host_cmd;
    @(posedge clk) disable iff (!rst_n)
      (mbox_sts.busy && (mbox_cmd != '0)) |-> o_sep_irq;
  endproperty
  assert property (p_sep_irq_on_host_cmd);

  // Assertion 4: Host interrupt should be asserted when SEP sets done or error
  property p_host_irq_on_mbox_status;
    @(posedge clk) disable iff (!rst_n)
      (mbox_sts.done || mbox_sts.error) |-> o_host_irq;
  endproperty
  assert property (p_host_irq_on_mbox_status);

endmodule

bind sep_mailbox mailbox_sva u_mailbox_sva (
  .clk(clk),
  .rst_n(rst_n),
  .i_sep_req(i_sep_req),
  .i_sep_write(i_sep_write),
  .i_sep_addr(i_sep_addr),
  .i_sep_wdata(i_sep_wdata),
  .o_sep_rdata(o_sep_rdata),
  .o_sep_ready(o_sep_ready),
  .i_host_req(i_host_req),
  .i_host_write(i_host_write),
  .i_host_addr(i_host_addr),
  .i_host_wdata(i_host_wdata),
  .o_host_rdata(o_host_rdata),
  .o_host_ready(o_host_ready),
  .o_host_irq(o_host_irq),
  .o_sep_irq(o_sep_irq)
);