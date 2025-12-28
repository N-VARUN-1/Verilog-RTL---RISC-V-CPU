`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2025 01:04:43 AM
// Design Name: 
// Module Name: Register_File_tb
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


module Register_File_tb;
    reg clk;
    reg rst;
    reg we;
    reg[4:0] rs1;
    reg[4:0] rs2;
    reg[4:0] rd;
    reg[31:0] wd;
    wire[31:0] read1;
    wire[31:0] read2;
    
    
    Register_File dut(
        .clk(clk),
        .rst(rst),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .wd(wd),
        .read1(read1),
        .read2(read2)
    );
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1'b1;
        we = 1'b0;
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd = 5'b0;
        wd = 32'h0000_0000;
        
        #20
        rst = 1'b0;
        
        rs1 = 5'd1;
        rs2 = 5'd2;
        #10;
        
        // Write Back - 1 (x1)
        we = 1'b1;
        rd = 5'd1;
        wd = 32'hAAAA_AAAA;
        #10
        
        // Read from x1
        we = 1'b0;
        rs1 = 5'd1;
        rs2 = 5'd1;
        #10;
        
        we = 1'b1;
        rd = 5'd0;
        wd = 32'hFFFF_FFFF;
        #10;
        
        we = 1'b0;
        rs1 = 5'd0;
        rs2 = 5'd0;
        
        
        
        // Another Register Write and Read
        we = 1'b1;
        rd = 5'd5;
        wd = 32'h1234_5678;
        #10;
        
        
        we = 1'b0;
        rs1 = 5'd5;
        rs2 = 5'd1;
        #10;
        
        
        #20;
        $finish;
    end
    
    
endmodule
