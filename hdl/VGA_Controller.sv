module VGA_Controller (clk_50, reset, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS);

    output logic [7:0] VGA_R, VGA_G, VGA_B;
    output logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    input logic clk_50, reset;

    assign VGA_SYNC_N = 0;

    wire clk_74;
    logic active;
    logic hsync;
    logic vsync;

    logic [$clog2(1650):0] hcount;
    logic [$clog2(750):0] vcount;

    CLOCK74_PLL c74_gen(.refclk(clk_50), .ret(reset), .outclk_0(clk_74));



    assign {VGA_R, VGA_G, VGA_B} = {24{hcount[5]}}; // Output white every 32nd pixel

    assign VGA_BLANK_N = ~active;

    assign VGA_HS = hsync;
    assign VGA_VS = vsync;
    assign VGA_CLK = clk_74;

    always @(posedge clk_74) begin
        if (reset) begin
            hcount <= 0;
            vcount <= 0;
            active <= 0;
            hsync <= 0;
            vsync <= 0;
        end else begin
            hcount <= hcount + 1;
            case (hcount) inside
                [0 : 1249]      : begin active <= 1; hsync <= 0; end
                [1250 : 1389]   : begin active <= 0; hsync <= 0; end
                [1390 : 1429]   : begin active <= 0; hsync <= 1; end
                [1430 : $]      : begin active <= 0; hsync <= 0; end
            endcase

            case (vcount) inside
                [0 : 719]       : begin active <= 1; vsync <= 0; end
                [720 : 724]     : begin active <= 0; vsync <= 0; end
                [725 : 729]     : begin active <= 0; vsync <= 1; end
                [730 : $]       : begin active <= 0; vsync <= 0; end
            endcase

            if (hcount >= 1649) begin
                hcount <= 0;
                vcount <= vcount + 1;
            end

            if (vcount >= 749)
                vcount <= 0;
        end
    end

endmodule



module VGA_Controller_testbench ();
    logic [7:0] VGA_R, VGA_G, VGA_B;
    logic VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_VS, VGA_HS;
    logic clk_50, reset;

    logic clk_74;

    parameter CLOCK_50_PERIOD = 20;
    parameter CLOCK_74_PERIOD = 13.47;
    initial begin
        clk_50 <= 0;
        forever #(CLOCK_50_PERIOD/2) clk_50 = ~clk_50;
    end

    initial begin;
        clk_74 <= 0;
        force dut.pll_inst.outclk_0 = clk_74;
        forever #(CLOCK_74_PERIOD/2) clk_74 = ~clk_74;
    end

    logic [1:0] vscount;

    VGA_Controller dut (.clk_50, .reset, .VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_SYNC_N, .VGA_BLANK_N, .VGA_VS, .VGA_HS);

    always @(posedge VGA_HS) begin
        vscount = vscount + 1;
        if (vscount == 4)
            $stop;

    end

endmodule