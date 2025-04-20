`timescale 1ns / 1ps

module IM_2 (
    input [63:0] Instr_Addr,    // 64-bit instruction address input
    output [31:0] Instruction   // 32-bit instruction output
    );
   
    // Declaring a memory array with 16 entries of 8-bit width (bytes)
//    reg [7:0] Inst_Memory[227:0];  
//    reg [31:0] instruction_in[56:0];
      reg [7:0] Inst_Memory[127:0];  
      reg [31:0] instruction_in[31:0];  
   
   
    // Initializing the instruction memory with values
    integer i;
    initial begin
        instruction_in[0]  = 32'h10000293;
        instruction_in[1]  = 32'h00700313;
        instruction_in[2]  = 32'h00700393;
        instruction_in[3]  = 32'h0072a023;
        instruction_in[4]  = 32'h00600393;
        instruction_in[5]  = 32'h0072a223;
        instruction_in[6]  = 32'h00500393;
        instruction_in[7]  = 32'h0072a423;
        instruction_in[8]  = 32'h00400393;
        instruction_in[9]  = 32'h0072a623;
        instruction_in[10] = 32'h00300393;
        instruction_in[11] = 32'h0072a823;
        instruction_in[12] = 32'h00200393;
        instruction_in[13] = 32'h0072aa23;
        instruction_in[14] = 32'h00100393;
        instruction_in[15] = 32'h0072ac23;
        instruction_in[16] = 32'h00000e13;
        instruction_in[17] = 32'h00000e93;
        instruction_in[18] = 32'h000e0e93;
        instruction_in[19] = 32'h002e1f13;
        instruction_in[20] = 32'h005f0fb3;
        instruction_in[21] = 32'h000fa103;
        instruction_in[22] = 32'h002e9f13;
        instruction_in[23] = 32'h005f0ab3;
        instruction_in[24] = 32'h000aa183;
        instruction_in[25] = 32'h0021d663;
        instruction_in[26] = 32'h002aa023;
        instruction_in[27] = 32'h003fa023;
        instruction_in[28] = 32'h001e8e93;
        instruction_in[29] = 32'hfc6ecce3;
        instruction_in[30] = 32'h001e0e13;
        instruction_in[31] = 32'hfc6e46e3;
       
//        for(i = 0; i < 57; i = i + 1) begin
//            Inst_Memory[i * 4] = instruction_in[i][7:0];
//            Inst_Memory[i * 4 + 1] = instruction_in[i][15:8];
//            Inst_Memory[i * 4 + 2] = instruction_in[i][23:16];
//            Inst_Memory[i * 4 + 3] = instruction_in[i][31:24];
//        end
        for(i = 0; i < 32; i = i + 1) begin
            Inst_Memory[i * 4] = instruction_in[i][7:0];
            Inst_Memory[i * 4 + 1] = instruction_in[i][15:8];
            Inst_Memory[i * 4 + 2] = instruction_in[i][23:16];
            Inst_Memory[i * 4 + 3] = instruction_in[i][31:24];
        end
       
    end
   
   
    // Read 4 consecutive bytes starting from Instr_Addr to form a 32-bit instruction
    assign Instruction[7:0] = Inst_Memory[Instr_Addr];        // Lower byte
    assign Instruction[15:8] = Inst_Memory[Instr_Addr + 1];   // Second byte
    assign Instruction[23:16] = Inst_Memory[Instr_Addr + 2];  // Third byte
    assign Instruction[31:24] = Inst_Memory[Instr_Addr + 3];  // Upper byte
   
endmodule