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


//module Instruction_Memory_BRAM(
//    input wire clk,
//    input wire write_en,
//    input wire[11:0] addr,
//    input wire[31:0] write_data,
//    output reg[31:0] read_data
//    );
//    // Declaring Memory array
//    reg[31:0] mem[0:1023];
    
//    initial begin
//        $readmemh("Instruction.mem", mem);
//    end
    
//    always @(posedge clk) 
//    begin   
//        if(write_en)
//            mem[addr] = write_data;
//        read_data <= mem[addr];
//    end
    
//endmodule

module Instruction_Memory_BRAM(
    input wire clk,
    input wire write_en,
    input wire[9:0] addr,  // 4KB: 12-bit for byte-addressable
    input wire[31:0] write_data,
    output reg[31:0] read_data
);
    reg[31:0] mem[0:1023];  // 1024 words = 4KB
    
    initial $readmemh("Instruction.mem", mem);
    
    // Combinatorial read (zero latency)
    always @(*) read_data = mem[addr];  // Word-aligned
    
    // Synchronous write only
    always @(posedge clk) 
        if(write_en) mem[addr] <= write_data;
endmodule

