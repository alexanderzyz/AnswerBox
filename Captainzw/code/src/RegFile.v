`timescale 1ns / 1ps 
module RegFile( 
    input clk, 
    // дʹ���ź� 
    input rf_wen, 
    // ����ַ 
    input[4:0] rf_addr_r1, 
    input[4:0] rf_addr_r2, 
    // д���ַ��д������ 
    input[4:0] rf_addr_w, 
    input[31:0] rf_data_w, 
    input[31:0] pc,
    input ct_jal,
    // ����˿� 
    output[31:0] rf_data_r1, 
    output[31:0] rf_data_r2 
 ); 
 
    reg[31:0] file[31:0]; 
    integer i; 
    initial begin 
        for(i = 0; i < 32; i=i+1) file[i] = 32'b0; 
    end 
    
    assign rf_data_r1 = file[rf_addr_r1]; 
    assign rf_data_r2 = file[rf_addr_r2]; 
     
    always@(negedge clk) begin 
        if (rf_wen) begin 
        if(ct_jal)
            file[32'b11111]<=pc+4;
        else
            file[rf_addr_w]<=rf_data_w;
        end 
    end 
 endmodule