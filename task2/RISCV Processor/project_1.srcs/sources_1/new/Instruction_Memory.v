//`timescale 1ns / 1ps

//module Instruction_Memory(
//    input [63:0] Inst_Address,
//    output [31:0] Instruction
//);

//reg [7:0] Inst_Memory [15:0];

//initial begin
//    Inst_Memory[15] = 8'b00001110;
//    Inst_Memory[14] = 8'b10010101;
//    Inst_Memory[13] = 8'b00111000;
//    Inst_Memory[12] = 8'b00100011;
//    Inst_Memory[11] = 8'b00000000;
//    Inst_Memory[10] = 8'b00010100;
//    Inst_Memory[9] = 8'b10000100;
//    Inst_Memory[8] = 8'b10010011;
//    Inst_Memory[7] = 8'b00000000;
//    Inst_Memory[6] = 8'b10011010;
//    Inst_Memory[5] = 8'b10000100;
//    Inst_Memory[4] = 8'b10110011;
//    Inst_Memory[3] = 8'b00001111;
//    Inst_Memory[2] = 8'b00000101;
//    Inst_Memory[1] = 8'b00110100;
//    Inst_Memory[0] = 8'b10000011;
//end

//assign Instruction[7:0] = Inst_Memory[Inst_Address];
//assign Instruction[15:8] = Inst_Memory[Inst_Address+1];
//assign Instruction[23:16] = Inst_Memory[Inst_Address+2];
//assign Instruction[31:24] = Inst_Memory[Inst_Address+3];

//endmodule

`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Instr_Addr,    // 64-bit instruction address input
    output [31:0] Instruction   // 32-bit instruction output
    );
   
    // Declaring a memory array with 16 entries of 8-bit width (bytes)
    reg [7:0] Inst_Memory[143:0];  
    reg [31:0] instruction_in[35:0];
   
   
   
    // Initializing the instruction memory with values
    integer i;
    initial begin
          instruction_in[0] = 32'h10000293; //testing 
//        instruction_in[0] = 32'h10000293;
//        instruction_in[1] = 32'h00700313;
//        instruction_in[2] = 32'h00700393;
//        instruction_in[3] = 32'h0072a023;
//        instruction_in[4] = 32'h00600393;
//        instruction_in[5] = 32'h0072a223;
//        instruction_in[6] = 32'h00500393;
//        instruction_in[7] = 32'h0072a423;
//        instruction_in[8] = 32'h00400393;
//        instruction_in[9] = 32'h0072a623;
//        instruction_in[10] = 32'h00300393;
//        instruction_in[11] = 32'h0072a823;
//        instruction_in[12] = 32'h00200393;
//        instruction_in[13] = 32'h0072aa23;
//        instruction_in[14] = 32'h00100393;
//        instruction_in[15] = 32'h0072ac23;
//        instruction_in[16] = 32'h00000e13;
//        instruction_in[17] = 32'h00000e93;
//        instruction_in[18] = 32'h000e0e93;
//        instruction_in[19] = 32'h002e1f13;
//        instruction_in[20] = 32'h005f0fb3;
//        instruction_in[21] = 32'h000fa103;
//        instruction_in[22] = 32'h002e9f13;
//        instruction_in[23] = 32'h005f0ab3;
//        instruction_in[24] = 32'h000aa183;
//        instruction_in[25] = 32'h0021c463;
//        instruction_in[26] = 32'h00005463;
//        instruction_in[27] = 32'h00000c63;
//        instruction_in[28] = 32'h001e8e93;
//        instruction_in[29] = 32'hfc6ecce3;
//        instruction_in[30] = 32'h001e0e13;
//        instruction_in[31] = 32'hfc6e46e3;
//        instruction_in[32] = 32'h00005863;
//        instruction_in[33] = 32'h002aa023;
//        instruction_in[34] = 32'h003fa023;
//        instruction_in[35] = 32'hfe0002e3;
        
           
       
        for(i = 0; i < 36; i = i + 1) begin
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