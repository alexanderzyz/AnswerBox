`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/24 13:47:05
// Design Name: 
// Module Name: select
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


module select(
input reset,
input rbtn,
input lbtn,
input ubtn,
input dbtn,
input clk,
input sure,
output [31:0] num,
output [7:0] put
    );
    reg[31:0]tempnum=32'b0;
    reg[7:0] temp=8'b1000_0000;
    assign put=temp;
    assign num=tempnum;
    reg right=0,left=0,up=0,down=0;
    always@(posedge clk or posedge sure)begin
    if(sure==1'b1)begin
    temp=8'b1000_0000;
    end
    else if(reset==0)
   if(lbtn==1'b1&&left==1'b0)begin
    if(temp==8'b1000_0000)
    temp=8'b0000_0001;
    else temp=temp<<1;
   end
    else if(rbtn==1'b1&&right==1'b0) begin
    if(temp==8'b0000_0001)
    temp=8'b1000_0000;
    else temp=temp>>1;
    end
left=lbtn;
right=rbtn;
       end
      always@(posedge clk or posedge sure)begin
      if(sure==1'b1)begin
      tempnum=0;
      end
     else if(reset==0)
      if(ubtn==1'b1&&up==1'b0)begin
    if(temp==8'b1000_0000)begin
    if(tempnum[31:28]==4'b1001)tempnum[31:28]=4'b0000;
    else tempnum[31:28]=tempnum[31:28]+1'b1;
    end
    
    else if(temp==8'b0100_0000)begin
    if(tempnum[27:24]==4'b1001)tempnum[27:24]=4'b0000;
    else tempnum[27:24]<=tempnum[27:24]+1'b1;
    end
    
    else if(temp==8'b0010_0000)begin
    if(tempnum[23:20]==4'b1001)tempnum[23:20]=4'b0000;
    else tempnum[23:20]<=tempnum[23:20]+1'b1;
    end
    
    else if(temp==8'b0001_0000)begin
    if(tempnum[19:16]==4'b1001)tempnum[19:16]=4'b0000;
    else tempnum[19:16]<=tempnum[19:16]+1'b1;
    end
    
    else if(temp==8'b0000_1000)begin
    if(tempnum[15:12]==4'b1001)tempnum[15:12]=4'b0000;
    else tempnum[15:12]<=tempnum[15:12]+1'b1;
    end
    
    else if(temp==8'b0000_0100)begin
    if(tempnum[11:8]==4'b1001)tempnum[11:8]=4'b0000;
    else tempnum[11:8]<=tempnum[11:8]+1'b1;
    end
    
    else if(temp==8'b0000_0010)begin
    if(tempnum[7:4]==4'b1001)tempnum[7:4]=4'b0000;
    else tempnum[7:4]<=tempnum[7:4]+1'b1;
    end
    
    else if(temp==8'b0000_0001)begin
    if(tempnum[3:0]==4'b1001)tempnum[3:0]=4'b0000;
    else tempnum[3:0]<=tempnum[3:0]+1'b1;
    end
    end
    
    else if(dbtn==1'b1&&down==1'b0)begin
     if(temp==8'b1000_0000)begin
    if(tempnum[31:28]==4'b0000)tempnum[31:28]=4'b1001;
    else tempnum[31:28]<=tempnum[31:28]-1'b1;
    end
    
    else if(temp==8'b0100_0000)begin
    if(tempnum[27:24]==4'b0000)tempnum[27:24]=4'b1001;
    else tempnum[27:24]<=tempnum[27:24]-1'b1;
    end
    
    else if(temp==8'b0010_0000)begin
    if(tempnum[23:20]==4'b0000)tempnum[23:20]=4'b1001;
    else tempnum[23:20]<=tempnum[23:20]-1'b1;
    end
    
    else if(temp==8'b0001_0000)begin
    if(tempnum[19:16]==4'b0000)tempnum[19:16]=4'b1001;
    else tempnum[19:16]<=tempnum[19:16]-1'b1;
    end
    
    else if(temp==8'b0000_1000)begin
    if(tempnum[15:12]==4'b0000)tempnum[15:12]=4'b1001;
    else tempnum[15:12]<=tempnum[15:12]-1'b1;
    end
    
    else if(temp==8'b0000_0100)begin
    if(tempnum[11:8]==4'b0000)tempnum[11:8]=4'b1001;
    else tempnum[11:8]<=tempnum[11:8]-1'b1;
    end
    
    else if(temp==8'b0000_0010)begin
    if(tempnum[7:4]==4'b0000)tempnum[7:4]=4'b1001;
    else tempnum[7:4]<=tempnum[7:4]-1'b1;
    end
    
    else if(temp==8'b0000_0001)begin
    if(tempnum[3:0]==4'b0000)tempnum[3:0]=4'b1001;
    else tempnum[3:0]<=tempnum[3:0]-1'b1;
    end
    end
    up=ubtn;
    down=dbtn;
 
    end
    
    
endmodule
