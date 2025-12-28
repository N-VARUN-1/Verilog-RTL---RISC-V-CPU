`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2025 10:02:34 PM
// Design Name: 
// Module Name: Imm_Gen_tb
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


module Imm_Gen_tb;
    reg[31:0] instr;
    wire[31:0] imm_out;
    
    Imm_Gen dut(
        .instr(instr),
        .imm_out(imm_out)
    );
    
    initial begin
        $display(" time   instr(opcode)            imm_out");
        
        // I-Type
        instr = 32'b111111111111_00010_000_00001_0010011;
        #1
        $display("%4t  I-type  instr=%h  imm=%h", $time, instr, imm_out);
        
        // S-Type
        instr = 32'b0000000_00001_00010_010_01000_0100011;
        #1;
        $display("%4t  S-type  instr=%h  imm=%h", $time, instr, imm_out);
        
        // B-Type
        instr = 32'b000000_00010_00001_000_00000_1100011;
        #1;
        $display("%4t  B-type  instr=%h  imm=%h", $time, instr, imm_out);
        
        // U-Type
        instr = 32'b0000000000010010_00001_0110111;
        #1;
        $display("%4t  U-type  instr=%h  imm=%h", $time, instr, imm_out);
        
        // J-Type
        instr = 32'b000000000010_00000000_0_00001_1101111;
        #1;
        $display("%4t  J-type  instr=%h  imm=%h", $time, instr, imm_out);
        
        // Default
        instr = 32'h0000_0000;
        #1;
        $display("%4t  default instr=%h  imm=%h", $time, instr, imm_out);
        
        #10 
        $finish;
    end
    
endmodule
