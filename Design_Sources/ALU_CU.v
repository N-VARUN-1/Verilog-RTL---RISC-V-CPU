`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2025 01:00:14 AM
// Design Name: 
// Module Name: ALU_CU
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


//module ALU_CU(
//    input wire[6:0] opcode,
//    input wire[2:0] func3,
//    input wire[6:0] func7,
//    input wire[1:0] ALUOp,
//    output reg[2:0] alu_op
//    );
//    always @(*) begin
//        case(ALUOp) 
//            2'b00 : alu_op = 3'b000; // ADD
//            2'b01 : alu_op = 3'b001; // SUB
//            2'b10 : begin
//                case(func3)
//                    3'b000 : alu_op = (func7[5]) ? 3'b001 : 3'b000; // SUB / ADD
//                    3'b001 : alu_op = 3'b101;                       // SLL
//                    3'b010 : alu_op = 3'b100;                       // SLT
//                    3'b011 : alu_op = 3'b100;                       // SLTU
//                    3'b100 : alu_op = 3'b100;                        // XOR
//                    3'b101 : alu_op = (func7[5]) ? 3'b111 : 3'b110;
//                    3'b111 : alu_op = 3'b010;                        // AND
//                    3'b110 : alu_op = 3'b011;                        // OR         
                    
//                    default: alu_op = 3'b000;
//                endcase
//            end
//         endcase
//    end
//endmodule



module ALU_CU(
    input wire[6:0] opcode,
    input wire[2:0] func3,
    input wire[6:0] func7,
    input wire[1:0] ALUOp,
    output reg[2:0] alu_op
);
    always @(*) begin
        case(ALUOp)
            2'b00: alu_op = 3'b000;  // Load/Store: ADD
            2'b01: alu_op = 3'b001;  // Branch: SUB
            2'b10: begin             // R-type/I-type: use func3/7
                casex({func7[5], func3})
                    7'b0_000_0: alu_op = 3'b000;  // ADD/ADDI
                    7'b1_000_0: alu_op = 3'b001;  // SUB
                    7'b0_001_0: alu_op = 3'b101;  // SLL/SLLI
                    7'b0_010_0: alu_op = 3'b111;  // SLT/SLTI
                    7'b0_011_0: alu_op = 3'b111;  // SLTU/SLTIU (treat as SLT for simplicity)
                    7'b0_100_0: alu_op = 3'b100;  // XOR/XORI
                    7'b0_101_0: alu_op = 3'b110;  // SRL/SRLI
                    7'b1_101_0: alu_op = 3'b110;  // SRA/SRAI (your ALU uses logical >>)
                    7'b0_110_0: alu_op = 3'b010;  // OR/ORI
                    7'b0_111_0: alu_op = 3'b011;  // AND/ANDI
                    default:    alu_op = 3'b000;
                endcase
            end
            default: alu_op = 3'b000;
        endcase
    end
endmodule
