onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/dif/clock
add wave -noupdate /hdl_top/dif/reset
add wave -noupdate /hdl_top/dif/enable_decode
add wave -noupdate /hdl_top/dif/dout
add wave -noupdate /hdl_top/dif/npc_in
add wave -noupdate /hdl_top/dout_if/E_control
add wave -noupdate /hdl_top/dout_if/Mem_Control
add wave -noupdate /hdl_top/dout_if/W_Control
add wave -noupdate /hdl_top/dout_if/IR
add wave -noupdate /hdl_top/dout_if/npc_out
add wave -position insertpoint /uvm_root/uvm_test_top/DECODE_ENV/AGENT_IN/AGENT_IN_monitor/txn_stream
add wave -position insertpoint /uvm_root/uvm_test_top/DECODE_ENV/AGENT_OUT/AGENT_OUT_monitor/txn_stream
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {383 ns}
run -all