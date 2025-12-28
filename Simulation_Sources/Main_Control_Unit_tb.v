`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2025 10:21:44 PM
// Design Name: 
// Module Name: Main_Control_Unit_tb
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

`timescale 1ns/1ps
module Main_Control_Unit_tb;
    reg[6:0] opcode;
    wire[1:0] ALUOp;
    wire MemRead;
    wire MemWrite;
    wire RegWrite;
    wire Branch;
    wire ALUSrc;
    wire MemToReg;
    
    MainControl dut(
        .opcode(opcode),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg)
    );
    
    
    initial begin
        $display(" time  opcode   ALUOp MR MW RW BR AS M2R");
        // R-Type
        opcode = 7'b0110011;
        #1
        $display("%4t  R-Type  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
                 
        // I-Type
        opcode = 7'b0010011;
        #1
        $display("%4t  I-Type  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
        
        // Load
        opcode = 7'b0000011;
        #1
        $display("%4t  Load  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
                 
        // Store
        opcode = 7'b0100011;
        #1
        $display("%4t  Store  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
        
        // Branch 
        opcode = 7'b1100011;
        #1
        $display("%4t  Branch  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
        
        // Default case 
        opcode = 7'b1111111;
        #1
        $display("%4t  Default  %b  %b  %b  %b  %b  %b  %b",
                 $time, opcode, ALUOp, MemRead, MemWrite, RegWrite, Branch, ALUSrc, MemToReg);
                 
        #20;
        $finish;
    end
endmodule
