`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2025 01:13:26 AM
// Design Name: 
// Module Name: Instruction_Memory_BRAM
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


module Instruction_Memory_BRAM(
    input wire clk,
    input wire write_en,
    input wire[9:0] addr,
    input wire[31:0] write_data,
    output reg[31:0] read_data
    );
    // Declaring Memory array
    reg[31:0] mem[0:1023];
    
    initial begin
        $readmemh("Instruction.mem", mem);
    end
    
    always @(posedge clk) 
    begin   
        if(write_en)
            mem[addr] = write_data;
        read_data <= mem[addr];
    end
    
endmodule
