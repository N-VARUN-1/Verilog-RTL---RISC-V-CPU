`timescale 1ns / 1ps

module Top_CPU_tb;

    reg clk;
    reg rst;

    // DUT
    Top_CPU uut (
        .clk(clk),
        .rst(rst)
    );

    // ------------- Clock generation (100 MHz) -------------
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
        #5000;                    // 500 cycles
        $finish;
    end

    // ------------- Monitor for debug (HIERARCHICAL PATHS) -------------
    initial begin
        $display(" time   pc_out       instr        reg_write_wb rd_wb  write_data_wb");
        $monitor("%4t  %h  %h   %b          %0d    %h",
                 $time,
                 uut.pc_out,                                    // PC port ✓
                 uut.instruction_out,                           // IMEM output ✓
                 uut.id_ex_inst.RegWrite_out,                   // ID/EX RegWrite ✓
                 uut.mem_wb_inst.rd_out,                        // MEM/WB rd ✓  
                 uut.wb_inst.write_data);                       // WB output ✓
    end

endmodule
