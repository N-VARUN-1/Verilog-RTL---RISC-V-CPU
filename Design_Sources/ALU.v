`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2025 01:07:56 AM
// Design Name: 
// Module Name: ALU
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


//module ALU (
//    input wire [31:0] a,      // Operand A
//    input wire [31:0] b,      // Operand B
//    input wire [2:0] alu_op,  // ALU operation control (3-bit)
//    output reg [31:0] result, // ALU result
//    output reg zero          // Zero flag
//);

//    always @(*) begin
//        case (alu_op)
//            3'b000: result = a + b;          // ADD
//            3'b001: result = a - b;          // SUB
//            3'b010: result = a & b;          // AND
//            3'b011: result = a | b;          // OR
//            3'b100: result = a ^ b;          // XOR
//            3'b101: result = a << b[4:0];    // SHIFT LEFT (SLL)
//            3'b110: result = a >> b[4:0];    // SHIFT RIGHT (SRL)
//            3'b111: result = $signed(a) < $signed(b) ? 32'd1 : 32'd0;  // SLT
//            default: result = 32'd0;
//        endcase
//        zero = (result == 32'd0);
//    end

//endmodule


module ALU (
    input  wire [31:0] a, b,
    input  wire [2:0]  alu_op,
    output reg  [31:0] result,
    output wire        zero
);
    wire signed [31:0] a_s = a;
    wire signed [31:0] b_s = b;

    assign zero = (result == 32'd0);

    always @(*) begin
        case (alu_op)
            3'b000: result = a + b;                 // ADD / ADDI
            3'b001: result = a - b;                 // SUB
            3'b010: result = a & b;                 // AND / ANDI
            3'b011: result = a | b;                 // OR / ORI
            3'b100: result = a ^ b;                 // XOR / XORI
            3'b101: result = a << b[4:0];           // SLL / SLLI
            3'b110: result = a >> b[4:0];           // SRL / SRLI (logical)
            3'b111: result = (a_s < b_s) ? 32'd1    // SLT / SLTI (signed)
                                         : 32'd0;
            default: result = 32'd0;
        endcase
    end
endmodule

