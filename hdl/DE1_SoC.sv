module DE1_SoC (
	input logic CLOCK_50,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [7:0] VGA_R, VGA_G, VGA_B,
	output logic [9:0] LEDR,
    output logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS,
	input logic [3:0] KEY,
	input logic [9:0] SW,

	output logic [14:0] HPS_DDR3_ADDR,
	output logic [2:0] HPS_DDR3_BA,
	output logic HPS_DDR3_CK_P,
	output logic HPS_DDR3_CK_N,
	output logic HPS_DDR3_CKE,
	output logic HPS_DDR3_CS_N,
	output logic HPS_DDR3_RAS_N,
	output logic HPS_DDR3_CAS_N,
	output logic HPS_DDR3_WE_N,
	output logic HPS_DDR3_RESET_N,
	inout logic [31:0] HPS_DDR3_DQ,
	inout logic [3:0] HPS_DDR3_DQS_P,
	inout logic [3:0] HPS_DDR3_DQS_N,
	output logic HPS_DDR3_ODT,
	output logic [3:0] HPS_DDR3_DM,
	input logic HPS_DDR3_RZQ,

	inout logic HPS_SD_CMD,
	inout logic [3:0] HPS_SD_DATA,
	output logic HPS_SD_CLK,

	inout logic [7:0] HPS_USB_DATA,
	input logic HPS_USB_CLKOUT,
	output logic HPS_USB_STP,
	input logic HPS_USB_DIR,
	input logic HPS_USB_NXT,

	output logic HPS_SPIM_CLK,
	output logic HPS_SPIM_MOSI,
	input logic HPS_SPIM_MISO,
	output logic HPS_SPIM_SS,

	input logic HPS_UART_RX,
	output logic HPS_UART_TX
);
	
	logic dig0, dig1;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	VGA_Controller vga_driv (.clk_50(CLOCK_50), .reset(SW[0]), .VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);
endmodule


module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
endmodule