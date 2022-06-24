`timescale 1ns / 1ps

module add32_tb();
    reg [31:0]a;
    reg [31:0]b;
    reg cin;
    reg clk,clk2;
    wire [31:0]s0,s1,s2;
    wire cout0,cout1,cout2;
    initial begin
        a=4'bxxxx;
        b=4'bxxxx;
        cin=1'bx;
        clk = 0;
        clk2=0;
    end
    always begin
    #100 clk = ~clk;
    #20 clk2=~clk2;
    end
    always@(posedge clk)begin
        a={$random}%2**30;
        b={$random}%2**30;
       cin={$random}%2;
        #150 cin=1'bx;
    end
    pipelineadder test(clk2,a,b,cin,s0,cout0);
    rcadd32 B(a,b,cin,s2,cout2);//逐位加法�???
    csadd32 A(a,b,cin,s1,cout1);//选择加法�???
//    claadd32 C(a,b,cin,s2,cout2);//超前加法�???
endmodule


module csadd32(
input [31:0]a,
input [31:0]b,
input cin,
output [31:0]s,
output cout
);
wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14;
wire cout1,cout2;
wire [31:0]s1,s2;
csadd4 bit1(a[3:0],b[3:0],1,s1[3:0],c1);
csadd4 bit2(a[7:4],b[7:4],c1,s1[7:4],c2);
csadd4 bit3(a[11:8],b[11:8],c2,s1[11:8],c3);
csadd4 bit4(a[15:12],b[15:12],c3,s1[15:12],c4);
csadd4 bit5(a[19:16],b[19:16],c4,s1[19:16],c5);
csadd4 bit6(a[23:20],b[23:20],c5,s1[23:20],c6);
csadd4 bit7(a[27:24],b[27:24],c6,s1[27:24],c7);
csadd4 bit8(a[31:28],b[31:28],c7,s1[31:28],cout1);
csadd4 bit9(a[3:0],b[3:0],0,s2[3:0],c8);
csadd4 bit10(a[7:4],b[7:4],c8,s2[7:4],c9);
csadd4 bit11(a[11:8],b[11:8],c9,s2[11:8],c10);
csadd4 bit12(a[15:12],b[15:12],c10,s2[15:12],c11);
csadd4 bit13(a[19:16],b[19:16],c11,s2[19:16],c12);
csadd4 bit14(a[23:20],b[23:20],c12,s2[23:20],c13);
csadd4 bit15(a[27:24],b[27:24],c13,s2[27:24],c14);
csadd4 bit16(a[31:28],b[31:28],c14,s2[31:28],cout2);
assign cout=cin==1 ? cout1:cout2;
assign s=cin==1 ? s1:s2;
endmodule

module rcadd32(
input [31:0]a,
input [31:0]b,
input cin,
output [31:0]s,
output cout
);
wire c1,c2,c3,c4,c5,c6,c7;
add4 bit1(a[3:0],b[3:0],cin,s[3:0],c1);
add4 bit2(a[7:4],b[7:4],c1,s[7:4],c2);
add4 bit3(a[11:8],b[11:8],c2,s[11:8],c3);
add4 bit4(a[15:12],b[15:12],c3,s[15:12],c4);
add4 bit5(a[19:16],b[19:16],c4,s[19:16],c5);
add4 bit6(a[23:20],b[23:20],c5,s[23:20],c6);
add4 bit7(a[27:24],b[27:24],c6,s[27:24],c7);
add4 bit8(a[31:28],b[31:28],c7,s[31:28],cout);
endmodule
//�???位全加器



module add4(
input [3:0]a,
input [3:0]b,
input cin,
output [3:0]s,
output cout);
wire c1,c2,c3;
add1 bit1(a[0],b[0],cin,s[0],c1);
add1 bit2(a[1],b[1],c1,s[1],c2);
add1 bit3(a[2],b[2],c2,s[2],c3);
add1 bit4(a[3],b[3],c3,s[3],cout);
endmodule

module csadd4(
input [3:0]a,
input [3:0]b,
input cin,
output [3:0]s,
output cout);
wire c1,c2,c3,c4,c5,c6;
wire cout1,cout2;
wire [3:0] s1,s2;
add1 bit1(a[0],b[0],1,s1[0],c1);
add1 bit2(a[1],b[1],c1,s1[1],c2);
add1 bit3(a[2],b[2],c2,s1[2],c3);
add1 bit4(a[3],b[3],c3,s1[3],cout1);
add1 bit5(a[0],b[0],0,s2[0],c4);
add1 bit6(a[1],b[1],c4,s2[1],c5);
add1 bit7(a[2],b[2],c5,s2[2],c6);
add1 bit8(a[3],b[3],c6,s2[3],cout2);
assign cout=cin==1 ? cout1:cout2;
assign s=cin==1 ? s1:s2;
endmodule

module add1(
	input a,
	input b,
	input cin,
	output sum,
	output cout);
	assign #4 sum = a ^ b ^ cin;
	assign #2 cout =  (cin==1)|(cin==0)?(a & cin) | (b & cin)| (a & b):1'bx;
	//assign #3 cout = (a & b) | (a & cin) | (b & cin);
endmodule

module pipelineadder(
    input clk,
    input [31:0]a,
    input [31:0]b,
    input cin,
    output reg [31:0]s,
    output cout
);
wire c1,c2,c3;
reg bit2cout1,bit3cout1,bit4cout1;
wire[7:0] bit1out1,bit2out1,bit3out1,ps;
reg [7:0]bit1out2,bit1out3;
reg [7:0]bit2in1a,bit2in1b,bit2out2;
reg [7:0]bit3in1a,bit3in1b,bit3in2a,bit3in2b;
reg [7:0]bit4in1a,bit4in1b,bit4in2a,bit4in2b,bit4in3a,bit4in3b;
adder8 bit1(a[7:0],b[7:0],cin,bit1out1,c1);
adder8 bit2(bit2in1a,bit2in1b,bit2cout1,bit2out1,c2);
adder8 bit3(bit3in2a,bit3in2b,bit3cout1,bit3out1,c3);
adder8 bit4(bit4in3a,bit4in3b,bit4cout1,ps,cout);
always@(*)begin
    s[31:24]=ps;
end
always @(posedge clk) begin
    s[7:0]<=bit1out3;
    bit1out3<=bit1out2;
    bit1out2<=bit1out1;
end
always @(posedge clk) begin
    bit2in1a<=a[15:8];
    bit2in1b<=b[15:8];
    bit2out2<=bit2out1;
    bit2cout1<=c1;
    s[15:8]<=bit2out2;
end
always @(posedge clk) begin
    bit3in1a<=a[23:16];
    bit3in1b<=b[23:16];
    bit3in2a<=bit3in1a;
    bit3in2b<=bit3in1b;
    bit3cout1<=c2;
    s[23:16]<=bit3out1;
end
always @(posedge clk) begin
    bit4in1a<=a[31:24];
    bit4in1b<=b[31:24];
    bit4in2a<=bit4in1a;
    bit4in2b<=bit4in1b;
    bit4in3a<=bit4in2a;
    bit4in3b<=bit4in2b;
    bit4cout1<=c3;
end
endmodule


module adder8(
    input [7:0]a,
input [7:0]b,
input cin,
output [7:0]s,
output cout
);
wire c1;
add4 bit1(a[3:0],b[3:0],cin,s[3:0],c1);
add4 bit2(a[7:4],b[7:4],c1,s[7:4],cout);
endmodule