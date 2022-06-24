`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 16:08:35
// Design Name: 
// Module Name: program counter
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


module Regselect(
input[7:0] RX,
input[7:0] RY,
input[7:0] RZ,
input[7:0] RT,
input[7:0] data,
output reg[7:0] temprx,
output reg[7:0] tempry
    );
        always @(*) begin
        if(data[3:2]==2'b00)temprx=RX;
        else if(data[3:2]==2'b01)temprx=RY;
        else if(data[3:2]==2'b10)temprx=RZ;
        else if(data[3:2]==2'b11)temprx=RT;
        if(data[1:0]==2'b00)tempry=RX;
        else if(data[1:0]==2'b01)tempry=RY;
        else if(data[1:0]==2'b10)tempry=RZ;
        else if(data[1:0]==2'b11)tempry=RT;
    end
endmodule
