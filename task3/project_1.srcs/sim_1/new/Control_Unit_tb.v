`timescale 1ns / 1ps

module Control_Unit_tb();

reg [6:0] Opcode;
wire Branch;
wire MemRead;
wire MemToReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

Control_Unit a1(Opcode, Branch, MemRead,MemToReg,ALUOp, MemWrite, ALUSrc, RegWrite);

initial 
begin

Opcode = 7'b0110011;

#50 Opcode = 7'b0000011;

#50 Opcode = 7'b0100011;

#50 Opcode = 7'b1100011;

end

endmodule
