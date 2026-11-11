
module soc_system (
	hps_0_f2h_sdram0_clock_clk,
	hps_0_f2h_sdram0_data_address,
	hps_0_f2h_sdram0_data_burstcount,
	hps_0_f2h_sdram0_data_waitrequest,
	hps_0_f2h_sdram0_data_writedata,
	hps_0_f2h_sdram0_data_byteenable,
	hps_0_f2h_sdram0_data_write,
	hps_0_f2h_sdram1_clock_clk,
	hps_0_f2h_sdram1_data_address,
	hps_0_f2h_sdram1_data_burstcount,
	hps_0_f2h_sdram1_data_waitrequest,
	hps_0_f2h_sdram1_data_readdata,
	hps_0_f2h_sdram1_data_readdatavalid,
	hps_0_f2h_sdram1_data_read,
	hps_0_h2f_reset_reset_n,
	hps_0_hps_io_hps_io_sdio_inst_CMD,
	hps_0_hps_io_hps_io_sdio_inst_D0,
	hps_0_hps_io_hps_io_sdio_inst_D1,
	hps_0_hps_io_hps_io_sdio_inst_CLK,
	hps_0_hps_io_hps_io_sdio_inst_D2,
	hps_0_hps_io_hps_io_sdio_inst_D3,
	hps_0_hps_io_hps_io_usb1_inst_D0,
	hps_0_hps_io_hps_io_usb1_inst_D1,
	hps_0_hps_io_hps_io_usb1_inst_D2,
	hps_0_hps_io_hps_io_usb1_inst_D3,
	hps_0_hps_io_hps_io_usb1_inst_D4,
	hps_0_hps_io_hps_io_usb1_inst_D5,
	hps_0_hps_io_hps_io_usb1_inst_D6,
	hps_0_hps_io_hps_io_usb1_inst_D7,
	hps_0_hps_io_hps_io_usb1_inst_CLK,
	hps_0_hps_io_hps_io_usb1_inst_STP,
	hps_0_hps_io_hps_io_usb1_inst_DIR,
	hps_0_hps_io_hps_io_usb1_inst_NXT,
	hps_0_hps_io_hps_io_spim1_inst_CLK,
	hps_0_hps_io_hps_io_spim1_inst_MOSI,
	hps_0_hps_io_hps_io_spim1_inst_MISO,
	hps_0_hps_io_hps_io_spim1_inst_SS0,
	hps_0_hps_io_hps_io_uart0_inst_RX,
	hps_0_hps_io_hps_io_uart0_inst_TX,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin);	

	input		hps_0_f2h_sdram0_clock_clk;
	input	[27:0]	hps_0_f2h_sdram0_data_address;
	input	[7:0]	hps_0_f2h_sdram0_data_burstcount;
	output		hps_0_f2h_sdram0_data_waitrequest;
	input	[127:0]	hps_0_f2h_sdram0_data_writedata;
	input	[15:0]	hps_0_f2h_sdram0_data_byteenable;
	input		hps_0_f2h_sdram0_data_write;
	input		hps_0_f2h_sdram1_clock_clk;
	input	[27:0]	hps_0_f2h_sdram1_data_address;
	input	[7:0]	hps_0_f2h_sdram1_data_burstcount;
	output		hps_0_f2h_sdram1_data_waitrequest;
	output	[127:0]	hps_0_f2h_sdram1_data_readdata;
	output		hps_0_f2h_sdram1_data_readdatavalid;
	input		hps_0_f2h_sdram1_data_read;
	output		hps_0_h2f_reset_reset_n;
	inout		hps_0_hps_io_hps_io_sdio_inst_CMD;
	inout		hps_0_hps_io_hps_io_sdio_inst_D0;
	inout		hps_0_hps_io_hps_io_sdio_inst_D1;
	output		hps_0_hps_io_hps_io_sdio_inst_CLK;
	inout		hps_0_hps_io_hps_io_sdio_inst_D2;
	inout		hps_0_hps_io_hps_io_sdio_inst_D3;
	inout		hps_0_hps_io_hps_io_usb1_inst_D0;
	inout		hps_0_hps_io_hps_io_usb1_inst_D1;
	inout		hps_0_hps_io_hps_io_usb1_inst_D2;
	inout		hps_0_hps_io_hps_io_usb1_inst_D3;
	inout		hps_0_hps_io_hps_io_usb1_inst_D4;
	inout		hps_0_hps_io_hps_io_usb1_inst_D5;
	inout		hps_0_hps_io_hps_io_usb1_inst_D6;
	inout		hps_0_hps_io_hps_io_usb1_inst_D7;
	input		hps_0_hps_io_hps_io_usb1_inst_CLK;
	output		hps_0_hps_io_hps_io_usb1_inst_STP;
	input		hps_0_hps_io_hps_io_usb1_inst_DIR;
	input		hps_0_hps_io_hps_io_usb1_inst_NXT;
	output		hps_0_hps_io_hps_io_spim1_inst_CLK;
	output		hps_0_hps_io_hps_io_spim1_inst_MOSI;
	input		hps_0_hps_io_hps_io_spim1_inst_MISO;
	output		hps_0_hps_io_hps_io_spim1_inst_SS0;
	input		hps_0_hps_io_hps_io_uart0_inst_RX;
	output		hps_0_hps_io_hps_io_uart0_inst_TX;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
endmodule
