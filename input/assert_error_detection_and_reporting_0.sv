// Quality Index Info Inline: 4.8
module mbox_err_sva (
  input logic clk,
  input logic rst_n,
  input logic parity_err,
  input logic [7:0] r_err_code,
  input logic [7:0] err_code_w,
  input logic [31:0] r_xfer_cnt,
  input logic [31:0] i_wdata,
  input logic reg_wr,
  input logic [11:0] i_addr,
  input logic timeout_hit,
  input logic [2:0] state_q,
  input logic [2:0] state_d,
  input logic fifo_full,
  input logic fifo_empty
);

  // Parity error must set the ERR_PARITY code
  property p_parity_err_sets_err_parity;
    @(posedge clk) disable iff (!rst_n)
      parity_err |=> r_err_code == ERR_PARITY;
  endproperty
  assert property (p_parity_err_sets_err_parity);

  // FIFO overflow must set the ERR_OVERFLOW code
  property p_fifo_overflow_sets_err_overflow;
    @(posedge clk) disable iff (!rst_n)
      reg_wr & (i_addr == REG_FIFO_IN) & fifo_full |=> err_code_w == ERR_OVERFLOW;
  endproperty
  assert property (p_fifo_overflow_sets_err_overflow);

  // FIFO underflow must set the ERR_UNDERFLOW code  
  property p_fifo_underflow_sets_err_underflow;
    @(posedge clk) disable iff (!rst_n)
      reg_wr & (i_addr == REG_FIFO_OUT) & fifo_empty |=> err_code_w == ERR_UNDERFLOW;
  endproperty
  assert property (p_fifo_underflow_sets_err_underflow);

  // Timeout error must set the ERR_TIMEOUT code
  property p_timeout_sets_err_timeout;
    @(posedge clk) disable iff (!rst_n)
      timeout_hit |=> err_code_w == ERR_TIMEOUT;
  endproperty
  assert property (p_timeout_sets_err_timeout);

  // Start with xfer_cnt=0 must set the ERR_ILLEGAL code
  property p_illegal_start_sets_err_illegal;
    @(posedge clk) disable iff (!rst_n)
      (state_q == ST_IDLE) & (state_d == ST_ARMED) & (r_xfer_cnt == '0) |=> err_code_w == ERR_ILLEGAL;
  endproperty
  assert property (p_illegal_start_sets_err_illegal);

  // First error code must remain sticky until reset
  property p_first_error_code_sticky;
    @(posedge clk) disable iff (!rst_n)
      (r_err_code != ERR_NONE) |=> $stable(r_err_code);
  endproperty
  assert property (p_first_error_code_sticky);

endmodule

bind mbox_ctrl u_mbox_err_sva (
  .clk(clk),
  .rst_n(rst_n),
  .parity_err(parity_err),
  .r_err_code(r_err_code),
  .err_code_w(err_code_w),
  .r_xfer_cnt(r_xfer_cnt),
  .i_wdata(i_wdata),
  .reg_wr(reg_wr),
  .i_addr(i_addr),
  .timeout_hit(timeout_hit),
  .state_q(state_q),
  .state_d(state_d),
  .fifo_full(fifo_full),
  .fifo_empty(fifo_empty)
);