analyze -sv09 sep_mailbox.sv
analyze -sv09 ecc_error_count_sva.sv
elaborate -top sep_mailbox
clock clk
reset -expression {!rst_n}
prove -all