`timescale 1ns / 1ps
module CLOCK74_PLL (
    input  wire refclk,
    input  wire rst,
    output reg  outclk_0,
    output reg  locked
);
    localparam real HALF = 13.468 / 2.0;  // 74.25 MHz

    initial outclk_0 = 1'b0;
    always #(HALF) outclk_0 = ~outclk_0;

    initial begin
        locked = 1'b0;
        #100 locked = 1'b1;
    end

    always @(posedge rst) locked <= 1'b0;
endmodule