onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Framebuffer_Read_testbench/clk_74
add wave -noupdate /Framebuffer_Read_testbench/reset
add wave -noupdate /Framebuffer_Read_testbench/fbr_reset
add wave -noupdate -divider Pixel
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/px_r
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/px_g
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/px_b
add wave -noupdate /Framebuffer_Read_testbench/vga/VGA_BLANK_N
add wave -noupdate -divider {Book Keeping}
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/hcount
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/vcount
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/fbr/next_h
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/fbr/next_v
add wave -noupdate /Framebuffer_Read_testbench/fbr/queue_read
add wave -noupdate /Framebuffer_Read_testbench/fbr/read_in_progress
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/fbr/words_left
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/fbr/px_index
add wave -noupdate -divider FIFO
add wave -noupdate /Framebuffer_Read_testbench/fbr/fifo_rdreq
add wave -noupdate /Framebuffer_Read_testbench/fbr/fifo_sclr
add wave -noupdate -radix hexadecimal /Framebuffer_Read_testbench/fbr/fifo_outdata
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/fbr/fifo_usedw
add wave -noupdate -divider ddr3
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/ddr3_address
add wave -noupdate /Framebuffer_Read_testbench/ddr3_read
add wave -noupdate -radix hexadecimal /Framebuffer_Read_testbench/ddr3_readdata
add wave -noupdate /Framebuffer_Read_testbench/ddr3_readdatavalid
add wave -noupdate /Framebuffer_Read_testbench/ddr3_waitrequest
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/ddr3_burstcount
add wave -noupdate -divider {ddr3 Write}
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/writes_left
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/hc
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/vc
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/ddr3_w_address
add wave -noupdate -radix unsigned /Framebuffer_Read_testbench/ddr3_w_burstcount
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_waitrequest
add wave -noupdate -radix hexadecimal /Framebuffer_Read_testbench/ddr3_w_writedata
add wave -noupdate -radix hexadecimal /Framebuffer_Read_testbench/ddr3_w_byteenable
add wave -noupdate /Framebuffer_Read_testbench/ddr3_w_write
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44544800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 200
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
WaveRestoreZoom {43968670 ps} {44805749 ps}
