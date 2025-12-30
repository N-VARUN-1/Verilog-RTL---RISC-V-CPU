`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 01:07:30 AM
// Design Name: 
// Module Name: Write_Back_tb
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

module Write_Back_tb;

    reg  [31:0] alu_result;
    reg  [31:0] mem_data;
    reg         mem_to_reg;
    wire [31:0] write_data;

    // DUT
    Write_Back dut (
        .alu_result(alu_result),
        .mem_data(mem_data),
        .mem_to_reg(mem_to_reg),
        .write_data(write_data)
    );

    initial begin
        $display("time  mem_to_reg  alu_result    mem_data      write_data");

        // Case 0: select ALU result
        alu_result = 32'hAAAA_BBBB;
        mem_data   = 32'h1111_2222;
        mem_to_reg = 1'b0;
        #1;
        $display("%4t     %b        %h  %h  %h",
                 $time, mem_to_reg, alu_result, mem_data, write_data);

        // Case 1: select memory data
        mem_to_reg = 1'b1;
        #1;
        $display("%4t     %b        %h  %h  %h",
                 $time, mem_to_reg, alu_result, mem_data, write_data);

        // Change inputs again to be sure mux follows them
        alu_result = 32'hDEAD_BEEF;
        mem_data   = 32'h1234_5678;
        mem_to_reg = 1'b0;
        #1;
        $display("%4t     %b        %h  %h  %h",
                 $time, mem_to_reg, alu_result, mem_data, write_data);

        mem_to_reg = 1'b1;
        #1;
        $display("%4t     %b        %h  %h  %h",
                 $time, mem_to_reg, alu_result, mem_data, write_data);

        #10;
        $finish;
    end

endmodule

