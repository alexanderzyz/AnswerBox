`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/24 20:15:19
// Design Name: 
// Module Name: keyleda
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


module keyled(
clk,key_in,key_out
 );
input clk;
input key_in;
output key_out;
    reg[25:0] count_low=0;
    reg[25:0] count_high=0;
    reg key_out_reg=0;
    parameter SAMPLE_TIME =500000;
    always@(posedge clk)
    if(key_in==1'b0)
    count_low<=count_low+1;
    else
    count_low<=0;
    always@(posedge clk)
    if(key_in==1'b1)
    count_high<=count_high+1;
    else
    count_high<=0;
    always@(posedge clk)begin
    if(count_high==SAMPLE_TIME)
    key_out_reg<=1;
    else if(count_low==SAMPLE_TIME)
    key_out_reg<=0;
    end
    assign key_out=key_out_reg;
endmodule

