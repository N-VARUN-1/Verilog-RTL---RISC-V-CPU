`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2025 12:37:37 AM
// Design Name: 
// Module Name: Register_File
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


//module Register_File(
//    input wire clk,
//    input wire rst,
//    input wire we,
//    input wire[4:0] rs1,
//    input wire[4:0] rs2,
//    input wire[4:0] rd,
//    input wire[31:0] wd,
//    output reg[31:0] read1,
//    output reg[31:0] read2
//    );
//    reg[31:0] regFile[31:0];
//    integer i;
//    always @(posedge clk) begin
//        regFile[0] <= 32'd0;
//        if(rst) begin 
//            for(i=0; i<32; i = i+1)
//                regFile[i] <= 32'd0;
//        end
//        else if(we && rd != 5'd0) begin
//            regFile[rd] <= wd;
//        end
//    end
    
//    always @(*) begin
//        read1 <= (rs1 == 5'd0) ? 32'd0 : regFile[rs1];
//        read2 <= (rs2 == 5'd0) ? 32'd0 : regFile[rs2];
//    end
//endmodule


module Register_File(
    input wire clk, rst, we,
    input wire[4:0] rs1, rs2, rd,
    input wire[31:0] wd,
    output reg[31:0] read1, read2
);
    reg[31:0] regFile[31:0];
    
    // Right back Stage
    always @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < 32; i = i + 1)
                regFile[i] <= 32'd0;
        end else begin
            if (we && rd != 5'd0)
                regFile[rd] <= wd;
            regFile[0] <= 32'd0; // enforce x0
        end
    end
    
    // Combinatorial read (unchanged - correct)
//    always @(*) begin
//        read1 = (rs1 == 5'd0) ? 32'd0 : regFile[rs1];
//        read2 = (rs2 == 5'd0) ? 32'd0 : regFile[rs2];
//    end

    always @(*) begin
        // rs1
        if (rs1 == 5'd0)
            read1 = 32'd0;
        else if (we && rd == rs1)
            read1 = wd;
        else
            read1 = regFile[rs1];

        // rs2
        if (rs2 == 5'd0)
            read2 = 32'd0;
        else if (we && rd == rs2)
            read2 = wd;
        else
            read2 = regFile[rs2];
    end
endmodule
