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
    
   // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
endmodule
