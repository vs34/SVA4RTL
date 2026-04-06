# Auto-generated JasperGold TCL script
clear -all

# Analyze design files
analyze -sv axi_lite_slave.sv
analyze -sv sva_protocol_compliance_checker.sv
analyze -sv bind_axi_lite_slave.sv

elaborate -top axi_lite_slave

# Clock and reset (auto-detected from IR)
clock clk
reset ~rst_n

# Engine configuration
set_engine_mode {Ht Hp}

set_max_trace_length 20
set_prove_time_limit 300s

# Run proofs
prove -all

# Report results
report -results -file jasper_results.log

exit
