// Quality Index Info Inline: 4.5
module ecc_error_count_sva (
  input logic clk,
  input logic rst_n,
  input logic sec_error,
  input logic [15:0] corr_cnt
);
  // Correctable error counter must increment on each SEC error
  property p_corr_cnt_incr_on_sec_error;
    @(posedge clk) disable iff (!rst_n)
      sec_error |=> corr_cnt == $past(corr_cnt) + 1;
  endproperty
  assert property (p_corr_cnt_incr_on_sec_error);
endmodule

bind sep_mailbox u_ecc_error_count_sva (
  .clk(clk),
  .rst_n(rst_n),
  .sec_error(sec_error), // Assume SEC error is captured in mailbox status
  .corr_cnt(corr_cnt)    // Assume correctable error counter is in mailbox
);