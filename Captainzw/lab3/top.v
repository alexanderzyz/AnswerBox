`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/24 12:34:25
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
input clk100mhz,
input clr,
input reset,
input rightbutton,
input leftbutton,
input upbutton,
input downbutton,
input surebtn,
output [3:0] showpos,
output [3:0] selectpos,
output [7:0] showseg,
output [7:0] selectseg
    );
    wire clk190hz,clk3hz,clk1hz;
    wire [15:0]dataBus;
    wire [31:0]selnum;
    wire [7:0] put;
    wire ubtn,dbtn,lbtn,rbtn,sure;
    keyled Um2(clk100mhz,leftbutton,lbtn);
    keyled Um3(clk100mhz,upbutton,ubtn);
    keyled Um4(clk100mhz,downbutton,dbtn);
    keyled Um1(clk100mhz,rightbutton,rbtn);
    keyled Um5(clk100mhz,surebtn,sure);
    clkDiv U1(clk100mhz,clk190hz,clk3hz,clk1hz);
    select U4(reset, rbtn, lbtn,ubtn,dbtn,clk100mhz,sure,selnum,put);
    segMsg U3(clk190hz,dataBus,reset,put,showpos,showseg);
    segMsg2 U5(clk1hz,clk190hz,selnum,put,reset,selectpos,selectseg);
    GPU U2(clk3hz,clr,selnum,dataBus);

endmodule
