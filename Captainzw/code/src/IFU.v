`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:43:38
// Design Name: 
// Module Name: IFU
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


module IFU(

input clk,rst,
input[31:0] alu_res,
input alu_zero,ct_branch,ct_jump,ct_jr,
output[31:0] inst,
output reg[31:0] pc
    ); 
    
    
    reg[31:0] instRom[65535:0];//???›¥?????? 256KB
    wire[31:0] ext_data;//???????????
    initial pc=32'b0;
    initial $readmemh("inst.data",instRom);//?????????????›¥??
    assign inst=instRom[pc[17:2]];//????
    assign ext_data = {{16{inst[15]}},inst[15:0]};//???????
    always @ (posedge clk) begin
        if(!rst)
            pc <= 0;
        else begin
            if(ct_jump) 
                pc<={pc[31:28],inst[25:0],2'b00};
            else if(ct_branch && alu_zero)
                pc<=pc+4+(ext_data<<2);
            else if(ct_jr)
                pc<=alu_res;
            else
                pc <= pc + 4;
        end
    
    end
endmodule

