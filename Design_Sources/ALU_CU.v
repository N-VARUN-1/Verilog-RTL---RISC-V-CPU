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
    // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.
endmodule
