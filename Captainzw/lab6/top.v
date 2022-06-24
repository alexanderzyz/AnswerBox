`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/15 15:43:53
// Design Name: 
// Module Name: top
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


module top(
input clk,
input[7:0] data,
input reset,
input sure,
output[3:0] pos1,
output[3:0] pos2,
output[7:0] seg1,
output[7:0] seg2
    );
    wire clk190hz,clk3hz,clk1hz,newreset,newsure;
    wire[3:0] controll;
    wire[3:0] addra;
    wire[7:0] RX, RY, RZ, RT;
    wire calculate;
    wire [7:0]dataout;
    wire[15:0] MULTP;
    wire[15:0] din;
    wire[15:0] dout;
    wire[3:0] showaddra;
    wire [1:0]outreg1,outreg2;
    wire wea;
    BEAM U1(.addra(showaddra),.clka(clk),.dina(din),.douta(dout),.ena(1),.wea(wea),.rsta(newreset));  //�洢��
    clkDiv U2(clk,clk190hz,clk3hz,clk1hz);          //��Ƶ
    keyled U3(clk,reset,newreset);                  //�������ð�ť
    keyled U4(clk,sure,newsure);                    //����ȷ�ϰ�ť
    controller U5(clk,newreset,data,newsure,controll,addra,showaddra,calculate,wea,outreg1,outreg2); //���Ƶ�ַ�͵�ǰ����״̬
    ALU U6(calculate,controll,outreg1,outreg2,data,RX,RY,RZ,RT,dataout);   //LOAD,ADD,SUB����
    mutiplier U9(calculate,controll,RX,RY,RZ,RT,outreg1,outreg2,MULTP);  //�˷���
    segMsg U10(clk190hz,controll,data,dataout,MULTP,showaddra,dout,pos1,pos2,seg1,seg2);
    memoryin U11(dataout,MULTP,controll,din);
endmodule
