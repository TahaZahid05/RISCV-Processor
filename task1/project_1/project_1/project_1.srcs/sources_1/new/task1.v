`timescale 1ns / 1ps

module task1(
    input clk,
    input reset,
    output [63:0] debug_write
    );
    //PC Counter
    wire [63:0] PC_In;
    wire [63:0] PC_Out;
    wire [63:0] PCFour;
    wire [31:0] Instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [3:0] funct; 
    wire Branch;                // Branch control signal
    wire [2:0] BranchType;
    wire MemRead;               // Memory Read control signal
    wire MemtoReg;              // Memory to Register control signal
    wire MemWrite;              // Memory Write control signal
    wire ALUSrc;                // ALU Source control signal (use of immediate or register)
    wire RegWrite;              // Register Write control signal
    wire [3:0] Operation;
    wire [63:0] immediate;
    wire [63:0] PCBranch;
    wire [63:0] immediate_left;
    wire [63:0] writeData;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;
    wire [63:0] data_out;
    wire Cin;
    wire Cout;
    wire Zero;
    wire Less;
    wire [63:0] Result;
    wire [63:0] pc_final_out;
    wire signal;
    wire [63:0] Read_Data;
    wire [63:0] final_mux_data_out;
    
    //PC Counter
    Program_Counter a1(clk,reset,PC_In,PC_Out);
    
    //PC + 4
    adder b1(PC_Out, 64'd4, PCFour);
    
    //Instr_Addr
    Instruction_Memory c1(PC_Out,Instruction);
    
    //Instruction Parser
    inst_parser d1(Instruction, funct3, funct7, rs1, rs2, rd, opcode);
    
    //Control Unit Generation
    assign funct = {funct7[6], funct3};
   
   //Signals generation
    top_control g1(opcode,funct,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Operation);
    
    //Immediate Data Extractor
    imm_dat_gen e1(Instruction, immediate);
    
    
    //PC + Branch Instruction
    assign immediate_left = immediate << 1;
    adder f1(PC_Out,immediate_left, PCBranch);
    
    //Register File
    registerFile h1(writeData,rs1,rs2,rd,RegWrite,clk,reset,ReadData1,ReadData2);
    
    //Mux for ALU second input
    mux_2x1 i1(ReadData2,immediate,ALUSrc, data_out);
    
    
    //ALU
    assign Cin = Operation == 4'b0011 ? 1 : 0;
    ALU_64_bit j1(ReadData1, data_out, Cin, Operation, Cout, Zero, Less, Result);
  
    
    //Next PC deciding logic
    assign BranchType = funct3; //Decide which branch instruction it is
    // Turn signal on if branch evaluated to be taken
    assign signal = (BranchType == 3'b000) ? (Branch && Zero) :       // beq
                (BranchType == 3'b001) ? (Branch && !Zero) :      // bne
                (BranchType == 3'b100) ? (Branch && Less) :       // blt
                (BranchType == 3'b101) ? (Branch && !Less) :      // bge
                0;
    //Take PC + Branch if signal is on else take PC + 4
    mux_2x1 k1(PCFour, PCBranch, signal, pc_final_out); 
    assign PC_In = pc_final_out; 
    
    //DM
    Data_Memory l1(Result,ReadData2,clk,MemWrite,MemRead,Read_Data);
    
    //Final Mux to decide whether to pick ALU result or memory result
    mux_2x1 m1(Result,Read_Data,MemtoReg,final_mux_data_out);
    
    assign writeData = final_mux_data_out;
    
    assign debug_write = writeData;
    
    
endmodule
