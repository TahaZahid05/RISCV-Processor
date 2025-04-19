`timescale 1ns / 1ps

module top_control_tb();

reg [6:0] Opcode;
reg [3:0] Funct;
wire Branch;
wire MemRead;
wire MemToReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [3:0] Operation;

top_control t1(Opcode, Funct, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Operation);

initial
begin

Opcode = 7'b0110011;
Funct[3:0] = 4'b0000;

#50 Funct[3:0] = 4'b1000;
#50 Funct[3:0] = 4'b0111;
#50 Funct[3:0] = 4'b0110;

#50 Opcode = 7'b0000011;
Funct[3:0] = 4'b0000;

#50 Funct[3:0] = 4'b1000;
#50 Funct[3:0] = 4'b0111;
#50 Funct[3:0] = 4'b0110;

#50 Opcode = 7'b0100011;
Funct[3:0] = 4'b0000;

#50 Funct[3:0] = 4'b1000;
#50 Funct[3:0] = 4'b0111;
#50 Funct[3:0] = 4'b0110;

#50 Opcode = 7'b1100011;
Funct[3:0] = 4'b0000;

#50 Funct[3:0] = 4'b1000;
#50 Funct[3:0] = 4'b0111;
#50 Funct[3:0] = 4'b0110;


end

endmodule
