`timescale 1ns / 1ps
module Framebuffer_Read (
    input  logic            clk_74,
    input  logic            reset,

    output logic [27:0]     ddr3_address,
    output logic [7:0]      ddr3_burstcount,
    input  logic            ddr3_waitrequest,
    input  logic [127:0]    ddr3_readdata,
    input  logic            ddr3_readdatavalid,
    output logic            ddr3_read,

    input  logic [11:0]     hcount,
    input  logic [10:0]      vcount,
    output logic [7:0]      px_r,
    output logic [7:0]      px_g,
    output logic [7:0]      px_b
);

    parameter int width = 1280;
    parameter int height = 720;
    parameter int hcount_offset = 1;

    logic fifo_rdreq;
    logic fifo_empty;
    logic fifo_full;
    logic fifo_sclr;
    logic [127:0] fifo_outdata;
    logic [8:0] fifo_usedw;

    logic [3:0] px_index;
    logic [127:0] outreg;

    logic [11:0] next_h;
    logic [10:0] next_v;

    logic queue_read;
    logic read_in_progress;
    logic [7:0] words_left;

    FBLINE_FIFO lfifo (.clock(clk_74), .data(ddr3_readdata), .rdreq(fifo_rdreq), .sclr(fifo_sclr), .wrreq(ddr3_readdatavalid),
                       .empty(fifo_empty), .full(fifo_full), .q(fifo_outdata), .usedw(fifo_usedw));


    always_comb begin
        px_r = outreg[7:0];
        px_g = outreg[15:8];
        px_b = outreg[23:16];
    end

    always_ff @(posedge clk_74) begin
        if (reset) begin
            px_index <= 0;
            next_h <= 0;
            next_v <= 0;
            queue_read <= 0;
            read_in_progress <= 0;
            words_left <= 0;
        end else begin
            if (fifo_usedw < 256 & ~read_in_progress & ~queue_read) begin
                queue_read <= 1;
            end

            if (queue_read) begin
                ddr3_read <= 1;
                ddr3_burstcount <= 64;
                ddr3_address <= (next_v * 256) + (next_h / 5);
                read_in_progress <= 1;
                words_left <= 64;

                if (next_h >= (width-320)) begin
                    next_h <= next_h + 320 - width;
                    if (next_v >= (height-1))
                        next_v <= 0;
                    else
                        next_v <= next_v + 1;
                end else
                    next_h <= next_h + 320;

                queue_read <= 0;
            end

            if (read_in_progress) begin
                if (~ddr3_waitrequest)
                    ddr3_read <= 0;

                if (ddr3_readdatavalid)
                    words_left <= words_left - 1;

                if (words_left == 0)
                    read_in_progress <= 0;
            end

            if ((hcount < 1280-hcount_offset | hcount >= 1649-hcount_offset) & vcount < 720) begin
                outreg <= outreg >> 24;
                fifo_rdreq <= 0;
                px_index <= px_index - 1;
                if (px_index == 0) begin
                    px_index <= 4;
                    fifo_rdreq <= 1;
                end else if (px_index == 3)
                    outreg <= fifo_outdata;


            end

            if (hcount == 1279) begin
                fifo_sclr <= 1;
                px_index <= 0;
                next_h <= 0;
                fifo_rdreq <= 0;

                if (vcount < 750)
                    next_v <= vcount + 1;
                else
                    next_v <= 0;

            end else if (~read_in_progress)
                fifo_sclr <= 0;
        end
    end


endmodule


module Framebuffer_Read_testbench ();

    logic            clk_74;
    logic [27:0]     ddr3_address;
    logic [7:0]      ddr3_burstcount;
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

    logic [11:0]     hcount;
    logic [10:0]      vcount;
    logic [7:0]      px_r;
    logic [7:0]      px_g;
    logic [7:0]      px_b;
    logic            reset;
    logic            fbr_reset;


    soc_system hps (
        .hps_0_f2h_sdram0_clock_clk(clk_74),
        .hps_0_f2h_sdram0_data_address(ddr3_w_address),
        .hps_0_f2h_sdram0_data_burstcount(ddr3_w_burstcount),
        .hps_0_f2h_sdram0_data_waitrequest(ddr3_w_waitrequest),
        .hps_0_f2h_sdram0_data_writedata(ddr3_w_writedata),
        .hps_0_f2h_sdram0_data_byteenable(ddr3_w_byteenable),
        .hps_0_f2h_sdram0_data_write(ddr3_w_write),
        .hps_0_f2h_sdram1_clock_clk(clk_74),
        .hps_0_f2h_sdram1_data_address(ddr3_address),
        .hps_0_f2h_sdram1_data_burstcount(ddr3_burstcount),
        .hps_0_f2h_sdram1_data_waitrequest(ddr3_waitrequest),
        .hps_0_f2h_sdram1_data_readdata(ddr3_readdata),
        .hps_0_f2h_sdram1_data_readdatavalid(ddr3_readdatavalid),
        .hps_0_f2h_sdram1_data_read(ddr3_read)
    );

    Framebuffer_Read fbr (
        .clk_74,
        .reset(fbr_reset),
        .ddr3_address,
        .ddr3_burstcount,
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

    VGA_Timing vga (.clk_74, .reset, .hcount, .vcount);
    
    parameter CLOCK_74_PERIOD = 13.47;
    initial begin
        clk_74 <= 0;
        forever #(CLOCK_74_PERIOD/2) clk_74 = ~clk_74;
    end
    initial begin
        // Assert reset
        hps.hps_0.fpga_interfaces.h2f_reset_inst.reset_assert();
        reset <= 1;
        // Delay
        #100
        // Deassert reset
        hps.hps_0.fpga_interfaces.h2f_reset_inst.reset_deassert();
        reset <= 0;
    end

    logic first_cycle = 1;
    logic [11:0] hc = -5;
    logic [10:0] vc = 0;
    logic [7:0] writes_left = 0;

    assign ddr3_w_writedata = {
        8'h00,
        8'h00, 8'hff, 8'(((hc+5)*256)/1280),
        8'h00, 8'hff, 8'(((hc+4)*256)/1280),
        8'h00, 8'hff, 8'(((hc+3)*256)/1280),
        8'h00, 8'hff, 8'(((hc+2)*256)/1280),
        8'h00, 8'hff, 8'(((hc+1)*256)/1280)
    };
    always_ff @(posedge clk_74) begin
        first_cycle <= 0;
        if (12'(hc+5) < 1280) begin
            if (first_cycle)
                hc <= hc + 5;

            if (vc == 0)
                fbr_reset <= 1;
            
            if (~ddr3_w_waitrequest & ddr3_w_write) begin
                writes_left <= writes_left - 1;
                hc <= hc + 5;
            end
            if (writes_left == 0) begin
                ddr3_w_write <= 1;
                ddr3_w_address <= (vc*256) + (12'(hc+5)/5);
                ddr3_w_burstcount <= 64;
                ddr3_w_byteenable <= '1;
                writes_left <= 63;
            end 
        end else begin
            ddr3_w_write <= 0;
            fbr_reset <= 0;

            vc <= vc + 1;
            hc <= -5;
            first_cycle <= 1;
        end
    end
endmodule