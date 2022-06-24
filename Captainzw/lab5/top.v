`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 13:27:18
// Design Name: 
// Module Name: top
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

module top(
input [3:0]weight,
input [3:0]price,
input btn,
input reset,
input clk100mhz,
output [7:0]out1,
output [7:0]out2,
output [3:0]pos1,
output [3:0]pos2
    );
    wire clk190hz,clk3hz,clk1hz;
    wire newbtn,newreset;
    wire [15:0]sum;
    wire [15:0]single;
    wire isbtn;
    wire isreset;
    wire [3:0]btnnum;
clkDiv U1(clk100mhz,clk190hz,clk3hz,clk1hz);
keyled U2(clk100mhz,btn,newbtn);
keyled U3(clk100mhz,reset,newreset);
calculate U4(clk100mhz,weight,price,newreset,newbtn,btnnum,isreset,isbtn,single,sum);
segMsg1 U5(clk190hz,isbtn,isreset,weight,price,btnnum,pos1,out1);
segMsg2 U6(clk190hz,sum,single,isbtn,isreset,pos2,out2);
endmodule
