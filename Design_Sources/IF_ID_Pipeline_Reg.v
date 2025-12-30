`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2025 02:04:58 AM
// Design Name: 
// Module Name: IF_ID_Pipeline_Reg
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


module IF_ID_Pipeline_Reg # 
(
    parameter RESET = 32'h0000_0000
)
(
    input wire clk,
    input wire rst,
    input wire[31:0] pc_in,
    input wire[31:0] instruction_in,
    output reg[31:0] pc_out,
    output reg[31:0] instruction_out
    );
    
    // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
 
endmodule
