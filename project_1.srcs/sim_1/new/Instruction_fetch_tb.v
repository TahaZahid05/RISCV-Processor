module Instruction_fetch_tb();


reg clk;
reg reset;
wire [31:0] Instruction;

Instruction_Fetch d1(clk,reset,Instruction);


initial 
begin

clk = 0;
reset = 1;
#100 reset = 0;

end

always
#10 clk = ~clk;

endmodule