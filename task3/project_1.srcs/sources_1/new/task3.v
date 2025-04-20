`timescale 1ns / 1ps

module task_3 (
    input clk, 
    input reset,
    output [63:0] debug_MEMWB_writeData
);
    // Pipeline wires
    wire [63:0] PC_to_IM;
    wire [31:0] IM_to_IFID;
    wire [63:0] IFID_PC_addr_store;
    wire [31:0] IFID_to_inst_parse;
    wire [6:0] opcode_store;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rd, rs1, rs2;
    wire [3:0] IDEX_func_store;      
    wire [4:0] IDEX_rs1_store;      
    wire [4:0] IDEX_rs2_store;       
    wire [4:0] IDEX_rd_store;        
    wire IDEX_Branch_store;        
    wire [63:0] ReadData1, ReadData2, immediate;
    wire [63:0] IDEX_PC_addr_store;
    wire [63:0] IDEX_ReadData1_store;
    wire [63:0] IDEX_ReadData2_store;
    wire [63:0] IDEX_imm_data_store;
    wire [63:0] EXMEM_ALU_result_store;
    wire [63:0] EXMEM_WriteData_store;
    wire [63:0] MEMWB_Read_Data_store;
    wire [63:0] MEMWB_ALU_result_store;
    wire [63:0] mux_to_Writedata;
    // Forwarding
    wire [1:0] forwardA;
    wire [1:0] forwardB;
    // Hazard Detection
    wire stall_pc;
    wire stall_ifid;
    wire flush_idex;
    wire flush_ifid;
    wire flush_idex_comb;
    wire flush_exmem;
    
    // Control signals
    wire Branch_store, MemRead_store, MemtoReg_store, MemWrite_store, ALUSrc_store, RegWrite_store;
    wire [1:0] ALUOp_store;
    wire [3:0] ALU_Operation;
    wire IDEX_ALUSrc_store, IDEX_RegWrite_store, IDEX_MemtoReg_store;
    wire [1:0] IDEX_ALUOp_store;
    wire EXMEM_RegWrite_store, EXMEM_MemtoReg_store;
    wire MEMWB_RegWrite_store, MEMWB_MemtoReg_store;
    wire [4:0] MEMWB_rd_out;

    // ALU signals
    wire ALU_Cout, ALU_Zero, ALU_Less;
    
    // Fixed value of PC
    wire [63:0] fixed_4 = 64'd4;
    wire [63:0] PC_final;
    wire [63:0] PC_plus_4_to_mux;
    // New wires for EX_MEM outputs
    wire [63:0] EXMEM_PC_with_immediate_store;
    wire [3:0] EXMEM_func_store;
    wire EXMEM_Less_store;
    wire EXMEM_Zero_store;
    wire EXMEM_Branch_store;
    
    wire [63:0] pc_final_out;
    wire signal;
    wire branch_taken = signal;

    // Program Counter
    PC_2 pc1 (
        .clk(clk),
        .reset(reset),
        .PC_In(PC_final),
        .PC_Write(~stall_pc),
        .PC_Out(PC_to_IM)
    );

    // Fetch Stage
    adder add1 (
        .a(PC_to_IM),
        .b(fixed_4),
        .out(PC_plus_4_to_mux)
    );

    IM_2 INST_Mem (
        .Instr_Addr(PC_to_IM),
        .Instruction(IM_to_IFID)
    );
    
    assign flush_ifid = branch_taken;

    IF_ID_2 fd1 (
        .clk(clk),
        .PC_addr(PC_to_IM),
        .Inst(IM_to_IFID),
        .IF_ID_Write(~stall_ifid),
        .flush(flush_ifid),
        .PC_addr_store(IFID_PC_addr_store),
        .Inst_store(IFID_to_inst_parse)
    );
    
    Hazard_Detection_Unit HDU (
        .reset(reset),
        .id_ex_memread(IDEX_MemRead_store),
        .id_ex_rd(IDEX_rd_store),
        .if_id_rs1(rs1),
        .if_id_rs2(rs2),
        .stall_pc(stall_pc),
        .stall_if_id(stall_ifid),
        .flush_id_ex(flush_idex)
    );

    // Decode Stage
    inst_parser Par1 (
        .inst(IFID_to_inst_parse),
        .func3(func3),
        .func7(func7),
        .opcode(opcode_store),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    Control_Unit Cu1 (
        .Opcode(opcode_store),
        .ALUOp(ALUOp_store),
        .Branch(Branch_store), 
        .MemRead(MemRead_store), 
        .MemtoReg(MemtoReg_store),
        .MemWrite(MemWrite_store), 
        .ALUSrc(ALUSrc_store),
        .RegWrite(RegWrite_store)
    );

    registerFile rf1 (
        .WriteData(^mux_to_Writedata === 1'bx ? 63'd0 : mux_to_Writedata),
        .RS1(rs1),
        .RS2(rs2),
        .RD(^MEMWB_rd_out === 1'bx ? 5'd0 : MEMWB_rd_out),
        .RegWrite(^MEMWB_RegWrite_store === 1'bx ? 0 : MEMWB_RegWrite_store),
        .clk(clk),
        .reset(reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    imm_dat_gen ig1 (
        .inst(IFID_to_inst_parse),
        .imm(immediate)
    );

    



    wire [3:0] func = {IFID_to_inst_parse[30], IFID_to_inst_parse[14:12]};
    assign flush_idex_comb = branch_taken | flush_idex;

    ID_EX_2 id_ex1 (
        .clk(clk),
        .flush(flush_idex_comb),
        .PC_addr(IFID_PC_addr_store),
        .read_data1(ReadData1),
        .read_data2(ReadData2),
        .immediate(immediate),
        .func(func),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .MemtoReg(MemtoReg_store),
        .RegWrite(RegWrite_store),
        .Branch(Branch_store),
        .MemWrite(MemWrite_store),
        .MemRead(MemRead_store),
        .ALUSrc(ALUSrc_store),
        .ALU_op(ALUOp_store),
        .PC_addr_store(IDEX_PC_addr_store),
        .read_data1_store(IDEX_ReadData1_store),
        .read_data2_store(IDEX_ReadData2_store),
        .immediate_store(IDEX_imm_data_store),
        .func_store(IDEX_func_store),
        .rs1_store(IDEX_rs1_store),
        .rs2_store(IDEX_rs2_store),
        .rd_store(IDEX_rd_store),
        .MemtoReg_store(IDEX_MemtoReg_store),
        .RegWrite_store(IDEX_RegWrite_store),
        .Branch_store(IDEX_Branch_store),
        .MemWrite_store(IDEX_MemWrite_store),
        .MemRead_store(IDEX_MemRead_store),
        .ALUSrc_store(IDEX_ALUSrc_store),
        .ALU_op_store(IDEX_ALUOp_store)
    );
    
    // Execution Stage
    wire [63:0] alu_mux_out;
    
    ALU_Control ALU_Control1 (
        .ALUOp(IDEX_ALUOp_store),
        .Funct(IDEX_func_store),
        .Operation(ALU_Operation)
    );

    

    wire [63:0] alu_result_out;
    wire [4:0] EXMEM_rd_out;
    Forwarding_Unit FU (
        .id_ex_rs1(IDEX_rs1_store),
        .id_ex_rs2(IDEX_rs2_store),
        .ex_mem_rd(EXMEM_rd_out),
        .ex_mem_regwrite(EXMEM_RegWrite_store),
        .mem_wb_rd(MEMWB_rd_out),
        .mem_wb_regwrite(MEMWB_RegWrite_store),
        .forward_a(forwardA),
        .forward_b(forwardB)
    );
    
    
    reg [63:0] alu_input1;
    reg [63:0] alu_input2;
    always @(*) begin
        case (forwardA)
            2'b00: alu_input1 = IDEX_ReadData1_store;
            2'b10: alu_input1 = EXMEM_ALU_result_store;
            2'b01: alu_input1 = mux_to_Writedata;
            default: alu_input1 = IDEX_ReadData1_store;
        endcase
    
        case (forwardB)
            2'b00: alu_input2 = IDEX_ReadData2_store;
            2'b10: alu_input2 = EXMEM_ALU_result_store;
            2'b01: alu_input2 = mux_to_Writedata;
            default: alu_input2 = IDEX_ReadData2_store;
        endcase
    end

    mux_2x1 ALU_mux (
        .a(alu_input2),
        .b(IDEX_imm_data_store),
        .sel(IDEX_ALUSrc_store),
        .data_out(alu_mux_out)
    );



    ALU_64_bit aaloo64 (
        .a(alu_input1),
        .b(alu_mux_out),
        .Cin(1'b0), 
        .ALUOp(ALU_Operation),
        .Cout(ALU_Cout), 
        .ZERO(ALU_Zero), 
        .Less(ALU_Less), 
        .Result(alu_result_out)
    );
    
    
    assign flush_exmem = branch_taken;

       EX_MEM em1 (
        .clk(clk),
        .flush_exmem(flush_exmem),
        .PC_with_immediate(IDEX_PC_addr_store + (IDEX_imm_data_store << 1)), 
        .ALU_result(alu_result_out),
        .WriteData(alu_input2),
        .func(IDEX_func_store),
        .rd(IDEX_rd_store),
        .Less(ALU_Less),
        .Zero(ALU_Zero),
        .RegWrite(IDEX_RegWrite_store),
        .MemtoReg(IDEX_MemtoReg_store),
        .Branch(IDEX_Branch_store),
        .MemWrite(IDEX_MemWrite_store),
        .MemRead(IDEX_MemRead_store),
        .PC_with_immediate_store(EXMEM_PC_with_immediate_store), 
        .ALU_result_store(EXMEM_ALU_result_store),
        .WriteData_store(EXMEM_WriteData_store),
        .func_store(EXMEM_func_store),       
        .rd_store(EXMEM_rd_out),
        .Less_store(EXMEM_Less_store),      
        .Zero_store(EXMEM_Zero_store),      
        .RegWrite_store(EXMEM_RegWrite_store),
        .MemtoReg_store(EXMEM_MemtoReg_store),
        .Branch_store(EXMEM_Branch_store),  
        .MemWrite_store(EXMEM_MemWrite_store),
        .MemRead_store(EXMEM_MemRead_store)
    );
    
    
    
        //PC Mux Complete
    
//    assign signal = Branch && Zero; 
    assign signal = (EXMEM_func_store[2:0] == 3'b000) ? (EXMEM_Branch_store && EXMEM_Zero_store) :       // beq
                (EXMEM_func_store[2:0] == 3'b001) ? (EXMEM_Branch_store && !EXMEM_Zero_store) :      // bne
                (EXMEM_func_store[2:0] == 3'b100) ? (EXMEM_Branch_store && EXMEM_Less_store) :       // blt
                (EXMEM_func_store[2:0] == 3'b101) ? (EXMEM_Branch_store && !EXMEM_Less_store) :      // bge
                0;
                
    
    
    
    wire [63:0] branch_PC = PC_to_IM + (immediate << 1);
    
    mux_2x1 k1(PC_plus_4_to_mux, EXMEM_PC_with_immediate_store, signal, pc_final_out); 
//    assign PC_final = pc_final_out; 
    
    assign PC_final = signal === 1'bX ? PC_plus_4_to_mux : pc_final_out;
    
    

    // Memory Stage
    wire [63:0] DM_Read_Data_out;
    
    Data_Memory Datamem (
        .Mem_Addr(EXMEM_ALU_result_store),
        .Write_Data(EXMEM_WriteData_store),
        .clk(clk),
        .MemWrite(EXMEM_MemWrite_store),
        .MemRead(EXMEM_MemRead_store),
        .Read_Data(DM_Read_Data_out)
    );

        MEM_WB mem_wb1 (
        .clk(clk),
        .ReadData(DM_Read_Data_out),
        .ALU_result(EXMEM_ALU_result_store),
        .rd(EXMEM_rd_out),
        .RegWrite(EXMEM_RegWrite_store),
        .MemtoReg(EXMEM_MemtoReg_store),
        .ReadData_store(MEMWB_Read_Data_store),
        .ALU_result_store(MEMWB_ALU_result_store),
        .rd_store(MEMWB_rd_out),
        .RegWrite_store(MEMWB_RegWrite_store),
        .MemtoReg_store(MEMWB_MemtoReg_store)
    );

    

    
    // Writeback Stage
    mux_2x1 WB_mux (
        .a(MEMWB_ALU_result_store),
        .b(MEMWB_Read_Data_store),
        .sel(MEMWB_MemtoReg_store),
        .data_out(mux_to_Writedata)
    );
    
    assign debug_MEMWB_writeData = mux_to_Writedata;

endmodule