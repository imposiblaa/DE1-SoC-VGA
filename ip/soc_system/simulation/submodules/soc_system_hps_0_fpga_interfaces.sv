// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ns / 1 ns

import verbosity_pkg::*;
import avalon_mm_pkg::*;

module soc_system_hps_0_fpga_interfaces
(
   output wire [  0:  0] h2f_rst_n,
   input  wire [ 27:  0] f2h_sdram0_ADDRESS,
   input  wire [  7:  0] f2h_sdram0_BURSTCOUNT,
   output wire [  0:  0] f2h_sdram0_WAITREQUEST,
   input  wire [127:  0] f2h_sdram0_WRITEDATA,
   input  wire [ 15:  0] f2h_sdram0_BYTEENABLE,
   input  wire [  0:  0] f2h_sdram0_WRITE,
   input  wire [  0:  0] f2h_sdram0_clk,
   input  wire [ 27:  0] f2h_sdram1_ADDRESS,
   input  wire [  7:  0] f2h_sdram1_BURSTCOUNT,
   output wire [  0:  0] f2h_sdram1_WAITREQUEST,
   output wire [127:  0] f2h_sdram1_READDATA,
   output wire [  0:  0] f2h_sdram1_READDATAVALID,
   input  wire [  0:  0] f2h_sdram1_READ,
   input  wire [  0:  0] f2h_sdram1_clk
);




   altera_avalon_reset_source #(
      .ASSERT_HIGH_RESET(0),
      .INITIAL_RESET_CYCLES(1)
   ) h2f_reset_inst (
      .reset(h2f_rst_n),
      .clk('0)
   );

// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.




wire [16 - 1 : 0] intermediate;
assign intermediate[13:13] = intermediate[12:12];
assign intermediate[7:7] = intermediate[6:6];
assign intermediate[2:2] = intermediate[6:6];
assign intermediate[0:0] = ~intermediate[1:1];
assign intermediate[11:11] = intermediate[14:14];
assign intermediate[5:5] = intermediate[4:4];
assign intermediate[15:15] = intermediate[14:14];
assign intermediate[3:3] = intermediate[6:6];
assign intermediate[10:10] = intermediate[14:14];
assign intermediate[8:8] = ~intermediate[9:9];
assign f2h_sdram1_WAITREQUEST[0:0] = intermediate[8:8];
assign f2h_sdram0_WAITREQUEST[0:0] = intermediate[0:0];
assign intermediate[14:14] = f2h_sdram1_clk[0:0];
assign intermediate[12:12] = f2h_sdram1_READ[0:0];
assign intermediate[4:4] = f2h_sdram0_WRITE[0:0];
assign intermediate[6:6] = f2h_sdram0_clk[0:0];

cyclonev_hps_interface_fpga2sdram f2sdram(
 .cmd_data_1({
    18'b000000000000000000 // 59:42
   ,f2h_sdram1_BURSTCOUNT[7:0] // 41:34
   ,4'b0000 // 33:30
   ,f2h_sdram1_ADDRESS[27:0] // 29:2
   ,1'b0 // 1:1
   ,intermediate[12:12] // 0:0
  })
,.cmd_data_0({
    18'b000000000000000000 // 59:42
   ,f2h_sdram0_BURSTCOUNT[7:0] // 41:34
   ,4'b0000 // 33:30
   ,f2h_sdram0_ADDRESS[27:0] // 29:2
   ,intermediate[4:4] // 1:1
   ,1'b0 // 0:0
  })
,.cfg_port_width({
    12'b000000001010 // 11:0
  })
,.rd_valid_1({
    f2h_sdram1_READDATAVALID[0:0] // 0:0
  })
,.wr_clk_1({
    intermediate[3:3] // 0:0
  })
,.wr_clk_0({
    intermediate[2:2] // 0:0
  })
,.wr_data_1({
    2'b00 // 89:88
   ,f2h_sdram0_BYTEENABLE[15:8] // 87:80
   ,16'b0000000000000000 // 79:64
   ,f2h_sdram0_WRITEDATA[127:64] // 63:0
  })
,.cfg_cport_type({
    12'b000000001001 // 11:0
  })
,.wr_data_0({
    2'b00 // 89:88
   ,f2h_sdram0_BYTEENABLE[7:0] // 87:80
   ,16'b0000000000000000 // 79:64
   ,f2h_sdram0_WRITEDATA[63:0] // 63:0
  })
,.cfg_rfifo_cport_map({
    16'b0000000000010001 // 15:0
  })
,.cfg_cport_wfifo_map({
    18'b000000000000000000 // 17:0
  })
,.cmd_port_clk_1({
    intermediate[15:15] // 0:0
  })
,.cmd_port_clk_0({
    intermediate[7:7] // 0:0
  })
,.cfg_cport_rfifo_map({
    18'b000000000000000000 // 17:0
  })
,.rd_ready_1({
    1'b1 // 0:0
  })
,.rd_ready_0({
    1'b1 // 0:0
  })
,.rd_clk_1({
    intermediate[11:11] // 0:0
  })
,.cmd_ready_1({
    intermediate[9:9] // 0:0
  })
,.rd_clk_0({
    intermediate[10:10] // 0:0
  })
,.cmd_ready_0({
    intermediate[1:1] // 0:0
  })
,.cfg_wfifo_cport_map({
    16'b0000000000000000 // 15:0
  })
,.wrack_ready_0({
    1'b1 // 0:0
  })
,.cmd_valid_1({
    intermediate[13:13] // 0:0
  })
,.cmd_valid_0({
    intermediate[5:5] // 0:0
  })
,.rd_data_1({
    f2h_sdram1_READDATA[127:64] // 63:0
  })
,.rd_data_0({
    f2h_sdram1_READDATA[63:0] // 63:0
  })
,.cfg_axi_mm_select({
    6'b000000 // 5:0
  })
);




endmodule 

