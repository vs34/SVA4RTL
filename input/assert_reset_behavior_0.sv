// Quality Index Info Inline: 4.5
module reset_behavior_assertions (
    input logic clk,
    input logic rst_n
);

    // Reset should clear all mailbox registers
    assert property (@(posedge clk) disable iff (!rst_n)
        ($fell(rst_n) |=> (mbox_cmd == '0) && (mbox_sts == '0) && (mbox_data == '{default:'0}))
    );

endmodule

bind sep_mailbox reset_behavior_assertions u_reset_behavior_assertions (
    .clk(clk),
    .rst_n(rst_n)
);