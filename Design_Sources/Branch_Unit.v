`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 01:27:37 AM
// Design Name: 
// Module Name: Branch_Unit
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


module Branch_Unit(
    input wire[31:0] rs1,
    input wire[31:0] rs2,
    input wire[2:0] func3,
    input wire is_branch,
    output reg branch_taken
    );
    
    wire signed [31:0] s_rs1 = rs1;
    wire signed [31:0] s_rs2 = rs2;
    
    always @(*) begin
        if(is_branch) begin
            case(func3)
                3'b000 : branch_taken = (s_rs1 == s_rs2);
                3'b001 : branch_taken = (s_rs1 != s_rs2);
                3'b100 : branch_taken = (s_rs1 < s_rs2);
                3'b101 : branch_taken = (s_rs1 > s_rs2);
                3'b110 : branch_taken = (rs1 < rs2);
                3'b111 : branch_taken = (rs1 > rs2);
                default : branch_taken = 1'b0;
            endcase
        end  else begin
            branch_taken = 1'b0;   // IMPORTANT: defined when not a branch
        end    
    end
endmodule
