`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 13:53:57
// Design Name: 
// Module Name: segMsg1
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


module segMsg1(
input clk190hz,
input isbtn,
input isreset,
input [3:0]weight,
input [3:0]price,
input [3:0]btnnum,
output reg [3:0]pos,
output reg[7:0]seg
    );
    reg [1:0]posC=2'b00;
    reg[3:0] dataP=4'b0000;

always @(posedge clk190hz) begin
        if(isreset)begin
            pos<=4'b1111;
            dataP<=0;
    end
    
    else if(!isbtn)begin       
        case (posC)
            0:begin
                pos<=4'b1000;
                if(weight>=10)
                dataP<=1;
                else
                dataP<=0;
            end
            1:begin
                pos<=4'b0100;
                if(weight>=10)
                dataP<=weight-10;
                else
                dataP<=weight;
            end
            2:begin
                pos<=4'b0010;
                if(price>=10)
                dataP<=1;
                else
                dataP<=0;
            end
            3:begin
                pos<=4'b0001;
                if(price>=10)
                dataP<=price-10;
                else 
                dataP<=price;
            end
            default: pos<=4'b0000;
        endcase
        posC<=posC+1;
    end

    else begin
        case (posC)
            0:begin
                pos<=4'b1000;
                dataP<=10;
                end
            1:begin
                pos<=4'b0100;
                dataP<=12;
            end
            2:begin
                pos<=4'b0010;
                if(btnnum>=10)
                dataP<=1;
                else
                dataP<=0;
            end
            3:begin
                pos<=4'b0001;
                if(btnnum>=10)
                dataP<=btnnum-10;
                else
                dataP<=btnnum;
            end
            default: pos<=4'b1111;
        endcase
        posC<=posC+1;
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
        10:seg=8'b0111_0111;
        11:seg=8'b0111_1100;
        12:seg=8'b0011_1001;
        default:seg=8'b0000_1000;
        endcase
endmodule
