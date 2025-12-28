`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2025 10:43:59 PM
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


`timescale 1ns/1ps

module ID_EX_Pipe_Reg_tb;

    reg         clk;
    reg         rst;
    reg [31:0]  rs1_val;
    reg [31:0]  rs2_val;
    reg [31:0]  imm;
    reg [4:0]   rd;
    reg [2:0]   func3;
    reg [6:0]   func7;
    reg [4:0]   rs1;
    reg [4:0]   rs2;
    reg [3:0]   ctrl;

    wire [31:0] rs1_val_out;
    wire [31:0] rs2_val_out;
    wire [31:0] imm_out;
    wire [6:0]  func7_out;
    wire [2:0]  func3_out;
    wire [4:0]  rs1_out;
    wire [4:0]  rs2_out;
    wire [4:0]  rd_out;
    wire [3:0]  ctrl_out;

    // DUT
    ID_EX_Pipe_Reg dut (
        .clk(clk),
        .rst(rst),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val),
        .imm(imm),
        .rd(rd),
        .func3(func3),
        .func7(func7),
        .rs1(rs1),
        .rs2(rs2),
        .ctrl(ctrl),

        .rs1_val_out(rs1_val_out),
        .rs2_val_out(rs2_val_out),
        .imm_out(imm_out),
        .func7_out(func7_out),
        .func3_out(func3_out),
        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .rd_out(rd_out),
        .ctrl_out(ctrl_out)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        // -------- Reset phase --------
        rst      = 1'b1;
        rs1_val  = 32'h0000_0000;
        rs2_val  = 32'h0000_0000;
        imm      = 32'h0000_0000;
        rd       = 5'd0;
        func3    = 3'd0;
        func7    = 7'd0;
        rs1      = 5'd0;
        rs2      = 5'd0;
        ctrl     = 4'd0;

        #20;          // two clock cycles with reset asserted
        rst = 1'b0;

        // -------- First set of inputs --------
        rs1_val  = 32'hAAAA_AAAA;
        rs2_val  = 32'hBBBB_BBBB;
        imm      = 32'h0000_0010;
        rd       = 5'd3;
        func3    = 3'b010;
        func7    = 7'b0100000;
        rs1      = 5'd1;
        rs2      = 5'd2;
        ctrl     = 4'b1010;
        #10;      // one rising edge, outputs should latch these values

        // -------- Second set of inputs --------
        rs1_val  = 32'h1111_1111;
        rs2_val  = 32'h2222_2222;
        imm      = 32'h0000_0040;
        rd       = 5'd7;
        func3    = 3'b100;
        func7    = 7'b0000000;
        rs1      = 5'd4;
        rs2      = 5'd5;
        ctrl     = 4'b0101;
        #10;      // outputs update again

        // -------- Assert reset again --------
        rst = 1'b1;
        #10;      // outputs should go back to 0
        rst = 1'b0;

        #20;
        $finish;
    end

    // Optional monitor
    initial begin
        $display(" time rst  rs1_val_out rs2_val_out imm_out  rd_out rs1_out rs2_out func3_out func7_out ctrl_out");
        $monitor("%4t  %b   %h   %h   %h  %2d   %2d   %2d   %3b      %7b    %4b",
                 $time, rst,
                 rs1_val_out, rs2_val_out, imm_out,
                 rd_out, rs1_out, rs2_out,
                 func3_out, func7_out, ctrl_out);
    end

endmodule

