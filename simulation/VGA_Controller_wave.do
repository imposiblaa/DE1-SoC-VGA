onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /VGA_Controller_testbench/VGA_R
add wave -noupdate /VGA_Controller_testbench/VGA_BLANK_N
add wave -noupdate /VGA_Controller_testbench/VGA_VS
add wave -noupdate /VGA_Controller_testbench/VGA_HS
add wave -noupdate /VGA_Controller_testbench/VGA_CLK
add wave -noupdate -radix unsigned /VGA_Controller_testbench/dut/hcount
add wave -noupdate -radix unsigned /VGA_Controller_testbench/dut/vcount
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15972581084 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {15972504286 ps} {15972633035 ps}
