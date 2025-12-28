`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 01:46:36 AM
// Design Name: 
// Module Name: Top_CPU_TB
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


//module Top_CPU_tb;

//    reg clk;
//    reg rst;

//    Top_CPU uut (
//        .clk(clk),
//        .rst(rst)
//    );

//    // Start clock and reset
//    initial begin
//        clk = 0;
//        rst = 1;
////        #20 rst = 0;       // release reset after 20 time units
////        #200 rst = 1;
////        #20 rst = 0;
//    end

//    // Clock generation: 10 time unit period
//    always #5 clk = ~clk;
//    always #5 rst = ~rst;

//    initial begin
//        // for Vivado you don't need $dumpfile/$dumpvars
//        #1000 $finish;
//    end

//endmodule

module Top_CPU_tb;

    reg clk;
    reg rst;

    // DUT
    Top_CPU uut (
        .clk(clk),
        .rst(rst)
    );

    // ------------- Clock generation (100 MHz if 1 ns units) -------------
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;    // 10 ns period
    end

    // ------------- Reset sequence -------------
    initial begin
        rst = 1'b1;
        #40;                      // hold reset high for 40 ns
        rst = 1'b0;
    end

    // ------------- Simulation control -------------
    initial begin
        // run long enough to see several instructions through the pipeline
        #5000;                    // 5000 ns = 500 cycles @10 ns
        $finish;
    end

    // ------------- Optional monitor for debug -------------
    initial begin
        $display(" time   pc_out       instr        reg_write_wb rd_wb  write_data_wb");
        $monitor("%4t  %h  %h   %b          %0d    %h",
                 $time,
                 uut.pc_out,
                 uut.instruction_out,
                 uut.reg_write_wb,
                 uut.rd_wb,
                 uut.write_data_wb);
    end

endmodule


