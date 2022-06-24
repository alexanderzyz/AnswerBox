module segMsg(
input clk190hz,
input [15:0] dataBus,
input judge,
input [7:0]put,
output reg [3:0] pos,
output reg[7:0] seg);
reg[1:0]posC=2'b00;
reg[3:0]dataP=4'b0000;
always@(posedge clk190hz)begin
if(judge==1'b0)begin
case(posC)
0:begin
pos<=4'b0001;
dataP<=4'b1010;
end
1:begin
pos<=4'b0010;
if(put==8'b1000_0000)
dataP<=4'b1000;
else if(put==8'b0100_0000)
dataP<=4'b0111;
else if(put==8'b0010_0000)
dataP<=4'b0110;
else if(put==8'b0001_0000)
dataP<=4'b0101;
else if(put==8'b0000_1000)
dataP<=4'b0100;
else if(put==8'b0000_0100)
dataP<=4'b0011;
else if(put==8'b0000_0010)
dataP<=4'b0010;
else if(put==8'b0000_0001)
dataP<=4'b0001;
else dataP<=4'b1011;
end
2:begin
pos<=4'b0100;
dataP<=4'b1010;
end
3:begin
pos<=4'b0000;
end
endcase
posC=posC+1;
end
else
begin
case(posC)
0:begin
pos<=4'b0001;
dataP<=dataBus[3:0];
end
1:begin
pos<=4'b0010;
dataP<=dataBus[7:4];
end
2:begin
pos<=4'b0100;
dataP<=dataBus[11:8];
end
3:begin
pos<=4'b1000;
dataP<=dataBus[15:12];
end
endcase
posC=posC+1;
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