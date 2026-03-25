// Quality Index Info Inline: 1.0
module mailbox_status_assertions (
    input logic clk,
    input logic rst_n,
    input mbox_status_t mbox_sts
);

    // Busy should be cleared when done or error is set
    assert property (@(posedge clk) disable iff (!rst_n)
        (mbox_sts.done || mbox_sts.error) |-> !mbox_sts.busy
    );

    // Done and error should be mutually exclusive
    assert property (@(posedge clk) disable iff (!rst_n)
        !(mbox_sts.done && mbox_sts.error)
    );

endmodule

bind sep_mailbox mailbox_status_assertions u_mailbox_status_assertions (
    .clk(clk),
    .rst_n(rst_n),
    .mbox_sts(mbox_sts)
);