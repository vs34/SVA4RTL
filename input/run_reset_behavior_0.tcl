analyze -sv09 mbox_pkg.sv
<<<<<<< HEAD
analyze -sv09 mbox_ctrl.sv
analyze -sv09 mbox_ctrl_reset_behavior_assert.sv
=======
analyze -sv09 assert_reset_behavior_0.sv
>>>>>>> 2e99ae18a95995d1062a6170914fab75fbaea5dc
elaborate -top mbox_ctrl
clock clk
reset -expression {!rst_n}
prove -all
