`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 11:03:55 PM
// Design Name: 
// Module Name: EX_MEM_Pipe_Reg
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


module EX_MEM_Pipe_Reg(
    input wire clk,
    input wire rst,
    input wire[31:0] alu_result_in,
    input wire[31:0] rs2_data_in,
    input wire[4:0] rd_in,
    input wire reg_write_in,
    input wire mem_write_in,
    input wire mem_read_in,
    input wire       mem_to_reg_in,
    input wire branch_taken_in,
    
    output reg[31:0] alu_result_out,
    output reg[31:0] rs2_data_out,
    output reg[4:0] rd_out,
    output reg reg_write_out,
    output reg mem_write_out,
    output reg mem_read_out,
    output reg      mem_to_reg_out,
    output reg branch_taken_out
    );
    
    always @(posedge clk) begin
        if(rst) begin
            alu_result_out <= 32'd0;
            rs2_data_out <= 32'd0;
            rd_out <= 5'd0;
            reg_write_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_read_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            branch_taken_out <= 1'b0;
        end
        else begin
            alu_result_out <= alu_result_in;
            rs2_data_out <= rs2_data_in;
            rd_out <= rd_in;
            reg_write_out <= reg_write_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            mem_to_reg_out <= mem_to_reg_in;
            branch_taken_out <= branch_taken_in;
        end
    end
    
endmodule
