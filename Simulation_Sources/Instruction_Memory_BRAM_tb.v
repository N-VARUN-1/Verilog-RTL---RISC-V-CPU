`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2025 01:35:49 AM
// Design Name: 
// Module Name: Instruction_Memory_BRAM_tb
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


module Instruction_Memory_BRAM_tb;
    reg clk;
    reg write_en;
    reg[31:0] addr;
    reg[31:0] write_data;
    wire[31:0] read_data;
    
    Instruction_Memory_BRAM dur(
        .clk(clk),
        .write_en(write_en),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );
    
    
    initial
    begin
        clk = 1'b0;
        forever #5 clk = ~clk;        
    end
    
    initial begin
        write_en = 1'b0;
        addr = 31'd0;
        write_data = 31'h0000_0000;
        
        #20
        
        
        addr = 32'd0;
        #10
        $display("Time %0t: Read mem[0]   = 0x%08h", $time, read_data);
        
        
        addr = 32'd1;
        #10
        $display("Time %0t: Read mem[1]   = 0x%08h", $time, read_data);
        
        addr = 32'd2;
        #10;
        $display("Time %0t: Read mem[2]   = 0x%08h", $time, read_data);
        
         // ---------------- WRITE then READ BACK ----------------
        // Write a known pattern to address 4
        addr       = 32'd4;
        write_data = 32'hDEADBEEF;
        write_en   = 1'b1;
        #10;                      // write occurs on this clock edge

        // Disable write, read back from address 4
        write_en = 1'b0;
        #10;                      // next clock: read_data should be DEADBEEF
        $display("Time %0t: Read mem[4]   = 0x%08h (expect 0xDEADBEEF)", 
                 $time, read_data);

        #20;
        $finish;
        
    end
    
endmodule
