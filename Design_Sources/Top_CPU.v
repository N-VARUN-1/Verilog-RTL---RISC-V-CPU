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
    wire [1:0] ALUOp_id;
    wire MemRead_id;
    wire MemWrite_id;
    wire RegWrite_id;
    wire Branch_id;
    wire ALUSrc_id;
    wire MemToReg_id;
    wire [3:0] ctrl_id;

    // ------------------ ID/EX pipeline wires ------------------
    wire [31:0] rs1_val_ex;
    wire [31:0] rs2_val_ex;
    wire [31:0] imm_ex;
    wire [6:0] func7_ex;
    wire [2:0] func3_ex;
    wire [4:0] rs1_ex;
    wire [4:0] rs2_ex;
    wire [4:0] rd_ex;
    wire [3:0] ctrl_ex;

    // ------------------ EX stage wires ------------------
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire [2:0] alu_op_ex;
    wire [31:0] alu_result_ex;
    wire alu_zero_ex;
    wire branch_taken_ex;
    wire [31:0] branch_target_ex;

    // ------------------ EX/MEM pipeline wires ------------------
    wire [31:0] alu_result_mem;
    wire [31:0] rs2_data_mem;
    wire [4:0] rd_mem;
    wire reg_write_mem;
    wire mem_write_mem;
    wire mem_read_mem;
    wire branch_taken_mem;

    // ------------------ MEM stage wires ------------------
    wire [31:0] mem_addr;
    wire [31:0] mem_write_data;
    wire [31:0] mem_read_data;
    wire [1:0] mem_size;
    wire mem_sign_extend;

    // ------------------ MEM/WB pipeline wires ------------------
    wire [31:0] alu_result_wb;
    wire [31:0] mem_data_wb;
    wire [4:0] rd_wb;
    wire reg_write_wb;
    wire mem_to_reg_wb;

    // ------------------ Writeback wires ------------------
    wire [31:0] write_data_wb;

    // ------------------ Branch / PC control ------------------
    wire branch_en;
    wire [31:0] branch_target;
    
    // ID
    wire mem_to_reg_id;
    // ID/EX
    wire mem_to_reg_ex;
    // EX/MEM
    wire mem_to_reg_mem;
    // MEM/WB
    wire mem_to_reg_wb;
    
    
    //Testing
    wire [4:0] debug_rd   = 5'd1;          // always write x1
    wire       debug_we   = 1'b1;          // always enable write
    wire [31:0] debug_wd  = alu_result_ex; // direct from EX stage
    
    
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

    // 2. Instruction Memory
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

    // 4. Register File
//    Register_File regfile_inst (
//        .clk(clk),
//        .rst(rst),
//        .we(reg_write_wb),
//        .rs1(rs1_addr),
//        .rs2(rs2_addr),
//        .rd(rd_wb),
//        .wd(write_data_wb),
//        .read1(reg_read1),
//        .read2(reg_read2)
//    );
    
    // Testing
    Register_File regfile_inst (
        .clk(clk),
        .rst(rst),
        .we(debug_we),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .rd(debug_rd),
        .wd(debug_wd),
        .read1(reg_read1),
        .read2(reg_read2)
    );

    // 5. Immediate Generator
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

    assign ctrl_id = {RegWrite_id, MemRead_id, MemWrite_id, Branch_id};

    // 7. ID/EX Pipeline Register
    ID_EX_Pipe_Reg id_ex_inst (
        .clk(clk),
        .rst(rst),
        .rs1_val(reg_read1),
        .rs2_val(reg_read2),
        .rd(rd_addr),
        .func3(instr_if_id_out[14:12]),
        .func7(instr_if_id_out[31:25]),
        .imm(imm_id),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .ctrl(ctrl_id),
        .mem_to_reg_in(mem_to_reg_id),

        .rs1_val_out(rs1_val_ex),
        .rs2_val_out(rs2_val_ex),
        .imm_out(imm_ex),
        .func7_out(func7_ex),
        .func3_out(func3_ex),
        .rs1_out(rs1_ex),
        .rs2_out(rs2_ex),
        .rd_out(rd_ex),
        .ctrl_out(ctrl_ex),
        .mem_to_reg_out(mem_to_reg_ex)
    );

    // 8. ALU Control Unit
    ALU_CU alu_cu_inst (
        .opcode(instr_if_id_out[6:0]),
        .func3(func3_ex),
        .func7(func7_ex),
        .ALUOp(ALUOp_id),
        .alu_op(alu_op_ex)
    );

    // 9. ALU
    ALU alu_inst (
        .a(alu_a),
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
        .is_branch(Branch_id),
        .branch_taken(branch_taken_ex)
    );

    // 11. EX/MEM Pipeline Register
    EX_MEM_Pipe_Reg ex_mem_inst (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_ex),
        .rs2_data_in(rs2_val_ex),
        .rd_in(rd_ex),
        .reg_write_in(ctrl_ex[3]),
        .mem_write_in(ctrl_ex[1]),
        .mem_read_in(ctrl_ex[2]),
        .branch_taken_in(branch_taken_ex),
        .mem_to_reg_in(mem_to_reg_ex),


        .alu_result_out(alu_result_mem),
        .rs2_data_out(rs2_data_mem),
        .rd_out(rd_mem),
        .reg_write_out(reg_write_mem),
        .mem_write_out(mem_write_mem),
        .mem_read_out(mem_read_mem),
        .branch_taken_out(branch_taken_mem),
        .mem_to_reg_out(mem_to_reg_mem)

    );

    // 12. Data Memory
    DMEM dmem_inst (
        .clk(clk),
        .write_en(mem_write_mem),
        .sign_extend(1'b1), // sign extend by default
        .addr(alu_result_mem),
        .write_data(rs2_data_mem),
        .mem_write(rs2_data_mem),
        .size(2'b10), // word size
        .read_data(mem_read_data)
    );

    // 13. MEM/WB Pipeline Register
    MEM_WB_Pipe_Reg mem_wb_inst (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_mem),
        .mem_data_in(mem_read_data),
        .rd_in(rd_mem),
        .reg_write_in(reg_write_mem),
        .mem_to_reg_in(mem_to_reg_mem),

        .alu_result_out(alu_result_wb),
        .mem_data_out(mem_data_wb),
        .rd_out(rd_wb),
        .reg_write_out(reg_write_wb),
        .mem_to_reg_out(mem_to_reg_wb)
    );

    // 14. Write Back
    Write_Back wb_inst (
        .alu_result(alu_result_wb),
        .mem_data(mem_data_wb),
        .mem_to_reg(mem_to_reg_wb),
        .write_data(write_data_wb)
    );

    // =====================================================================
    //                              ASSIGNMENTS
    // =====================================================================

    // Decode rs1, rs2, rd from IF/ID instruction
    assign rs1_addr = instr_if_id_out[19:15];
    assign rs2_addr = instr_if_id_out[24:20];
    assign rd_addr  = instr_if_id_out[11:7];

    // ALU input selection (ALUSrc)
    assign alu_a = rs1_val_ex;
    assign alu_b = ALUSrc_id ? imm_ex : rs2_val_ex;

    // Branch target calculation
    assign branch_target_ex = pc_if_id_out + imm_ex;

    // Branch control to PC
    assign branch_en = 1'b0;
    assign branch_target = branch_target_ex;

    // Data Memory size (from instruction bits)
    assign mem_size = instr_if_id_out[13:12]; // SB, SH, SW
    
    assign mem_to_reg_id = MemToReg_id;

    // MEM/WB mem_to_reg (from Main Control)
//    assign mem_to_reg_wb = MemToReg_id;

endmodule
