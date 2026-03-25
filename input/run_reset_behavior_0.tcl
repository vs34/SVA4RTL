analyze -sv09 mbox_ctrl.sv
analyze -sv09 mbox_pkg.sv
analyze -sv09 mbox_ctrl_reset_behavior_assert.sv
elaborate -top mbox_ctrl
clock clk
reset -expression {!rst_n}
prove -all
