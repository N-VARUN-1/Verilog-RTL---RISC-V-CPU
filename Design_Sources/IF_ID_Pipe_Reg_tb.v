`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2025 12:33:00 AM
// Design Name: 
// Module Name: IF_ID_Pipe_Reg_tb
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

`timescale 1ns/1ps

module IF_ID_Pipe_Reg_tb;
    reg clk;
    reg rst;
    reg[31:0] pc_in;
    reg[31:0] instruction_in;
    wire[31:0] pc_out;
    wire[31:0] instruction_out;
    
    IF_ID_Pipeline_Register dut (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );
    
    initial begin
        clk = 1'd0;
        forever #5 clk = ~clk;
    end
    
    // Stimulus Block 
    initial begin
        rst = 1'b1;
        pc_in = 32'h0000_0000;
        instruction_in = 32'h0000_00000;
        
        #20
        rst = 1'b0;
        
        // first instruction
        pc_in = 32'h0000_0000;
        instruction_in = 32'h1111_1111;
        #10;
        
        // second instruction
        pc_in = 32'h0000_0004;
        instruction_in = 32'h2222_2222;
        #10
        
        // third instruction
        pc_in = 32'h0000_0008;
        instruction_in = 32'h3333_3333;
        #10
        
        
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        #20;
        $finish;
    end
    
    
endmodule
