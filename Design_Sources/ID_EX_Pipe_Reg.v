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


module ID_EX_Pipe_Reg(
    // input wires
    input wire clk,
    input wire rst,
    input wire[31:0] rs1_val,
    input wire[31:0] rs2_val,
    input wire[31:0] imm,
    input wire[4:0] rd,
    input wire[2:0] func3,
    input wire[6:0] func7,
    input wire[4:0] rs1,
    input wire[4:0] rs2,
    input wire mem_to_reg_in,
    input wire[3:0] ctrl,
    
    // output wires
    output reg[31:0] rs1_val_out,
    output reg[31:0] rs2_val_out,
    output reg[31:0] imm_out,
    output reg[6:0] func7_out,
    output reg[2:0] func3_out,
    output reg[4:0] rs1_out,
    output reg[4:0] rs2_out,
    output reg[4:0] rd_out,
    output reg mem_to_reg_out,
    output reg[3:0] ctrl_out
    );
    
    always @(posedge clk) begin
        if(rst) begin
            rs1_val_out <= 32'd0;
            rs2_val_out <= 32'd0;
            imm_out <= 32'd0;
            func7_out <= 7'd0;
            func3_out <= 3'd0;
            rs1_out <= 5'd0;
            rs2_out <= 5'd0;
            rd_out <= 5'd0;
            ctrl_out <= 4'd0;
            mem_to_reg_out <= 1'b0;
        end
        else begin
            rs1_val_out <= rs1_val;
            rs2_val_out <= rs2_val;
            imm_out <= imm;
            func7_out <= func7;
            func3_out <= func3;
            rs1_out <= rs1;
            rs2_out <= rs2;
            rd_out <= rd;
            ctrl_out <= ctrl;
            mem_to_reg_out <= mem_to_reg_in;
        end
    end
    
endmodule
