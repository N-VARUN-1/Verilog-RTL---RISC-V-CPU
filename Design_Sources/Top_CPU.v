module Top_CPU (
    input wire clk,
    input wire rst
);

    // ------------------ IF stage wires ------------------
    wire [31:0] pc_out;
    wire [31:0] instruction_out;

    // ------------------ IF/ID pipeline wires ------------------
    wire [31:0] pc_if_id_out;
    wire [31:0] instr_if_id_out;

    // ------------------ ID stage wires ------------------
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;
    wire [31:0] reg_read1;
    wire [31:0] reg_read2;
    wire [31:0] imm_id;
    
    // Control signals from MainControl (ID stage)
    wire [1:0] ALUOp_id;
    wire MemRead_id;
    wire MemWrite_id;
    wire RegWrite_id;
    wire Branch_id;
    wire ALUSrc_id;
    wire MemToReg_id;

    // ------------------ ID/EX pipeline wires ------------------
    wire [31:0] rs1_val_ex;
    wire [31:0] rs2_val_ex;
    wire [31:0] imm_ex;
    wire [6:0] func7_ex;
    wire [2:0] func3_ex;
    wire [4:0] rs1_ex;
    wire [4:0] rs2_ex;
    wire [4:0] rd_ex;
    
    // ID/EX Control signals (explicit - matches corrected ID_EX)
    wire MemToReg_ex;
    wire MemRead_ex;
    wire MemWrite_ex;
    wire RegWrite_ex;
    wire Branch_ex;
    wire ALUSrc_ex;
    wire [1:0] ALUOp_ex;

    // ------------------ EX stage wires ------------------
    wire [2:0] alu_op_ex;
    wire [31:0] alu_result_ex;
    wire alu_zero_ex;
    wire branch_taken_ex;
    wire [31:0] branch_target_ex;

    // ------------------ EX/MEM pipeline wires ------------------
    wire [31:0] alu_result_mem;
    wire [31:0] rs2_data_mem;
    wire [4:0] rd_mem;
    wire RegWrite_mem;
    wire MemWrite_mem;
    wire MemRead_mem;
    wire MemToReg_mem;
    wire branch_taken_mem;

    // ------------------ MEM stage wires ------------------
    wire [31:0] mem_read_data;
    wire [1:0] mem_size;
    wire mem_sign_extend;

    // ------------------ MEM/WB pipeline wires ------------------
    wire [31:0] alu_result_wb;
    wire [31:0] mem_data_wb;
    wire [4:0] rd_wb;
    wire RegWrite_wb;
    wire MemToReg_wb;

    // ------------------ Writeback wires ------------------
    wire [31:0] write_data_wb;

    // ------------------ Branch / PC control ------------------
    wire branch_en;
    wire [31:0] branch_target;

    wire [6:0] opcode_ex;
    wire [31:0] pc_ex;
    wire [31:0] alu_b;

    // =====================================================================
    //                          MODULE INSTANTIATIONS
    // =====================================================================

    // 1. Program Counter
    program_counter #(
        .RESET_PC(32'h0000_0000)
    ) pc_inst (
        .clk(clk),
        .rst(rst),
        .branch_en(branch_en),
        .branch_target(branch_target),
        .pc(pc_out)
    );

    // 2. Instruction Memory (corrected version)
    Instruction_Memory_BRAM imem_inst (
        .clk(clk),
        .write_en(1'b0),
        .addr(pc_out[11:2]),
        .write_data(32'h0),
        .read_data(instruction_out)
    );

    // 3. IF/ID Pipeline Register
    IF_ID_Pipeline_Register if_id_inst (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_out),
        .instruction_in(instruction_out),
        .pc_out(pc_if_id_out),
        .instruction_out(instr_if_id_out)
    );

    // 4. Register File (corrected version)
    Register_File regfile_inst (
        .clk(clk),
        .rst(rst),
        .we(RegWrite_wb),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .rd(rd_wb),
        .wd(write_data_wb),
        .read1(reg_read1),
        .read2(reg_read2)
    );

    // 5. Immediate Generator (corrected version)
    Imm_Gen imm_gen_inst (
        .instr(instr_if_id_out),
        .imm_out(imm_id)
    );

    // 6. Main Control
    MainControl main_ctrl_inst (
        .opcode(instr_if_id_out[6:0]),
        .ALUOp(ALUOp_id),
        .MemRead(MemRead_id),
        .MemWrite(MemWrite_id),
        .RegWrite(RegWrite_id),
        .Branch(Branch_id),
        .ALUSrc(ALUSrc_id),
        .MemToReg(MemToReg_id)
    );

    // 7. ID/EX Pipeline Register (corrected explicit signals version)
    ID_EX_Pipe_Reg id_ex_inst (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_if_id_out),
        .rs1_val_in(reg_read1),
        .rs2_val_in(reg_read2),
        .imm_in(imm_id),
        .rs1_in(rs1_addr),
        .rs2_in(rs2_addr),
        .rd_in(rd_addr),
        .func3_in(instr_if_id_out[14:12]),
        .func7_in(instr_if_id_out[31:25]),
        .MemToReg_in(MemToReg_id),
        .MemRead_in(MemRead_id),
        .MemWrite_in(MemWrite_id),
        .RegWrite_in(RegWrite_id),
        .Branch_in(Branch_id),
        .ALUSrc_in(ALUSrc_id),
        .pc_out(pc_ex),
        .ALUOp_in(ALUOp_id),

        .rs1_val_out(rs1_val_ex),
        .rs2_val_out(rs2_val_ex),
        .imm_out(imm_ex),
        .rs1_out(rs1_ex),
        .rs2_out(rs2_ex),
        .rd_out(rd_ex),
        .func3_out(func3_ex),
        .func7_out(func7_ex),
        .MemToReg_out(MemToReg_ex),
        .MemRead_out(MemRead_ex),
        .MemWrite_out(MemWrite_ex),
        .RegWrite_out(RegWrite_ex),
        .Branch_out(Branch_ex),
        .ALUSrc_out(ALUSrc_ex),
        .ALUOp_out(ALUOp_ex)
    );

    // 8. ALU Control Unit (corrected version)
    ALU_CU alu_cu_inst (
        .opcode(opcode_ex),
        .func3(func3_ex),
        .func7(func7_ex),
        .ALUOp(ALUOp_ex),
        .alu_op(alu_op_ex)
    );

    // 9. ALU (corrected version)
    ALU alu_inst (
        .a(rs1_val_ex),
        .b(alu_b),
        .alu_op(alu_op_ex),
        .result(alu_result_ex),
        .zero(alu_zero_ex)
    );

    // 10. Branch Unit
    Branch_Unit branch_unit_inst (
        .rs1(rs1_val_ex),
        .rs2(rs2_val_ex),
        .func3(func3_ex),
        .is_branch(Branch_ex),
        .branch_taken(branch_taken_ex)
    );

    // 11. EX/MEM Pipeline Register
    EX_MEM_Pipe_Reg ex_mem_inst (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_ex),
        .rs2_data_in(rs2_val_ex),
        .rd_in(rd_ex),
        .reg_write_in(RegWrite_ex),
        .mem_write_in(MemWrite_ex),
        .mem_read_in(MemRead_ex),
        .mem_to_reg_in(MemToReg_ex),
        .branch_taken_in(branch_taken_ex),

        .alu_result_out(alu_result_mem),
        .rs2_data_out(rs2_data_mem),
        .rd_out(rd_mem),
        .reg_write_out(RegWrite_mem),
        .mem_write_out(MemWrite_mem),
        .mem_read_out(MemRead_mem),
        .mem_to_reg_out(MemToReg_mem),
        .branch_taken_out(branch_taken_mem)
    );

    // 12. Data Memory (corrected version)
    DMEM dmem_inst (
        .clk(clk),
        .mem_read(MemRead_mem),
        .mem_write(MemWrite_mem),
        .size(func3_ex[1:0]),
        .sign_extend(func3_ex[2]),
        .addr(alu_result_mem),
        .write_data(rs2_data_mem),
        .read_data(mem_read_data)
    );

    // 13. MEM/WB Pipeline Register
    MEM_WB_Pipe_Reg mem_wb_inst (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_mem),
        .mem_data_in(mem_read_data),
        .rd_in(rd_mem),
        .reg_write_in(RegWrite_mem),
        .mem_to_reg_in(MemToReg_mem),

        .alu_result_out(alu_result_wb),
        .mem_data_out(mem_data_wb),
        .rd_out(rd_wb),
        .reg_write_out(RegWrite_wb),
        .mem_to_reg_out(MemToReg_wb)
    );

    // 14. Write Back
    Write_Back wb_inst (
        .alu_result(alu_result_wb),
        .mem_data(mem_data_wb),
        .mem_to_reg(MemToReg_wb),
        .write_data(write_data_wb)
    );

    // =====================================================================
    //                              ASSIGNMENTS
    // =====================================================================

   // Internal implementation omitted in public version.
   // Complete source is available for technical evaluation.

endmodule
