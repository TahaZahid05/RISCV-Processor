module task1_tb(); 

reg clk;
reg reset;

task1 a1(clk, reset);

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