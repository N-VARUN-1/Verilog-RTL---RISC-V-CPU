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
    
    // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
endmodule
