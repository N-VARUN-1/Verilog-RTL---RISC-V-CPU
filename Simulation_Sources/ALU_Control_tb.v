`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 12:15:04 AM
// Design Name: 
// Module Name: ALU_Control_tb
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

module ALU_CU_tb;

    reg  [6:0] opcode;
    reg  [2:0] func3;
    reg  [6:0] func7;
    reg  [1:0] ALUOp;
    wire [2:0] alu_op;

    // DUT
    ALU_CU dut (
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .ALUOp(ALUOp),
        .alu_op(alu_op)
    );

    initial begin
        $display("time  ALUOp func3 func7[5]  alu_op");

        // ALUOp = 00 : ADD (for load/store)
        ALUOp = 2'b00; func3 = 3'b000; func7 = 7'b0000000; opcode = 7'b0000011;
        #1;
        $display("%4t   %b    %3b    %b       %3b", $time, ALUOp, func3, func7[5], alu_op);

        // ALUOp = 01 : SUB (for branches)
        ALUOp = 2'b01; func3 = 3'b000; func7 = 7'b0000000; opcode = 7'b1100011;
        #1;
        $display("%4t   %b    %3b    %b       %3b", $time, ALUOp, func3, func7[5], alu_op);

        // ALUOp = 10 : R/I‑type operations

        // ADD  (func3=000, func7[5]=0)
        ALUOp = 2'b10; func3 = 3'b000; func7 = 7'b0000000;
        #1;
        $display("%4t   R ADD   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SUB  (func3=000, func7[5]=1)
        func3 = 3'b000; func7 = 7'b0100000;
        #1;
        $display("%4t   R SUB   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SLL  (func3=001)
        func3 = 3'b001; func7 = 7'b0000000;
        #1;
        $display("%4t   R SLL   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SLT  (func3=010)
        func3 = 3'b010; func7 = 7'b0000000;
        #1;
        $display("%4t   R SLT   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SLTU (func3=011)
        func3 = 3'b011; func7 = 7'b0000000;
        #1;
        $display("%4t   R SLTU  %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // XOR  (func3=100)
        func3 = 3'b100; func7 = 7'b0000000;
        #1;
        $display("%4t   R XOR   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SRL  (func3=101, func7[5]=0)
        func3 = 3'b101; func7 = 7'b0000000;
        #1;
        $display("%4t   R SRL   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // SRA  (func3=101, func7[5]=1)
        func3 = 3'b101; func7 = 7'b0100000;
        #1;
        $display("%4t   R SRA   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // OR   (func3=110)
        func3 = 3'b110; func7 = 7'b0000000;
        #1;
        $display("%4t   R OR    %3b    %b       %3b", $time, func3, func7[5], alu_op);

        // AND  (func3=111)
        func3 = 3'b111; func7 = 7'b0000000;
        #1;
        $display("%4t   R AND   %3b    %b       %3b", $time, func3, func7[5], alu_op);

        #10;
        $finish;
    end

endmodule

