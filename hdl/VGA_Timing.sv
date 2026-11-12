`timescale 1ns / 1ps
module VGA_Timing (clk_74, reset, hcount, vcount, VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS);

    output logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    input logic clk_74, reset;

    output logic [$clog2(1650):0] hcount;
    output logic [$clog2(750):0] vcount;

    assign VGA_SYNC_N = 1;

    logic h_active;
    logic v_active;
    logic hsync;
    logic vsync;

    assign VGA_BLANK_N = (h_active & v_active);

    assign VGA_HS = hsync;
    assign VGA_VS = vsync;
    assign VGA_CLK = clk_74;

    always @(posedge clk_74) begin
        if (reset) begin
            hcount <= 0;
            vcount <= 0;
            v_active <= 0;
            h_active <= 0;
            hsync <= 0;
            vsync <= 0;
        end else begin
            hcount <= hcount + 1;

            h_active <= hcount < 1280;
            hsync <= (hcount >= 1390) & (hcount < 1430);

            v_active <= vcount < 720;
            vsync <= (vcount >= 725) & (vcount < 730);

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



module VGA_Timing_testbench ();
    logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    logic clk_74, reset;

    parameter CLOCK_74_PERIOD = 13.47;
    initial begin
        clk_74 <= 0;
        forever #(CLOCK_74_PERIOD/2) clk_74 = ~clk_74;
    end


    logic [1:0] vscount;

    VGA_Timing dut (.clk_74, .reset, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);

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