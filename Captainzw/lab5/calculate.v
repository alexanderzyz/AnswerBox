`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 13:39:24
// Design Name: 
// Module Name: calculate
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


module calculate(
input clk,
input [3:0] weight,
input [3:0] price,
input reset,
input btn,
output reg[3:0] btnnum=4'b0000,
output reg isreset=1'b0,
output  isbtn,
output reg [15:0]single,
output reg[15:0] sum=16'h0000
    );
    reg[3:0]tempweight;
reg[3:0]tempprice;
reg temp=1'b0;
reg temp2=1'b0;
assign isbtn=temp2;
always @(posedge clk) begin
    if(!isreset)begin
            single<=weight*price;
    if(isbtn==1&&temp==0)begin
     sum<=sum+single;
        btnnum<=btnnum+1;
        end
        temp=isbtn;
    end
    else begin
    sum<=0;
    btnnum<=0;
    single<=0;
    end
end

always @(posedge clk or posedge reset) begin
    if(reset)isreset<=1'b1;
    else if ((weight!=tempweight)||(price!=tempprice))begin
    isreset<=1'b0;
    end
    tempprice<=price;
    tempweight<=weight;
end
always @(posedge clk) begin
    if(btn)temp2<=1'b1;
    else if ((weight!=tempweight)||(price!=tempprice))begin
    temp2<=1'b0;
    end
    tempprice<=price;
    tempweight<=weight;
end
endmodule
