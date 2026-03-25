analyze -sv09 sep_pkg.sv
analyze -sv09 sep_mailbox.sv
analyze -sv09 ecc_correctable_sva.sv
analyze -sv09 first_error_sva.sv
elaborate -top sep_mailbox
clock clk
reset -expression {!rst_n}
prove -all