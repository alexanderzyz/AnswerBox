`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 23:55:29
// Design Name: 
// Module Name: Regselect2
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


module Regselect2(
input controll,
input calculate,
input[1:0] outreg,
input[7:0] data,
input[7:0] dataout,
output reg[7:0] Rx=0,
output reg[7:0] Ry=0,
output reg [7:0] Rz=0,
output reg[7:0] Rt=0
    );
    always @(posedge calculate) begin
    if(controll==4'b0001)begin
     if(outreg==2'b00)Rx=data;
        else if(outreg==2'b01)Ry=data;
        else if(outreg==2'b10)Rz=data;
        else if(outreg==2'b11)Rt=data;
     end
    
      else begin
        if(data[3:2]==2'b00)Rx=dataout;
        else if(data[3:2]==2'b01)Ry=dataout;
        else if(data[3:2]==2'b10)Rz=dataout;
        else if(data[3:2]==2'b11)Rt=dataout;
    end
    end
endmodule
