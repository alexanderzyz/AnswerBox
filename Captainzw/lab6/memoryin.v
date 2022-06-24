`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/19 21:12:41
// Design Name: 
// Module Name: memoryin
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


module memoryin(
input[7:0] temprx,
input[15:0] mulresult,
input[3:0] controll,
output reg[15:0]din
    );
    parameter void = 4'b0000,load=4'b0001,move=4'b0011,showmove=4'b0100,add=4'b0101;
    parameter showadd=4'b0110,sub=4'b0111,showsub=4'b1000,mul=4'b1001,showmul=4'b1010,show=4'b1011;
    always@(*)begin
    if((controll==load) || (controll==showmove) ||(controll==showadd)||(controll==showsub))begin
            din[7:0]=temprx;
            din[15:8]=0;
        end
    else if(controll==showmul)begin
    din=mulresult;
    end
    end
endmodule
