`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 13:53:57
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
input clk190hz,
input[15:0] sum,
input[15:0] single,
input isbtn,
input isreset,
output reg[3:0] pos,
output reg[7:0] seg
    );
    reg [1:0]posC=2'b00;
    reg [3:0]dataP=4'b0000;
    always @(posedge clk190hz) begin
        if(isreset)begin
            pos<=4'b1111;
            dataP<=0;
        end
        else if(isbtn)begin
             case (posC)
            0:begin
                pos<=4'b0001;
                dataP<=sum%10;
            end
            1:begin
                pos<=4'b0010;
                dataP<=(sum/10)%10;
            end
            2:begin
                pos<=4'b0100;
                dataP<=(sum/100)%10;
            end
            3: begin
                pos<=4'b1000;
                dataP<=(sum/1000)%10;
            end
            default: pos<=4'b0000;
        endcase
        posC<=posC+1;
        end
        else begin
        case (posC)
            0:begin
                pos<=4'b0001;
                dataP<=single%10;
            end
            1:begin
                pos<=4'b0010;
                dataP<=(single/10)%10;
            end
            2:begin
                pos<=4'b0100;
                dataP<=(single/100)%10;
            end
            3: begin
                pos<=4'b1000;
                dataP<=(single/1000)%10;
            end
            default: pos<=4'b0000;
        endcase
        posC<=posC+1;
    end
    end
always @(dataP) begin
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
end
endmodule
