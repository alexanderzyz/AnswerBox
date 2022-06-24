`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 16:10:43
// Design Name: 
// Module Name: segMsg
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


module segMsg(
input clk,
input[3:0] controll,
input [7:0] data,
input [7:0] RX,
input [15:0] mulresult,
input [3:0] addra,
input [15:0]dinout,
output reg [3:0] pos1=4'b0000,
output reg [3:0] pos2=4'b0000,
output reg [7:0] seg1,
output reg [7:0] seg2
    );
    parameter void = 4'b0000,load=4'b0001,move=4'b0011,showmove=4'b0100,add=4'b0101;
    parameter showadd=4'b0110,sub=4'b0111,showsub=4'b1000,mul=4'b1001,showmul=4'b1010,show=4'b1011;
reg[3:0] dataP1=4'b0000;
reg[3:0] dataP2=4'b0000;
reg[1:0] posC=2'b00;
always @(posedge clk) begin
    case (posC)
        0:begin
            pos1<=4'b1000;
            pos2<=4'b1000;
            if (controll==void) begin
                dataP1<=data[7]?1:0;
                dataP2<=data[3]?1:0;
            end
            else if(controll==load)begin
                dataP1<=(data/10000000)%10;
                dataP2<=(data/1000)%10;
            end
            else if(controll==showmove||controll==showadd||controll==showsub)begin
                dataP1<=(RX/10000000)%10;
                dataP2<=(RX/1000)%10;
            end
            else if (controll==showmul) begin
                dataP1<=(mulresult/10000000)%10;
                dataP2<=(mulresult/1000)%10;
            end
            else if (controll==show) begin
                dataP1<=addra[3]?1:0;
                dataP2<=(dinout/1000)%10;
            end
        end
        1:begin
            pos1<=4'b0100;
            pos2<=4'b0100;
            if (controll==void) begin
                dataP1<=data[6]?1:0;
                dataP2<=data[2]?1:0;
            end
            else if(controll==load)begin
                dataP1<=(data/1000000)%10;
                dataP2<=(data/100)%10;
            end
            else if(controll==showmove||controll==showadd||controll==showsub)begin
                dataP1<=(RX/1000000)%10;
                dataP2<=(RX/100)%10;
            end
            else if (controll==showmul) begin
                dataP1<=(mulresult/1000000)%10;
                dataP2<=(mulresult/100)%10;
            end
            else if (controll==show) begin
                dataP1<=addra[2]?1:0;
                dataP2<=(dinout/100)%10;
            end
        end
        2:begin
            pos1<=4'b0010;
            pos2<=4'b0010;
            if (controll==void) begin
                dataP1<=data[5]?1:0;
                dataP2<=data[1]?1:0;
            end
            else if(controll==load)begin
                dataP1<=(data/100000)%10;
                dataP2<=(data/10)%10;
            end
            else if(controll==showmove||controll==showadd||controll==showsub)begin
                dataP1<=(RX/100000)%10;
                dataP2<=(RX/10)%10;
            end
            else if (controll==showmul) begin
                dataP1<=(mulresult/100000)%10;
                dataP2<=(mulresult/10)%10;
            end
            else if (controll==show) begin
                dataP1<=addra[1]?1:0;
                dataP2<=(dinout/10)%10;
            end
        end
        3: begin
            pos1<=4'b0001;
            pos2<=4'b0001;
            if (controll==void) begin
                dataP1<=data[4]?1:0;
                dataP2<=data[0]?1:0;
            end
            else if(controll==load)begin
                dataP1<=(data/10000)%10;
                dataP2<=(data)%10;
            end
            else if(controll==showmove||controll==showadd||controll==showsub)begin
                dataP1<=(RX/10000)%10;
                dataP2<=(RX)%10;
            end
            else if (controll==showmul) begin
                dataP1<=(mulresult/10000)%10;
                dataP2<=(mulresult)%10;
            end
            else if (controll==show) begin
                dataP1<=addra[0]?1:0;
                dataP2<=(dinout)%10;
            end
        end
        default: begin
            pos1<=4'b1111;
            pos2<=4'b1111;
        end
    endcase
    posC<=posC+1;
end


always@(*)begin
case(dataP1)
        0:seg1 = 8'b0011_1111;
        1:seg1=8'b0000_0110;
        2:seg1=8'b0101_1011;
        3:seg1=8'b0100_1111;
        4:seg1=8'b0110_0110;
        5:seg1=8'b0110_1101;
        6:seg1=8'b0111_1101;
        7:seg1=8'b0000_0111;
        8:seg1=8'b0111_1111;
        9:seg1=8'b0110_1111;
        10:seg1=8'b0100_0000;
        11:seg1=8'b0000_0000;
        default:seg1=8'b0000_1000;
        endcase
case (dataP2)
        0:seg2 = 8'b0011_1111;
        1:seg2=8'b0000_0110;
        2:seg2=8'b0101_1011;
        3:seg2=8'b0100_1111;
        4:seg2=8'b0110_0110;
        5:seg2=8'b0110_1101;
        6:seg2=8'b0111_1101;
        7:seg2=8'b0000_0111;
        8:seg2=8'b0111_1111;
        9:seg2=8'b0110_1111;
        10:seg2=8'b0100_0000;
        11:seg2=8'b0000_0000;
        default:seg2=8'b0000_1000;
endcase
end
endmodule
