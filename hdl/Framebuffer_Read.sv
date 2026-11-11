`timescale 1ns / 1ps
module Framebuffer_Read (
    input  logic            clk_74,
    output logic [27:0]     ddr3_address,
    output logic [7:0]      ddr3_burstCount,
    input  logic            ddr3_waitrequest,
    input  logic [127:0]    ddr3_readdata,
    input  logic            ddr3_readdatavalid,
    output logic            ddr3_read,

    input  logic [10:0]     hcount,
    input  logic [9:0]      vcount,
    output logic [7:0]      px_r,
    output logic [7:0]      px_g,
    output logic [7:0]      px_b
);

    assign ddr3_address = {7'b0000000, vcount, hcount};

endmodule


module Framebuffer_Read_testbench ();

    logic            clk_74;
    logic [27:0]     ddr3_address;
    logic [7:0]      ddr3_burstCount;
    logic            ddr3_waitrequest;
    logic [127:0]    ddr3_readdata;
    logic            ddr3_readdatavalid;
    logic            ddr3_read;

    logic [27:0]    ddr3_w_address;
    logic [7:0]     ddr3_w_burstcount;
    logic           ddr3_w_waitrequest;
    logic [127:0]   ddr3_w_writedata;
    logic [15:0]    ddr3_w_byteenable;
    logic           ddr3_w_write;

    logic [10:0]     hcount;
    logic [9:0]      vcount;
    logic [7:0]      px_r;
    logic [7:0]      px_g;
    logic [7:0]      px_b;


    soc_system hps (
        .hps_0_f2h_sdram0_clock_clk(clk_74),
        .hps_0_f2h_sdram0_data_address(ddr3_w_address),
        .hps_0_f2h_sdram0_data_burstcount(ddr3_w_burstCount),
        .hps_0_f2h_sdram0_data_waitrequest(ddr3_w_waitrequest),
        .hps_0_f2h_sdram0_data_writedata(ddr3_w_writedata),
        .hps_0_f2h_sdram0_data_byteenable(ddr3_w_byteenable),
        .hps_0_f2h_sdram0_data_write(ddr3_w_write),
        .hps_0_f2h_sdram1_clock_clk(clk_74),
        .hps_0_f2h_sdram1_data_address(ddr3_address),
        .hps_0_f2h_sdram1_data_burstcount(ddr3_burstCount),
        .hps_0_f2h_sdram1_data_waitrequest(ddr3_waitrequest),
        .hps_0_f2h_sdram1_data_readdata(ddr3_readdata),
        .hps_0_f2h_sdram1_data_readdatavalid(ddr3_readdatavalid),
        .hps_0_f2h_sdram1_data_read(ddr3_read)
    );

    Framebuffer_Read fbr (
        .clk_74,
        .ddr3_address,
        .ddr3_burstCount,
        .ddr3_waitrequest,
        .ddr3_readdata,
        .ddr3_readdatavalid,
        .ddr3_read,
        .hcount,
        .vcount,
        .px_r,
        .px_g,
        .px_b
    );
    
    parameter CLOCK_74_PERIOD = 13.47;
    initial begin
        clk_74 <= 0;
        forever #(CLOCK_74_PERIOD/2) clk_74 = ~clk_74;
    end

    logic [3:0] word_count = 0;
    logic first_cycle = 1;
    always_ff @(posedge clk_74) begin

        if (first_cycle) begin
            ddr3_w_burstcount <= 8;
            ddr3_w_byteenable <= '1;
            first_cycle <= 0;
        end

        if (~ddr3_w_waitrequest) begin
            ddr3_w_write <= 0;
            ddr3_w_address <= word_count;
            ddr3_w_writedata <= word_count;
            word_count = word_count + 1;
        end
    end
endmodule