onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Framebuffer_Read_testbench/clk_74
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_address
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_burstcount
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_waitrequest
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_writedata
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_write
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_byteenable
add wave -noupdate /Framebuffer_Read_testbench/word_count
add wave -noupdate -divider Read
add wave -noupdate /Framebuffer_Read_testbench/read
add wave -noupdate /Framebuffer_Read_testbench/ddr3_address
add wave -noupdate /Framebuffer_Read_testbench/ddr3_burstCount
add wave -noupdate /Framebuffer_Read_testbench/ddr3_waitrequest
add wave -noupdate /Framebuffer_Read_testbench/ddr3_readdata
add wave -noupdate /Framebuffer_Read_testbench/ddr3_readdatavalid
add wave -noupdate /Framebuffer_Read_testbench/ddr3_read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26475285 ps} 0}
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
WaveRestoreZoom {0 ps} {761173 ps}
