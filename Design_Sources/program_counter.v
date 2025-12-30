`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2025 12:56:45 AM
// Design Name: 
// Module Name: program_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: a
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module program_counter # (
    parameter RESET_PC = 32'h0000_0000
)
(
    input wire clk,
    input wire rst,
    input wire branch_en,
    input wire[31:0] branch_target,
    output reg[31:0] pc
    );
    
    wire [31:0] pc_plus4;
    wire [31:0] pc_next;
    
    assign pc_plus4 = pc + 32'd4;
    assign pc_next = branch_en ? branch_target : pc_plus4;
    
    always @(posedge clk) 
    begin
        if(rst)
            pc <= RESET_PC;
        else    
            pc <= pc_next;
    end
    
    
endmodule
