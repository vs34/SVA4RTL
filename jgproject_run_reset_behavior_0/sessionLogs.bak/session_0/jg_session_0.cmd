#----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2019.09
# platform  : Linux 2.6.32-754.35.1.el6.x86_64
# version   : 2019.09p002 64 bits
# build date: 2019.11.26 18:17:27 PST
#----------------------------------------
# started Mon Mar 30 11:23:18 IST 2026
# hostname  : edatools-server2.iiitd.edu.in
# pid       : 12596
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:45419' '-nowindow' '-style' 'windows' '-exitonerror' '-data' 'AQAAADx/////AAAAAAAAA3oBAAAAEABMAE0AUgBFAE0ATwBWAEU=' '-proj' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_run_reset_behavior_0/sessionLogs/session_0' '-init' '-hidden' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_run_reset_behavior_0/.tmp/.initCmds.tcl' 'run_reset_behavior_0.tcl' '-hidden' '/home/vaibhav22555/Desktop/SVA4RTL/jgproject_run_reset_behavior_0/.tmp/.postCmds.tcl'
analyze -sv09 mbox_pkg.sv
analyze -sv09 mbox_ctrl.sv
analyze -sv09 assert_reset_behavior_0.sv
analyze -sv09 bind_reset_behavior_0.sv
elaborate -top mbox_ctrl
clock clk
reset -expression {!rst_n}
prove -all
exit -force
