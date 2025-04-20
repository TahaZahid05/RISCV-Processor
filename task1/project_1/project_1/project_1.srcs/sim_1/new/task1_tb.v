module task1_tb(); 

reg clk;
reg reset;
wire debug_write;

task1 a1(clk, reset, debug_write);

initial
begin
clk = 1;
reset = 1;
#2 reset = 0;
end

always begin 
    #5 clk = ~clk;
end 

endmodule