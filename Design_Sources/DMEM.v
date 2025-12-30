`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2025 12:22:02 AM
// Design Name: 
// Module Name: DMEM
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

module DMEM(
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire        sign_extend,
    input  wire [1:0]  size,
    input  wire [31:0] addr,        // byte address
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

    // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
endmodule
