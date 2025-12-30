`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2025 02:18:53 AM
// Design Name: 
// Module Name: ID_EX_Pipe_Reg
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

module ID_EX_Pipe_Reg(
    // Control inputs
    input wire clk, rst,
    
    // Data inputs from ID stage
    input wire[31:0] rs1_val_in,
    input wire[31:0] rs2_val_in, 
    input wire[31:0] imm_in,
    input wire[4:0] rs1_in, rs2_in, rd_in,
    input wire[2:0] func3_in,
    input wire[6:0] func7_in,
    input  wire [31:0] pc_in,
    
    // Control inputs from MainControl
    input wire MemToReg_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire RegWrite_in,
    input wire Branch_in,
    input wire ALUSrc_in,
    input wire[1:0] ALUOp_in,
    input  wire [6:0] opcode_in,
    
    // Data outputs to EX stage
    output reg[31:0] rs1_val_out,
    output reg[31:0] rs2_val_out,
    output reg[31:0] imm_out,
    output reg[4:0] rs1_out, rs2_out, rd_out,
    output reg[2:0] func3_out,
    output reg[6:0] func7_out,
    
    // Control outputs to EX stage
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg RegWrite_out,
    output reg Branch_out,
    output reg ALUSrc_out,
    output reg[1:0] ALUOp_out,
    output reg  [31:0] pc_out,
    output reg  [6:0] opcode_out

);

    // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
    
endmodule
