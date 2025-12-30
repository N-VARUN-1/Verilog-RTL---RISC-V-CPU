`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 01:01:50 AM
// Design Name: 
// Module Name: MEM_WB_Pipe_Reg
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

module MEM_WB_Pipe_Reg_tb;

    reg         clk;
    reg         rst;
    reg [31:0]  alu_result_in;
    reg [31:0]  mem_data_in;
    reg [4:0]   rd_in;
    reg         reg_write_in;
    reg         mem_to_reg_in;

    wire [31:0] alu_result_out;
    wire [31:0] mem_data_out;
    wire [4:0]  rd_out;
    wire        reg_write_out;
    wire        mem_to_reg_out;

    // DUT
    MEM_WB_Pipe_Reg dut (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_in),
        .mem_data_in(mem_data_in),
        .rd_in(rd_in),
        .reg_write_in(reg_write_in),
        .mem_to_reg_in(mem_to_reg_in),

        .alu_result_out(alu_result_out),
        .mem_data_out(mem_data_out),
        .rd_out(rd_out),
        .reg_write_out(reg_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        // -------- Reset phase --------
        rst            = 1'b1;
        alu_result_in  = 32'h0000_0000;
        mem_data_in    = 32'h0000_0000;
        rd_in          = 5'd0;
        reg_write_in   = 1'b0;
        mem_to_reg_in  = 1'b0;

        #20;                 // 2 clock cycles with reset asserted
        rst = 1'b0;

        // -------- First set of inputs --------
        alu_result_in  = 32'hAAAA_BBBB;
        mem_data_in    = 32'h1111_2222;
        rd_in          = 5'd3;
        reg_write_in   = 1'b1;
        mem_to_reg_in  = 1'b0;
        #10;                 // one rising edge: outputs latch these

        // -------- Second set of inputs --------
        alu_result_in  = 32'hCCCC_DDDD;
        mem_data_in    = 32'h3333_4444;
        rd_in          = 5'd7;
        reg_write_in   = 1'b1;
        mem_to_reg_in  = 1'b1;
        #10;                 // outputs update again

        // -------- Assert reset again --------
        rst = 1'b1;
        #10;
        rst = 1'b0;

        #20;
        $finish;
    end

    // Optional monitor
    initial begin
        $display("time rst  alu_in       mem_in       rd_in rw_in m2r_in | alu_out      mem_out      rd_out rw_out m2r_out");
        $monitor("%4t  %b   %h %h %2d  %b    %b   | %h %h %2d  %b    %b",
                 $time, rst,
                 alu_result_in, mem_data_in, rd_in, reg_write_in, mem_to_reg_in,
                 alu_result_out, mem_data_out, rd_out, reg_write_out, mem_to_reg_out);
    end

endmodule

