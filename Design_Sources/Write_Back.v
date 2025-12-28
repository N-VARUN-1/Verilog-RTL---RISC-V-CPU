`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2025 12:41:05 AM
// Design Name: 
// Module Name: Write_Back
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


module Write_Back(
    input wire[31:0] alu_result,
    input wire[31:0] mem_data,
    input wire mem_to_reg,
    output reg[31:0] write_data
    );
    always @(*) begin
        case(mem_to_reg)
            1'b1 : write_data = mem_data;
            1'b0 : write_data = alu_result;    
            default: write_data = 32'd0;        
        endcase
    end
endmodule
