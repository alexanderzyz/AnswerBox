`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 15:43:39
// Design Name: 
// Module Name: controller
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


 module controller(
input clk,
input reset,
input[7:0] data,
input sure,
output reg[3:0] controll=4'b00000,
output reg[3:0] addra=4'b0000,
output reg[3:0] showaddra,
output reg calculate=0,
output reg wea=0,
output reg [1:0]outreg1,
output reg [1:0]outreg2
    );
    reg[3:0] next_state=4'b0000;
    parameter void = 4'b0000,load=4'b0001,move=4'b0011,showmove=4'b0100,add=4'b0101,showadd=4'b0110,sub=4'b0111,showsub=4'b1000,mul=4'b1001,showmul=4'b1010,show=4'b1011;
always @(posedge clk or posedge reset) begin
    if(reset)controll<=void;
    else begin
        controll<=next_state;
        if(controll==show)begin showaddra[3:2]<=outreg1; showaddra[1:0]<=outreg2;end
        else showaddra<=addra;
        if((controll==load&&next_state==void)||controll==showadd||controll==showsub||controll==showmove||controll==showmul)begin calculate<=1; end
        else begin calculate<=0;end
        if((controll==load)||controll==showadd||controll==showsub||controll==showmove||controll==showmul)begin wea<=1; end
        else begin wea<=0; end
    end
end
always @(posedge sure) begin
    case (controll)
        void:
        if (data[7:4]==4'b0000) begin
            next_state<=load;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
        end 
        else if (data[7:4]==4'b0001) begin
            next_state<=showmove;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
            if(data[1:0]==2'b00)outreg2<=2'b00;
            else if(data[1:0]==2'b01)outreg2<=2'b01;
            else if(data[1:0]==2'b10)outreg2<=2'b10;
            else if(data[1:0]==2'b11)outreg2<=2'b11;
        end
        else if (data[7:4]==4'b0010) begin
            next_state<=showadd;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
            if(data[1:0]==2'b00)outreg2<=2'b00;
            else if(data[1:0]==2'b01)outreg2<=2'b01;
            else if(data[1:0]==2'b10)outreg2<=2'b10;
            else if(data[1:0]==2'b11)outreg2<=2'b11;
        end
        else if(data[7:4]==4'b0100)begin
            next_state<=showmul;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
            if(data[1:0]==2'b00)outreg2<=2'b00;
            else if(data[1:0]==2'b01)outreg2<=2'b01;
            else if(data[1:0]==2'b10)outreg2<=2'b10;
            else if(data[1:0]==2'b11)outreg2<=2'b11;
        end
         else if(data[7:4]==4'b0011)begin
            next_state<=showsub;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
            if(data[1:0]==2'b00)outreg2<=2'b00;
            else if(data[1:0]==2'b01)outreg2<=2'b01;
            else if(data[1:0]==2'b10)outreg2<=2'b10;
            else if(data[1:0]==2'b11)outreg2<=2'b11;
        end
        else if (data[7:4]==4'b1111) begin
            next_state<=show;
            if(data[3:2]==2'b00)outreg1<=2'b00;
            else if(data[3:2]==2'b01)outreg1<=2'b01;
            else if(data[3:2]==2'b10)outreg1<=2'b10;
            else if(data[3:2]==2'b11)outreg1<=2'b11;
            if(data[1:0]==2'b00)outreg2<=2'b00;
            else if(data[1:0]==2'b01)outreg2<=2'b01;
            else if(data[1:0]==2'b10)outreg2<=2'b10;
            else if(data[1:0]==2'b11)outreg2<=2'b11;
        end
        load:begin
        next_state<=void;
        addra<=addra+1;
        end
        showmove:begin
        next_state<=void;
        addra<=addra+1;
        end    
        showsub:begin
        next_state<=void;
        addra<=addra+1;
        end
        showmul:begin
        next_state<=void;
        addra<=addra+1;
        end
        showadd:begin
        next_state<=void;
        addra<=addra+1;
        end
        show:begin
        next_state<=void;
        end
        default: begin
        next_state<=void;
        end
    endcase
end
endmodule
