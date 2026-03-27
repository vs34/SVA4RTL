analyze -sv09 mbox_pkg.sv
analyze -sv09 mbox_ctrl.sv
analyze -sv09 assert_reset_behavior_1.sv
analyze -sv09 bind_reset_behavior_1.sv
elaborate -top mbox_ctrl
clock clk
reset -expression {!rst_n}
prove -all
