`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 12:32:56 AM
// Design Name: 
// Module Name: Branch_Unit_tb
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

module Branch_Unit_tb;

    reg  [31:0] rs1;
    reg  [31:0] rs2;
    reg  [2:0]  func3;
    reg         is_branch;
    wire        branch_taken;

    // DUT
    Branch_Unit dut (
        .rs1(rs1),
        .rs2(rs2),
        .func3(func3),
        .is_branch(is_branch),
        .branch_taken(branch_taken)
    );

    initial begin
        $display("time  is_br func3  rs1          rs2          branch_taken");

        // Enable branch for all tests
        is_branch = 1'b1;

        // BEQ: rs1 == rs2 -> taken
        func3 = 3'b000; rs1 = 32'd10; rs2 = 32'd10;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BEQ: rs1 != rs2 -> not taken
        func3 = 3'b000; rs1 = 32'd10; rs2 = 32'd20;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BNE: rs1 != rs2 -> taken
        func3 = 3'b001; rs1 = 32'd10; rs2 = 32'd20;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BNE: rs1 == rs2 -> not taken
        func3 = 3'b001; rs1 = 32'd15; rs2 = 32'd15;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BLT (signed): -5 < 3 -> taken
        func3 = 3'b100; rs1 = -32'sd5; rs2 = 32'sd3;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BGE (signed, using func3=101 here): 7 > -2 -> taken
        func3 = 3'b101; rs1 = 32'sd7; rs2 = -32'sd2;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BLTU (unsigned, func3=110): 5 < 10 -> taken
        func3 = 3'b110; rs1 = 32'd5; rs2 = 32'd10;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // BGEU (unsigned, func3=111): 20 > 10 -> taken
        func3 = 3'b111; rs1 = 32'd20; rs2 = 32'd10;
        #1; $display("%4t   %b    %3b  %h  %h   %b", $time, is_branch, func3, rs1, rs2, branch_taken);

        // is_branch = 0 -> branch_taken should stay 0 regardless
        is_branch = 1'b0;
        func3 = 3'b000; rs1 = 32'd10; rs2 = 32'd10;
        #1; $display("%4t   %b    %3b  %h  %h   %b (expect 0)",
                     $time, is_branch, func3, rs1, rs2, branch_taken);

        #10;
        $finish;
    end

endmodule

