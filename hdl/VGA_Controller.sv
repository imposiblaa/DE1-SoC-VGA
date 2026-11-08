`timescale 1ns / 1ps
module VGA_Controller (clk_50, reset, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS);

    output logic [7:0] VGA_R, VGA_G, VGA_B;
    output logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    input logic clk_50, reset;
    logic clk_74, locked;

    logic [$clog2(1650):0] hcount;
    logic [$clog2(750):0] vcount;
    logic reset_timer;

    CLOCK74_PLL c74_gen(.refclk(clk_50), .rst(reset), .locked, .outclk_0(clk_74));

    assign reset_timer = ~locked | reset;
    VGA_Timing v_time (.clk_74, .reset(reset_timer), .hcount, .vcount, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);


    always @(posedge clk_74) begin
        {VGA_R, VGA_G, VGA_B} <= {24{hcount[5] ^ vcount[5]}};
    end

endmodule



module VGA_Controller_testbench ();
    logic [7:0] VGA_R, VGA_G, VGA_B;
    logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    logic clk_50, reset;

    parameter CLOCK_50_PERIOD = 20;
    parameter CLOCK_74_PERIOD = 13.47;
    initial begin
        clk_50 <= 0;
        forever #(CLOCK_50_PERIOD/2) clk_50 = ~clk_50;
    end


    logic [1:0] vscount;

    VGA_Controller dut (.clk_50, .reset, .VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);

    initial begin
        reset <= 1; #200;
        reset <=0;
        vscount <= 0;
    end

    always @(negedge VGA_VS) begin
        vscount <= vscount + 1;
        if (vscount == 3)
            $stop;

    end

endmodule