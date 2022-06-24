`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 16:09:47
// Design Name: 
// Module Name: mutiplier
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


module mutiplier(
input calculate,
input [3:0] controll,
input [7:0] RX,
input [7:0] RY,
input [7:0] RZ,
input [7:0] RT,
input[1:0] outreg1,
input[1:0] outreg2,
output reg [15:0] dataout=0
    );
    reg[15:0]ry;
    reg[7:0] temprx;
    always@(*)begin
    if(outreg2==2'b00)ry[7:0]=RX;
    else if(outreg2==2'b01)ry[7:0]=RY;
    else if(outreg2==2'b10)ry[7:0]=RZ;
    else if(outreg2==2'b11)ry[7:0]=RT;
    if(outreg1==2'b00)temprx=RX;
    else if(outreg1==2'b01)temprx=RY;
    else if(outreg1==2'b10)temprx=RZ;
    else if(outreg1==2'b11)temprx=RT;
    ry[15:8]=0;
    end
    integer temp;
    always @(posedge calculate) begin
                dataout=0;
        if(controll==4'b1010)begin
            for(temp=0;temp<8;temp=temp+1)begin
            if(temprx[temp]==1'b1) begin
                dataout=dataout+(ry<<temp);
            end
            end
        end
    end
endmodule
