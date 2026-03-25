// Quality Index Info Inline: 1.0
module mbox_ctrl_reset_behavior_assert (
  input logic clk,
  input logic rst_n,
  input logic [31:0] r_ctrl,
  input logic [31:0] r_cmd,
  input logic [31:0] r_irq_mask,
  input logic [31:0] r_xfer_cnt,
  input logic [31:0] r_src_addr,
  input logic [31:0] r_dst_addr,
  input logic        r_lock,
  input logic [31:0] r_err_code,
  input logic [31:0] remaining_q,
  input logic [6:0]  timeout_q,
  input logic [3:0]  fifo_cnt,
  input logic [2:0]  fifo_wr_ptr,
  input logic [2:0]  fifo_rd_ptr,
  input logic        o_rdata,
  input logic        o_ready
);

  // Reset Behavior Assertions
  assert property (@(posedge clk) disable iff (!rst_n)
    r_ctrl == '0 &&
    r_cmd == '0 &&
    r_irq_mask == '0 &&
    r_xfer_cnt == '0 &&
    r_src_addr == '0 &&
    r_dst_addr == '0 &&
    r_lock == '0 &&
    r_err_code == '0 &&
    remaining_q == '0 &&
    timeout_q == '0 &&
    fifo_cnt == '0 &&
    fifo_wr_ptr == '0 &&
    fifo_rd_ptr == '0 &&
    o_rdata == '0 &&
    o_ready == '0
  );

endmodule

bind mbox_ctrl u_mbox_ctrl_reset_behavior_assert (
  .clk(clk),
  .rst_n(rst_n),
  .r_ctrl(r_ctrl),
  .r_cmd(r_cmd),
  .r_irq_mask(r_irq_mask),
  .r_xfer_cnt(r_xfer_cnt),
  .r_src_addr(r_src_addr),
  .r_dst_addr(r_dst_addr),
  .r_lock(r_lock),
  .r_err_code(r_err_code),
  .remaining_q(remaining_q),
  .timeout_q(timeout_q),
  .fifo_cnt(fifo_cnt),
  .fifo_wr_ptr(fifo_wr_ptr),
  .fifo_rd_ptr(fifo_rd_ptr),
  .o_rdata(o_rdata),
  .o_ready(o_ready)
);