`timescale 1ns / 1ps

module ALU_Control_tb();

reg [1:0] ALUOp;
reg [3:0] Funct;
wire [3:0] Operation;

ALU_Control a1(ALUOp, Funct, Operation);


initial
begin

ALUOp = 2'b00;

#50 ALUOp = 2'b01;

#50 ALUOp = 2'b10;

Funct[3:0] = 4'b0000;

#50 Funct[3:0] = 4'b1000;
#50 Funct[3:0] = 4'b0111;
#50 Funct[3:0] = 4'b0110;

end

endmodule
