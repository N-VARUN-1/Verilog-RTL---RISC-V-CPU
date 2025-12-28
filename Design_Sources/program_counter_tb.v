`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2025 12:49:46 AM
// Design Name: 
// Module Name: program_counter_tb
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

module program_counter_tb;

    reg clk;
    reg rst;
    reg branch_en;
    reg [31:0] branch_target;
    wire [31:0] pc;

    // DUT
    program_counter #(
        .RESET_PC(32'h0000_0000)
    ) dut (
        .clk(clk),
        .rst(rst),
        .branch_en(branch_en),
        .branch_target(branch_target),
        .pc(pc)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        rst = 1'b1;
        branch_en = 1'b0;
        branch_target = 32'h0000_0010;  // arbitrary target

        // Hold reset for a few cycles
        #20;
        rst = 1'b0;

        // Let PC increment normally for a few cycles
        #40;   // 4 clock edges

        // Take a branch
        branch_en = 1'b1;
        #10;   // one clock edge, PC should jump to branch_target

        // Disable branch, PC should now increment from branch_target
        branch_en = 1'b0;
        #40;

        // Finish
        #20;
        $finish;
    end

    // Optional monitor for console debug
    initial begin
        $display("time   rst br_en  br_tgt      pc");
        $monitor("%4t   %b   %b   %h  %h",
                 $time, rst, branch_en, branch_target, pc);
    end

endmodule

