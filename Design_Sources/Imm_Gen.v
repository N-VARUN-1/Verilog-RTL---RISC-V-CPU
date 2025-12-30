`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2025 01:51:30 AM
// Design Name: 
// Module Name: Imm_Gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments
// 
//////////////////////////////////////////////////////////////////////////////////


//module Imm_Gen(
//    input wire[31:0] instr,
//    output reg[31:0] imm_out
//    );
    
//    always @(*) begin
//        case(instr[6:0])
//            7'b0010011: imm_out = {{20{instr[31]}},instr[31:20]}; // I-Type
//            7'b0100011: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-Type
//            7'b1100011: imm_out = {{20{instr[31]}}, instr[31], instr[30:25], instr[11:8], instr[7]}; // B-Type
//            7'b0110111: imm_out = {{12{instr[31]}}, instr[31:12]}; // U-Type
//            7'b1101111: imm_out = {{12{instr[31]}}, instr[31], instr[30:21], instr[20], instr[19:12]}; // J-Type
//            default : imm_out = 32'd0;
//        endcase
//    end
//endmodule


module Imm_Gen(
    input wire[31:0] instr,
    output reg[31:0] imm_out
);
    always @(*) begin
        case(instr[6:0])
            7'b0010011: imm_out = {{20{instr[31]}}, instr[31:20]};        // I-type ✓
            7'b0000011: imm_out = {{20{instr[31]}}, instr[31:20]};        // Load I-type
            7'b0100011: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type ✓
            7'b1100011: imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type (13-bit -> 32-bit)
            7'b0110111: imm_out = {{12{instr[31]}}, instr[31:12]};        // LUI ✓
            7'b0010111: imm_out = {{12{instr[31]}}, instr[31:12]};        // AUIPC
            7'b1101111: imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type (21-bit -> 32-bit)
            7'b1100111: imm_out = {{20{instr[31]}}, instr[31:20]};        // JALR I-type
            default:     imm_out = 32'd0;
        endcase
    end
endmodule

