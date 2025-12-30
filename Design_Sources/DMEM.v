`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2025 12:22:02 AM
// Design Name: 
// Module Name: DMEM
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


//module DMEM(
//    input clk,
//    input wire write_en,
//    input wire sign_extend,
//    input wire[31:0] addr,
//    input wire[31:0] write_data,
//    input wire[31:0] mem_write,
//    input wire[1:0] size,
//    output reg[31:0] read_data
//    );
    
//    parameter MEM_SIZE = 1024;
//    reg[7:0] mem [0:MEM_SIZE-1];
    
//    // write data
//    always @(posedge clk) begin
//        if (write_en) begin
//            case (size)
//                2'b00: begin // byte
//                    mem[addr] <= write_data[7:0];
//                end
//                2'b01: begin // halfword (little endian)
//                    mem[addr]     <= write_data[7:0];
//                    mem[addr+1]   <= write_data[15:8];
//                end
//                2'b10: begin // word (little endian)
//                    mem[addr]     <= write_data[7:0];
//                    mem[addr+1]   <= write_data[15:8];
//                    mem[addr+2]   <= write_data[23:16];
//                    mem[addr+3]   <= write_data[31:24];
//                end
//            endcase
//        end
//    end
    
    
//    // read data
//    always @(*) begin
//        case(size)
//            2'b00 : read_data = (sign_extend) ? {{24{mem[addr][7]}}, mem[addr]} : {24'd0, mem[addr]};
//            2'b01 : read_data = (sign_extend) ? {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]} : {16'd0, mem[addr+1], mem[addr]};
//            2'b10 : read_data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
//        endcase
//    end
//endmodule


module DMEM(
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire        sign_extend,
    input  wire [1:0]  size,
    input  wire [31:0] addr,        // byte address
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

    parameter MEM_SIZE = 1024; // bytes
    reg [7:0] mem [0:MEM_SIZE-1];

    // WRITE
    always @(posedge clk) begin
        if (mem_write) begin
            case (size)
                2'b00: mem[addr] <= write_data[7:0]; // SB
                2'b01: begin // SH
                    mem[addr]   <= write_data[7:0];
                    mem[addr+1] <= write_data[15:8];
                end
                2'b10: begin // SW
                    mem[addr]   <= write_data[7:0];
                    mem[addr+1] <= write_data[15:8];
                    mem[addr+2] <= write_data[23:16];
                    mem[addr+3] <= write_data[31:24];
                end
            endcase
        end
    end

    // READ
    always @(*) begin
        if (!mem_read)
            read_data = 32'd0;
        else begin
            case (size)
                2'b00: read_data = sign_extend ?
                        {{24{mem[addr][7]}}, mem[addr]} :
                        {24'd0, mem[addr]};
                2'b01: read_data = sign_extend ?
                        {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]} :
                        {16'd0, mem[addr+1], mem[addr]};
                2'b10: read_data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
                default: read_data = 32'd0;
            endcase
        end
    end
endmodule
