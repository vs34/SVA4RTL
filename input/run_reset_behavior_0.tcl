analyze -sv09 sep_pkg.sv
analyze -sv09 sep_mailbox.sv
analyze -sv09 reset_behavior_assertions.sv
elaborate -top sep_mailbox
clock clk
reset -expression {!rst_n}
prove -all