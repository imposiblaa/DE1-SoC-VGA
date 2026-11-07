`timescale 1ns / 1ps
module VGA_Controller (clk_50, reset, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS);

    output logic [7:0] VGA_R, VGA_G, VGA_B;
    output logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    input logic clk_50, reset;

    assign VGA_SYNC_N = 1;

    wire clk_74;
    logic h_active;
    logic v_active;
    logic hsync;
    logic vsync;
    logic locked;

    logic [$clog2(1650):0] hcount;
    logic [$clog2(750):0] vcount;

    CLOCK74_PLL c74_gen(.refclk(clk_50), .rst(reset), .locked, .outclk_0(clk_74));



    assign VGA_BLANK_N = (h_active & v_active);

    assign VGA_HS = hsync;
    assign VGA_VS = vsync;
    assign VGA_CLK = clk_74;

    always @(posedge clk_74) begin
        VGA_R <= (hcount * 255) / 1250;
        VGA_G <= (vcount * 255) / 720;
        VGA_B <= 128;
    end

    always @(posedge clk_74) begin
        if (reset | ~locked) begin
            hcount <= 0;
            vcount <= 0;
            v_active <= 0;
            h_active <= 0;
            hsync <= 0;
            vsync <= 0;
        end else begin
            hcount <= hcount + 1;

            h_active <= hcount < 1250;
            hsync <= (hcount >= 1390) & (hcount < 1430);

            v_active <= vcount < 720;
            vsync <= (vcount >= 725) & (vcount < 1430);

            if (hcount >= 1649) begin
                hcount <= 0;
                if (vcount >= 749)
                    vcount <= 0;
                else 
                    vcount <= vcount + 1;

            end

        end
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