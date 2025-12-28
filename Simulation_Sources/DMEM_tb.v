`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 12:50:32 AM
// Design Name: 
// Module Name: DMEM_tb
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

module DMEM_tb;

    reg         clk;
    reg         write_en;
    reg         sign_extend;
    reg [31:0]  addr;
    reg [31:0]  write_data;
    reg [31:0]  mem_write;   // unused in DUT, tie to write_data
    reg [1:0]   size;
    wire [31:0] read_data;

    // DUT
    DMEM dut (
        .clk(clk),
        .write_en(write_en),
        .sign_extend(sign_extend),
        .addr(addr),
        .write_data(write_data),
        .mem_write(mem_write),
        .size(size),
        .read_data(read_data)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        write_en    = 1'b0;
        sign_extend = 1'b0;
        addr        = 32'd0;
        write_data  = 32'h0000_0000;
        mem_write   = 32'h0000_0000;
        size        = 2'b10;  // default word

        // -----------------------------------
        // 1) Byte write/read (size = 00)
        // -----------------------------------
        #10;
        addr       = 32'd0;
        size       = 2'b00;
        write_data = 32'h0000_00AA;   // low byte = 0xAA
        mem_write  = write_data;
        write_en   = 1'b1;
        #10;                          // write on this clk edge

        write_en   = 1'b0;
        sign_extend = 1'b0;
        #1;                           // combinational read
        $display("BYTE  zx  read_data = %h (expect 000000AA)", read_data);

        sign_extend = 1'b1;
        #1;
        $display("BYTE  sx  read_data = %h (expect FFFFFFAA)", read_data);

        // -----------------------------------
        // 2) Halfword write/read (size = 01)
        // -----------------------------------
        addr       = 32'd4;
        size       = 2'b01;
        write_data = 32'h0000_BBCC;   // low halfword = 0xBBCC
        mem_write  = write_data;
        write_en   = 1'b1;
        #10;

        write_en    = 1'b0;
        sign_extend = 1'b0;
        #1;
        $display("HALF zx  read_data = %h (lower 16 bits BBCC expected)", read_data);

        sign_extend = 1'b1;
        #1;
        $display("HALF sx  read_data = %h (sign‑extended from bit 15)", read_data);

        // -----------------------------------
        // 3) Word write/read (size = 10)
        // -----------------------------------
        addr       = 32'd8;
        size       = 2'b10;
        write_data = 32'h1122_3344;
        mem_write  = write_data;
        write_en   = 1'b1;
        #10;

        write_en    = 1'b0;
        sign_extend = 1'b0;  // irrelevant for word
        #1;
        $display("WORD     read_data = %h (expect 11223344)", read_data);

        #20;
        $finish;
    end

endmodule

