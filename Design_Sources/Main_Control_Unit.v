`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2025 01:04:18 AM
// Design Name: 
// Module Name: Main_Control_Unit
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


module MainControl (
    input wire[6:0] opcode,
    output reg[1:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg Branch,
    output reg ALUSrc,
    output reg MemToReg
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                ALUOp = 2'b10;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                RegWrite = 1'b1;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                MemToReg = 1'b0;
            end
            7'b0010011: begin // I-type
                ALUOp = 2'b10;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                RegWrite = 1'b1;
                Branch = 1'b0;
                ALUSrc = 1'b1;
                MemToReg = 1'b0;
            end
            7'b0000011: begin // Load
                ALUOp = 2'b00;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                RegWrite = 1'b1;
                Branch = 1'b0;
                ALUSrc = 1'b1;
                MemToReg = 1'b1;
            end
            7'b0100011: begin // Store
                ALUOp = 2'b00;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                RegWrite = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b1;
                MemToReg = 1'b0;
            end
            7'b1100011: begin // Branch
                ALUOp = 2'b01;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                RegWrite = 1'b0;
                Branch = 1'b1;
                ALUSrc = 1'b0;
                MemToReg = 1'b0;
            end
            default: begin
                ALUOp = 2'b00;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                RegWrite = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                MemToReg = 1'b0;
            end
        endcase
    end

endmodule

