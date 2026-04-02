#----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2019.09
# platform  : Linux 2.6.32-754.35.1.el6.x86_64
# version   : 2019.09p002 64 bits
# build date: 2019.11.26 18:17:27 PST
#----------------------------------------
# started Thu Apr 02 18:50:33 IST 2026
# hostname  : edatools-server2.iiitd.edu.in
# pid       : 8269
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:35556' '-nowindow' '-style' 'windows' '-exitonerror' '-data' 'AQAAADx/////AAAAAAAAA3oBAAAAEABMAE0AUgBFAE0ATwBWAEU=' '-proj' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_counter_jasper/sessionLogs/session_0' '-init' '-hidden' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_counter_jasper/.tmp/.initCmds.tcl' 'counter_jasper.tcl' '-hidden' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_counter_jasper/.tmp/.postCmds.tcl'
# JasperGold FPV run script for counter.sv
# Usage: jg -fpv -batch -tcl counter_jasper.tcl

#  1. Analyze & elaborate 
analyze -sv counter.sv
elaborate -top counter

#  2. Clock & reset 
clock clk
reset -expression {!rst_n}

#  3. Prove all assertions, check all covers 
prove -all

#  4. Report 
report -summary
report -results
exit -force
