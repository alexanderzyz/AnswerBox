`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 16:11:30
// Design Name: 
// Module Name: clkDiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkDiv(
input clk100mhz,
output clk190hz,
output clk3hz,
output clk1hz
    );
    reg[26:0] count=0;
    assign clk190hz=count[18];
    assign clk3hz=count[25];
    assign clk1hz=count[26];
    always@(posedge clk100mhz)
    count<=count+1;
endmodule
