module task2_tb();

reg clk;
reg reset;

RISC_V_Processor a1(clk, reset);

initial
begin
clk = 1;
reset = 1;
#1 reset = 0;
end

always begin
    #5 clk = ~clk;
end




endmodule