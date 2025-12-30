`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2025 12:23:48 AM
// Design Name: 
// Module Name: IF_ID_Pipeline_Register
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


module IF_ID_Pipeline_Register(
    input wire clk,
    input wire rst,
    input wire[31:0] pc_in,
    input wire[31:0] instruction_in,
    output reg[31:0] pc_out,
    output reg[31:0] instruction_out
    );
    always @(posedge clk) begin
        if(rst) begin
            pc_out <= 32'd0;
            instruction_out <= 32'd0;
        end
        else begin
            pc_out <= pc_in;
            instruction_out <= instruction_in;
        end
    end
    
endmodule
