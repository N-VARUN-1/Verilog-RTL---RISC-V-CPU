`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2025 01:38:31 AM
// Design Name: 
// Module Name: MEM_WB_Pipe_Reg
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


module MEM_WB_Pipe_Reg(
    input wire clk,
    input wire rst,
    input wire[31:0] alu_result_in,
    input wire[31:0] mem_data_in,
    input wire[4:0] rd_in,
    input wire reg_write_in,
    input wire mem_to_reg_in,
    
    output reg[31:0] alu_result_out,
    output reg[31:0] mem_data_out,
    output reg[4:0] rd_out,
    output reg reg_write_out,
    output reg mem_to_reg_out
    );
    
    always @(posedge clk)begin
        if(rst) begin
            alu_result_out <= 32'd0;
            mem_data_out <= 32'd0;
            rd_out <= 5'd0;
            reg_write_out <= 1'd0;
            mem_to_reg_out <= 1'd0;
        end
        else begin
            alu_result_out <= alu_result_in;
            mem_data_out <= mem_data_in;
            rd_out <= rd_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
        end
    end
endmodule
