`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 12:36:10 AM
// Design Name: 
// Module Name: EX_MEM_Pipe_Reg_tb
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

module EX_MEM_Pipe_Reg_tb;

    reg         clk;
    reg         rst;
    reg [31:0]  alu_result_in;
    reg [31:0]  rs2_data_in;
    reg [4:0]   rd_in;
    reg         reg_write_in;
    reg         mem_write_in;
    reg         mem_read_in;
    reg         branch_taken_in;

    wire [31:0] alu_result_out;
    wire [31:0] rs2_data_out;
    wire [4:0]  rd_out;
    wire        reg_write_out;
    wire        mem_write_out;
    wire        mem_read_out;
    wire        branch_taken_out;

    // DUT
    EX_MEM_Pipe_Reg dut (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_in),
        .rs2_data_in(rs2_data_in),
        .rd_in(rd_in),
        .reg_write_in(reg_write_in),
        .mem_write_in(mem_write_in),
        .mem_read_in(mem_read_in),
        .branch_taken_in(branch_taken_in),

        .alu_result_out(alu_result_out),
        .rs2_data_out(rs2_data_out),
        .rd_out(rd_out),
        .reg_write_out(reg_write_out),
        .mem_write_out(mem_write_out),
        .mem_read_out(mem_read_out),
        .branch_taken_out(branch_taken_out)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Reset
        rst = 1'b1;
        alu_result_in   = 32'h0000_0000;
        rs2_data_in     = 32'h0000_0000;
        rd_in           = 5'd0;
        reg_write_in    = 1'b0;
        mem_write_in    = 1'b0;
        mem_read_in     = 1'b0;
        branch_taken_in = 1'b0;

        #20;
        rst = 1'b0;

        // First set of inputs
        alu_result_in   = 32'hAAAA_BBBB;
        rs2_data_in     = 32'h1111_2222;
        rd_in           = 5'd3;
        reg_write_in    = 1'b1;
        mem_write_in    = 1'b0;
        mem_read_in     = 1'b1;
        branch_taken_in = 1'b0;
        #10;   // one rising edge: outputs should latch these

        // Second set of inputs
        alu_result_in   = 32'hCCCC_DDDD;
        rs2_data_in     = 32'h3333_4444;
        rd_in           = 5'd7;
        reg_write_in    = 1'b0;
        mem_write_in    = 1'b1;
        mem_read_in     = 1'b0;
        branch_taken_in = 1'b1;
        #10;   // outputs update again

        // Assert reset again
        rst = 1'b1;
        #10;
        rst = 1'b0;

        #20;
        $finish;
    end

    // Optional monitor
    initial begin
        $display("time rst alu_in       rs2_in       rd_in rw_in mw_in mr_in bt_in | alu_out      rs2_out      rd_out rw_out mw_out mr_out bt_out");
        $monitor("%4t  %b   %h %h %2d  %b    %b    %b    %b  | %h %h %2d  %b    %b    %b    %b",
                 $time, rst,
                 alu_result_in, rs2_data_in, rd_in, reg_write_in, mem_write_in, mem_read_in, branch_taken_in,
                 alu_result_out, rs2_data_out, rd_out, reg_write_out, mem_write_out, mem_read_out, branch_taken_out);
    end

endmodule

