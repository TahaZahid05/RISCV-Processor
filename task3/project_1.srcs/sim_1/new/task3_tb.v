module task3_tb();

reg clk;
reg reset;
wire [63:0] debug_MEMWB_writeData;

task_3 a1(clk, reset, debug_MEMWB_writeData);

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