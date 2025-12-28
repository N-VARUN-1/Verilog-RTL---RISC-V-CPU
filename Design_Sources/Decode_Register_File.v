`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2025 11:36:23 PM
// Design Name: 
// Module Name: Decode_Register_File
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


module Decode_Register_File(
    input wire clk,
    input wire rst,
    input wire write_en,
    input wire[4:0] rs1,
    input wire[4:0] rs2,
    input wire[4:0] rd,
    output wire[31:0] wd,
    output reg[31:0] rd1,
    output reg[31:0] rd2
    );
    
    reg[31:0] regfile[0:31];
    
    always @(posedge clk) begin
        if(rst)begin
            for(integer i=0; i<32; i = i+1)
                regfile[i] <= 5'd0;
        end else if(write_en && rd != 5'd0) begin
            regfile[rd] <= wd;
        end
    end
    
endmodule
