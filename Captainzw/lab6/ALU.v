`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 16:09:58
// Design Name: 
// Module Name: ALU
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


module ALU(
input calculate,
input[3:0] controll,
input[1:0] outreg1,
input[1:0] outreg2, 
input[7:0] data,
output reg[7:0] Rx=8'b0000_0000,
output reg[7:0] Ry=8'b0000_0000,
output reg[7:0] Rz=8'b0000_0000,
output reg[7:0] Rt=8'b0000_0000,
output reg[7:0] dataout
    );

    parameter void = 4'b0000,load=4'b0001,move=4'b0011,showmove=4'b0100,add=4'b0101,showadd=4'b0110,sub=4'b0111,showsub=4'b1000,mul=4'b1001,showmul=4'b1010,show=4'b1011;
    always@(*)begin 
    if(controll==load) dataout=data;
    else if(outreg1==2'b00)dataout=Rx;
    else if(outreg1==2'b01)dataout=Ry;
    else if(outreg1==2'b10)dataout=Rz;
    else if(outreg1==2'b11)dataout=Rt;
    end
    
    always @(posedge calculate) begin
        if(controll==load||controll==void)begin
     if(outreg1==2'b00)Rx=data;
        else if(outreg1==2'b01)Ry=data;
        else if(outreg1==2'b10)Rz=data;
        else if(outreg1==2'b11)Rt=data;
     end
       else  if(controll==showmove)begin
            if(outreg1==2'b00&&outreg2==2'b00)Rx=Rx;
           else if(outreg1==2'b00&&outreg2==2'b01)Rx=Ry;
           else if(outreg1==2'b00&&outreg2==2'b10)Rx=Rz;
           else if(outreg1==2'b00&&outreg2==2'b11)Rx=Rt;                    
       else if(outreg1==2'b01&&outreg2==2'b00)Ry=Rx;
           else if(outreg1==2'b01&&outreg2==2'b01)Ry=Ry;
           else if(outreg1==2'b01&&outreg2==2'b10)Ry=Rz;
           else if(outreg1==2'b01&&outreg2==2'b11)Ry=Rt;  
           else if(outreg1==2'b10&&outreg2==2'b00)Rz=Rx;
           else if(outreg1==2'b10&&outreg2==2'b01)Rz=Ry;
           else if(outreg1==2'b10&&outreg2==2'b10)Rz=Rz;
           else if(outreg1==2'b10&&outreg2==2'b11)Rz=Rt;
           else if(outreg1==2'b11&&outreg2==2'b00)Rt=Rx;
           else if(outreg1==2'b11&&outreg2==2'b01)Rt=Ry;
           else if(outreg1==2'b11&&outreg2==2'b10)Rt=Rz;
           else if(outreg1==2'b11&&outreg2==2'b11)Rt=Rt;
        end
        else if(controll==showadd)begin
            if(outreg1==2'b00&&outreg2==2'b00)Rx=Rx+Rx;
           else if(outreg1==2'b00&&outreg2==2'b01)Rx=Rx+Ry;
           else if(outreg1==2'b00&&outreg2==2'b10)Rx=Rx+Rz;
           else if(outreg1==2'b00&&outreg2==2'b11)Rx=Rx+Rt;                    
       else if(outreg1==2'b01&&outreg2==2'b00)Ry=Ry+Rx;
           else if(outreg1==2'b01&&outreg2==2'b01)Ry=Ry+Ry;
           else if(outreg1==2'b01&&outreg2==2'b10)Ry=Ry+Rz;
           else if(outreg1==2'b01&&outreg2==2'b11)Ry=Ry+Rt; 
           else if(outreg1==2'b10&&outreg2==2'b00)Rz=Rz+Rx;
           else if(outreg1==2'b10&&outreg2==2'b01)Rz=Rz+Ry;
           else if(outreg1==2'b10&&outreg2==2'b10)Rz=Rz+Rz;
           else if(outreg1==2'b10&&outreg2==2'b11)Rz=Rz+Rt;
           else if(outreg1==2'b11&&outreg2==2'b00)Rt=Rt+Rx;
           else if(outreg1==2'b11&&outreg2==2'b01)Rt=Rt+Ry;
           else if(outreg1==2'b11&&outreg2==2'b10)Rt=Rt+Rz;
           else if(outreg1==2'b11&&outreg2==2'b11)Rt=Rt+Rt;
           
        end
        else if(controll==showsub)begin
            if(outreg1==2'b00&&outreg2==2'b00)Rx=Rx-Rx;
           else if(outreg1==2'b00&&outreg2==2'b01)Rx=Rx-Ry;
           else if(outreg1==2'b00&&outreg2==2'b10)Rx=Rx-Rz;
           else if(outreg1==2'b00&&outreg2==2'b11)Rx=Rx-Rt;                    
       else if(outreg1==2'b01&&outreg2==2'b00)Ry=Ry-Rx;
           else if(outreg1==2'b01&&outreg2==2'b01)Ry=Ry-Ry;
           else if(outreg1==2'b01&&outreg2==2'b10)Ry=Ry-Rz;
           else if(outreg1==2'b01&&outreg2==2'b11)Ry=Ry-Rt;
           else if(outreg1==2'b10&&outreg2==2'b00)Rz=Rz-Rx;
           else if(outreg1==2'b10&&outreg2==2'b01)Rz=Rz-Ry;
           else if(outreg1==2'b10&&outreg2==2'b10)Rz=Rz-Rz;
           else if(outreg1==2'b10&&outreg2==2'b11)Rz=Rz-Rt;
           else if(outreg1==2'b11&&outreg2==2'b00)Rt=Rt-Rx;
           else if(outreg1==2'b11&&outreg2==2'b01)Rt=Rt-Ry;
           else if(outreg1==2'b11&&outreg2==2'b10)Rt=Rt-Rz;
           else if(outreg1==2'b11&&outreg2==2'b11)Rt=Rt-Rt;  
        end
    end
endmodule
