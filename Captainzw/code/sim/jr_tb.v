`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/01 22:31:09
// Design Name: 
// Module Name: jr_tb
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


module jr_tb;
    reg clk=0;
    reg rst=0;
    wire[31:0] inst;
    wire[31:0]pc;
    //Contol 模块输出的控制信号
    wire ct_rf_dst,ct_rf_wen,ct_alu_src,ct_data_rf,ct_branch,ct_jump,ct_mem_wen,ct_mem_ren,ct_jr,ct_jal;
    wire[3:0] ct_alu;
    //RegFile 模块的输入输出
    wire[4:0] rf_addr_w;
    wire[31:0] rf_data_r1,rf_data_r2,rf_data_w;
    //ALU 模块的输入输出
    wire alu_zero;
    wire[31:0] alu_src2;
    wire[31:0] alu_res;
    //符号扩展的结果
    wire[31:0] ext_data;
    //DataMem 的输出
    wire[31:0] mem_data_o;
  
    CPU a(clk,rst,
    inst,
    pc,
    ct_rf_dst,ct_rf_wen,ct_alu_src,ct_data_rf,ct_branch,ct_jump,ct_mem_wen,ct_mem_ren,ct_jr,ct_jal,
    ct_alu,
    rf_addr_w,
    rf_data_r1,rf_data_r2,rf_data_w,
    alu_zero,
    alu_src2,
    alu_res,
    ext_data,
   mem_data_o);
    initial begin
        forever #10 clk=~clk;
    end
    initial begin
        #15 rst=1;
    end
    
endmodule
