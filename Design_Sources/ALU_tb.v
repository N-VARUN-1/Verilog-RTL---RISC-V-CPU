`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 12:10:08 AM
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [2:0]  alu_op;
    wire [31:0] result;
    wire        zero;

    // DUT
    ALU dut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("time  alu_op  a          b          result      zero");

        // ---------- ADD ----------
        a = 32'd10;  b = 32'd20;  alu_op = 3'b000;
        #1;
        $display("%4t   ADD    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SUB (non-zero) ----------
        a = 32'd30;  b = 32'd10;  alu_op = 3'b001;
        #1;
        $display("%4t   SUB    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SUB (zero) ----------
        a = 32'd15;  b = 32'd15;  alu_op = 3'b001;
        #1;
        $display("%4t   SUB0   %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- AND ----------
        a = 32'hFFFF_00FF;  b = 32'h0F0F_F0F0;  alu_op = 3'b010;
        #1;
        $display("%4t   AND    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- OR ----------
        alu_op = 3'b011;
        #1;
        $display("%4t   OR     %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- XOR ----------
        alu_op = 3'b100;
        #1;
        $display("%4t   XOR    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SLL ----------
        a = 32'h0000_0001;  b = 32'd4;  alu_op = 3'b101;
        #1;
        $display("%4t   SLL    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SRL ----------
        a = 32'h0000_00F0;  b = 32'd4;  alu_op = 3'b110;
        #1;
        $display("%4t   SRL    %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SLT (a < b) ----------
        a = -32'sd5;  b = 32'sd3;  alu_op = 3'b111;
        #1;
        $display("%4t   SLT1   %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- SLT (a >= b) ----------
        a = 32'sd7;  b = -32'sd2;  alu_op = 3'b111;
        #1;
        $display("%4t   SLT0   %h  %h  %h   %b", $time, a, b, result, zero);

        // ---------- default ----------
        alu_op = 3'bxxx;
        #1;
        $display("%4t   DEF    %h  %h  %h   %b", $time, a, b, result, zero);

        #10;
        $finish;
    end

endmodule


