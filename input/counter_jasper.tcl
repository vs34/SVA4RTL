# JasperGold FPV run script for counter.sv
# Usage: jg -fpv -batch -tcl counter_jasper.tcl

# ── 1. Analyze & elaborate ──────────────────────────────────────────
analyze -sv counter.sv
elaborate -top counter

# ── 2. Clock & reset ────────────────────────────────────────────────
clock clk
reset -expression {!rst_n}

# ── 3. Prove all assertions, check all covers ────────────────────────
prove -all

# ── 4. Report ────────────────────────────────────────────────────────
report -summary
report -results
