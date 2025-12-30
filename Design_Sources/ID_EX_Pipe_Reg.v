`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2025 02:18:53 AM
// Design Name: 
// Module Name: ID_EX_Pipe_Reg
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


//module ID_EX_Pipe_Reg(
//    // input wires
//    input wire clk,
//    input wire rst,
//    input wire[31:0] rs1_val,
//    input wire[31:0] rs2_val,
//    input wire[31:0] imm,
//    input wire[4:0] rd,
//    input wire[2:0] func3,
//    input wire[6:0] func7,
//    input wire[4:0] rs1,
//    input wire[4:0] rs2,
//    input wire mem_to_reg_in,
//    input wire[3:0] ctrl,
    
//    // output wires
//    output reg[31:0] rs1_val_out,
//    output reg[31:0] rs2_val_out,
//    output reg[31:0] imm_out,
//    output reg[6:0] func7_out,
//    output reg[2:0] func3_out,
//    output reg[4:0] rs1_out,
//    output reg[4:0] rs2_out,
//    output reg[4:0] rd_out,
//    output reg mem_to_reg_out,
//    output reg[3:0] ctrl_out
//    );
    
//    always @(posedge clk) begin
//        if(rst) begin
//            rs1_val_out <= 32'd0;
//            rs2_val_out <= 32'd0;
//            imm_out <= 32'd0;
//            func7_out <= 7'd0;
//            func3_out <= 3'd0;
//            rs1_out <= 5'd0;
//            rs2_out <= 5'd0;
//            rd_out <= 5'd0;
//            ctrl_out <= 4'd0;
//            mem_to_reg_out <= 1'b0;
//        end
//        else begin
//            rs1_val_out <= rs1_val;
//            rs2_val_out <= rs2_val;
//            imm_out <= imm;
//            func7_out <= func7;
//            func3_out <= func3;
//            rs1_out <= rs1;
//            rs2_out <= rs2;
//            rd_out <= rd;
//            ctrl_out <= ctrl;
//            mem_to_reg_out <= mem_to_reg_in;
//        end
//    end
    
//endmodule


module ID_EX_Pipe_Reg(
    // Control inputs
    input wire clk, rst,
    
    // Data inputs from ID stage
    input wire[31:0] rs1_val_in,
    input wire[31:0] rs2_val_in, 
    input wire[31:0] imm_in,
    input wire[4:0] rs1_in, rs2_in, rd_in,
    input wire[2:0] func3_in,
    input wire[6:0] func7_in,
    input  wire [31:0] pc_in,
    
    // Control inputs from MainControl
    input wire MemToReg_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire RegWrite_in,
    input wire Branch_in,
    input wire ALUSrc_in,
    input wire[1:0] ALUOp_in,
    input  wire [6:0] opcode_in,
    
    // Data outputs to EX stage
    output reg[31:0] rs1_val_out,
    output reg[31:0] rs2_val_out,
    output reg[31:0] imm_out,
    output reg[4:0] rs1_out, rs2_out, rd_out,
    output reg[2:0] func3_out,
    output reg[6:0] func7_out,
    
    // Control outputs to EX stage
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg RegWrite_out,
    output reg Branch_out,
    output reg ALUSrc_out,
    output reg[1:0] ALUOp_out,
    output reg  [31:0] pc_out,
    output reg  [6:0] opcode_out

);

    always @(posedge clk) begin
        if(rst) begin
            // Reset all data to 0
            rs1_val_out <= 32'd0;
            rs2_val_out <= 32'd0;
            imm_out <= 32'd0;
            rs1_out <= 5'd0;
            rs2_out <= 5'd0;
            rd_out <= 5'd0;
            func3_out <= 3'd0;
            func7_out <= 7'd0;
            pc_out <= 32'd0;
            
            // Reset all control signals to NOP
            MemToReg_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            RegWrite_out <= 1'b0;
            Branch_out <= 1'b0;
            ALUSrc_out <= 1'b0;
            ALUOp_out <= 2'b00;
        end
        else begin
            // Latch all data
            rs1_val_out <= rs1_val_in;
            rs2_val_out <= rs2_val_in;
            imm_out <= imm_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            rd_out <= rd_in;
            func3_out <= func3_in;
            func7_out <= func7_in;
            pc_out <= pc_in;
            
            // Latch all control signals
            MemToReg_out <= MemToReg_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            RegWrite_out <= RegWrite_in;
            Branch_out <= Branch_in;
            ALUSrc_out <= ALUSrc_in;
            ALUOp_out <= ALUOp_in;
        end
    end
    
endmodule
