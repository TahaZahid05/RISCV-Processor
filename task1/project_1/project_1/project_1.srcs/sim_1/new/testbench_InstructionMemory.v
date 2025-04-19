`timescale 1ns / 1ps

module testbench_InstructionMemory();

    reg [63:0] Inst_Address;
    wire [31:0] Instruction;

    Instruction_Memory im(Inst_Address, Instruction);

    initial begin
        Inst_Address = 0;
        #100
        Inst_Address = 4;
        #100
        Inst_Address = 8;
        #100
        Inst_Address = 12;
    end

endmodule