module DE1_SoC (
	input  logic 		CLOCK_50,
	output logic [6:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [7:0] 	VGA_R, VGA_G, VGA_B,
	output logic [9:0] 	LEDR,
    output logic 		VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS,
	input  logic [3:0] 	KEY,
	input  logic [9:0] 	SW,

	output logic [14:0] HPS_DDR3_ADDR,
	output logic [2:0] 	HPS_DDR3_BA,
	output logic 		HPS_DDR3_CK_P,
	output logic 		HPS_DDR3_CK_N,
	output logic 		HPS_DDR3_CKE,
	output logic 		HPS_DDR3_CS_N,
	output logic 		HPS_DDR3_RAS_N,
	output logic 		HPS_DDR3_CAS_N,
	output logic 		HPS_DDR3_WE_N,
	output logic 		HPS_DDR3_RESET_N,
	inout  logic [31:0] HPS_DDR3_DQ,
	inout  logic [3:0] 	HPS_DDR3_DQS_P,
	inout  logic [3:0] 	HPS_DDR3_DQS_N,
	output logic 		HPS_DDR3_ODT,
	output logic [3:0] 	HPS_DDR3_DM,
	input  logic 		HPS_DDR3_RZQ,

	inout  logic 		HPS_SD_CMD,
	inout  logic [3:0] 	HPS_SD_DATA,
	output logic 		HPS_SD_CLK,

	inout  logic [7:0] 	HPS_USB_DATA,
	input  logic 		HPS_USB_CLKOUT,
	output logic 		HPS_USB_STP,
	input  logic 		HPS_USB_DIR,
	input  logic 		HPS_USB_NXT,

	output logic 		HPS_SPIM_CLK,
	output logic 		HPS_SPIM_MOSI,
	input  logic 		HPS_SPIM_MISO,
	output logic 		HPS_SPIM_SS,

	input  logic 		HPS_UART_RX,
	output logic 		HPS_UART_TX
);


	logic 			sdram0_clock_clk; 
	logic [27:0] 	sdram0_data_address; 
	logic [7:0] 	sdram0_data_burstcount; 
	logic 			sdram0_data_waitrequest; 
	logic [127:0] 	sdram0_data_writedata; 
	logic [15:0] 	sdram0_data_byteenable; 
	logic 			sdram0_data_write; 
	logic 			sdram1_clock_clk; 
	logic [27:0] 	sdram1_data_address;
	logic [7:0] 	sdram1_data_burstcount; 
	logic 			sdram1_data_waitrequest; 
	logic [127:0] 	sdram1_data_readdata; 
	logic 			sdram1_data_readdatavalid; 
	logic 			sdram1_data_read; 
	logic 			axi_clock_clk; 
	logic [11:0] 	axi_master_awid; 
	logic [20:0] 	axi_master_awaddr; 
	logic [3:0] 	axi_master_awlen; 
	logic [2:0] 	axi_master_awsize; 
	logic [1:0] 	axi_master_awburst; 
	logic [1:0] 	axi_master_awlock; 
	logic [3:0] 	axi_master_awcache; 
	logic [2:0] 	axi_master_awprot; 
	logic 			axi_master_awvalid; 
	logic 			axi_master_awready; 
	logic [11:0] 	axi_master_wid; 
	logic [31:0] 	axi_master_wdata; 
	logic [3:0] 	axi_master_wstrb; 
	logic 			axi_master_wlast; 
	logic 			axi_master_wvalid; 
	logic 			axi_master_wready; 
	logic [11:0] 	axi_master_bid; 
	logic [1:0] 	axi_master_bresp; 
	logic 			axi_master_bvalid; 
	logic 			axi_master_bready; 
	logic [11:0] 	axi_master_arid; 
	logic [20:0] 	axi_master_araddr; 
	logic [3:0] 	axi_master_arlen; 
	logic [2:0] 	axi_master_arsize; 
	logic [1:0] 	axi_master_arburst; 
	logic [1:0] 	axi_master_arlock; 
	logic [3:0] 	axi_master_arcache; 
	logic [2:0] 	axi_master_arprot; 
	logic 			axi_master_arvalid; 
	logic 			axi_master_arready; 
	logic [11:0] 	axi_master_rid; 
	logic [31:0] 	axi_master_rdata; 
	logic [1:0] 	axi_master_rresp; 
	logic 			axi_master_rlast; 
	logic 			axi_master_rvalid; 
	logic 			axi_master_rready; 
	logic 			hps_reset;
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	soc_system hps (
		.hps_0_f2h_sdram0_clock_clk			(sdram0_clock_clk),	
		.hps_0_f2h_sdram0_data_address		(sdram0_data_address),
		.hps_0_f2h_sdram0_data_burstcount	(sdram0_data_burstcount),
		.hps_0_f2h_sdram0_data_waitrequest	(sdram0_data_waitrequest),
		.hps_0_f2h_sdram0_data_writedata	(sdram0_data_writedata),
		.hps_0_f2h_sdram0_data_byteenable	(sdram0_data_byteenable),
		.hps_0_f2h_sdram0_data_write		(sdram0_data_write),
		.hps_0_f2h_sdram1_clock_clk			(sdram1_clock_clk),
		.hps_0_f2h_sdram1_data_address		(sdram1_data_address),
		.hps_0_f2h_sdram1_data_burstcount	(sdram1_data_burstcount),
		.hps_0_f2h_sdram1_data_waitrequest	(sdram1_data_waitrequest),
		.hps_0_f2h_sdram1_data_readdata		(sdram1_data_readdata),
		.hps_0_f2h_sdram1_data_readdatavalid(sdram1_data_readdatavalid),
		.hps_0_f2h_sdram1_data_read			(sdram1_data_read),
		.hps_0_h2f_lw_axi_clock_clk			(axi_clock_clk),
		.hps_0_h2f_lw_axi_master_awid		(axi_master_awid),
		.hps_0_h2f_lw_axi_master_awaddr		(axi_master_awaddr),
		.hps_0_h2f_lw_axi_master_awlen		(axi_master_awlen),
		.hps_0_h2f_lw_axi_master_awsize		(axi_master_awsize),
		.hps_0_h2f_lw_axi_master_awburst	(axi_master_awburst),
		.hps_0_h2f_lw_axi_master_awlock		(axi_master_awlock),
		.hps_0_h2f_lw_axi_master_awcache	(axi_master_awcache),
		.hps_0_h2f_lw_axi_master_awprot		(axi_master_awprot),
		.hps_0_h2f_lw_axi_master_awvalid	(axi_master_awvalid),
		.hps_0_h2f_lw_axi_master_awready	(axi_master_awready),
		.hps_0_h2f_lw_axi_master_wid		(axi_master_wid),
		.hps_0_h2f_lw_axi_master_wdata		(axi_master_wdata),
		.hps_0_h2f_lw_axi_master_wstrb		(axi_master_wstrb),
		.hps_0_h2f_lw_axi_master_wlast		(axi_master_wlast),
		.hps_0_h2f_lw_axi_master_wvalid		(axi_master_wvalid),
		.hps_0_h2f_lw_axi_master_wready		(axi_master_wready),
		.hps_0_h2f_lw_axi_master_bid		(axi_master_bid),
		.hps_0_h2f_lw_axi_master_bresp		(axi_master_bresp),
		.hps_0_h2f_lw_axi_master_bvalid		(axi_master_bvalid),
		.hps_0_h2f_lw_axi_master_bready		(axi_master_bready),
		.hps_0_h2f_lw_axi_master_arid		(axi_master_arid),
		.hps_0_h2f_lw_axi_master_araddr		(axi_master_araddr),
		.hps_0_h2f_lw_axi_master_arlen		(axi_master_arlen),
		.hps_0_h2f_lw_axi_master_arsize		(axi_master_arsize),
		.hps_0_h2f_lw_axi_master_arburst	(axi_master_arburst),
		.hps_0_h2f_lw_axi_master_arlock		(axi_master_arlock),
		.hps_0_h2f_lw_axi_master_arcache	(axi_master_arcache),
		.hps_0_h2f_lw_axi_master_arprot		(axi_master_arprot),
		.hps_0_h2f_lw_axi_master_arvalid	(axi_master_arvalid),
		.hps_0_h2f_lw_axi_master_arready	(axi_master_arready),
		.hps_0_h2f_lw_axi_master_rid		(axi_master_rid),
		.hps_0_h2f_lw_axi_master_rdata		(axi_master_rdata),
		.hps_0_h2f_lw_axi_master_rresp		(axi_master_rresp),
		.hps_0_h2f_lw_axi_master_rlast		(axi_master_rlast),
		.hps_0_h2f_lw_axi_master_rvalid		(axi_master_rvalid),
		.hps_0_h2f_lw_axi_master_rready		(axi_master_rready),
		.hps_0_h2f_reset_reset_n			(reset_reset_n),
		.hps_0_hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),   
		.hps_0_hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),    
		.hps_0_hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),    
		.hps_0_hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),   
		.hps_0_hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),    
		.hps_0_hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),    
		.hps_0_hps_io_hps_io_usb1_inst_D0	(HPS_USB_DATA[0]),    
		.hps_0_hps_io_hps_io_usb1_inst_D1	(HPS_USB_DATA[1]), 
		.hps_0_hps_io_hps_io_usb1_inst_D2	(HPS_USB_DATA[2]), 
		.hps_0_hps_io_hps_io_usb1_inst_D3	(HPS_USB_DATA[3]), 
		.hps_0_hps_io_hps_io_usb1_inst_D4	(HPS_USB_DATA[4]), 
		.hps_0_hps_io_hps_io_usb1_inst_D5	(HPS_USB_DATA[5]), 
		.hps_0_hps_io_hps_io_usb1_inst_D6	(HPS_USB_DATA[6]), 
		.hps_0_hps_io_hps_io_usb1_inst_D7	(HPS_USB_DATA[7]), 
		.hps_0_hps_io_hps_io_usb1_inst_CLK	(HPS_USB_CLKOUT), 
		.hps_0_hps_io_hps_io_usb1_inst_STP	(HPS_USB_STP), 
		.hps_0_hps_io_hps_io_usb1_inst_DIR	(HPS_USB_DIR), 
		.hps_0_hps_io_hps_io_usb1_inst_NXT	(HPS_USB_NXT), 
		.hps_0_hps_io_hps_io_spim1_inst_CLK	(HPS_SPIM_CLK),
		.hps_0_hps_io_hps_io_spim1_inst_MOSI(HPS_SPIM_MOSI), 
		.hps_0_hps_io_hps_io_spim1_inst_MISO(HPS_SPIM_MISO), 
		.hps_0_hps_io_hps_io_spim1_inst_SS0	(HPS_SPIM_SS),  
		.hps_0_hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
		.hps_0_hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX), 
		.memory_mem_a						(HPS_DDR3_ADDR),                        
		.memory_mem_ba						(HPS_DDR3_BA),              
		.memory_mem_ck						(HPS_DDR3_CK_P),               
		.memory_mem_ck_n					(HPS_DDR3_CK_N),             
		.memory_mem_cke						(HPS_DDR3_CKE),           
		.memory_mem_cs_n					(HPS_DDR3_CS_N),             
		.memory_mem_ras_n					(HPS_DDR3_RAS_N),           
		.memory_mem_cas_n					(HPS_DDR3_CAS_N),         
		.memory_mem_we_n					(HPS_DDR3_WE_N),         
		.memory_mem_reset_n					(HPS_DDR3_RESET_N),           
		.memory_mem_dq						(HPS_DDR3_DQ),     
		.memory_mem_dqs						(HPS_DDR3_DQS_P),               
		.memory_mem_dqs_n					(HPS_DDR3_DQS_N),           
		.memory_mem_odt						(HPS_DDR3_ODT),         
		.memory_mem_dm						(HPS_DDR3_DM),             
		.memory_oct_rzqin					(HPS_DDR3_RZQ)
	);

	VGA_Controller vga_driv (.clk_50(CLOCK_50), .reset(SW[0]), .VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);
endmodule


module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
endmodule