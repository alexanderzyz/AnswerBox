`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/24 14:29:49
// Design Name: 
// Module Name: segMsg2
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


module segMsg2(
input clk3hz,
input clk190hz,
input [31:0] selnum,
input [7:0]put,
input judge,
output reg [3:0] pos,
output reg[7:0] seg
    );
    reg [1:0]posC=2'b00;
    reg [3:0]dataP=4'b0000;
always@(posedge clk190hz)begin
if(judge==1'b1)pos<=4'b0000;
else begin
if(put>8'b0000_1000)begin
case(posC)
0:begin
if(put==8'b0001_0000&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0001;
end
dataP<=selnum[19:16];
end
1:begin
if(put==8'b0010_0000&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0010;
end
dataP<=selnum[23:20];
end
2:begin
if(put==8'b0100_0000&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0100;
end
dataP<=selnum[27:24];
end
3:begin
if(put==8'b1000_0000&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b1000;
end
dataP<=selnum[31:28];
end
endcase
posC=posC+1;
end 
else begin
case(posC)
0:begin
if(put==8'b000_0001&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0001;
end
dataP<=selnum[3:0];
end
1:begin
if(put==8'b0000_0010&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0010;
end
dataP<=selnum[7:4];
end
2:begin
if(put==8'b000_0100&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b0100;
end
dataP<=selnum[11:8];
end
3:begin
if(put==8'b0000_1000&&clk3hz)
pos<=4'b0000;
else begin
pos<=4'b1000;
end
dataP<=selnum[15:12];
end
endcase
posC=posC+1;
end
end
end
always@(dataP)
case(dataP)
        0:seg = 8'b0011_1111;
        1:seg=8'b0000_0110;
        2:seg=8'b0101_1011;
        3:seg=8'b0100_1111;
        4:seg=8'b0110_0110;
        5:seg=8'b0110_1101;
        6:seg=8'b0111_1101;
        7:seg=8'b0000_0111;
        8:seg=8'b0111_1111;
        9:seg=8'b0110_1111;
        10:seg=8'b0100_0000;
        11:seg=8'b0000_0000;
        default:seg=8'b0000_1000;
        endcase
endmodule
