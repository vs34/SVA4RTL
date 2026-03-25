// Quality Index Info Inline: 4.5
module ecc_correctable_sva (
  input logic clk,
  input logic rst_n,
  input logic sec_error,
  input logic corr_flag,
  input logic fatal_flag
);
  // A single-bit error is correctable only — must not set fatal flag
  property p_single_bit_error_is_correctable_only;
    @(posedge clk) disable iff (!rst_n)
      sec_error |-> corr_flag && !fatal_flag;
  endproperty
  assert property (p_single_bit_error_is_correctable_only);
endmodule

bind sep_mailbox u_ecc_correctable_sva (
  .clk(clk),
  .rst_n(rst_n),
  .sec_error(sec_error), // Assume SEC error is captured in mailbox status
  .corr_flag(mbox_sts.done), // Assume correctable flag is set when done
  .fatal_flag(mbox_sts.error) // Assume fatal flag is set when error
);