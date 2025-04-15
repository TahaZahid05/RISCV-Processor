module Top_tb();

    reg [31:0] instruction;
    reg clk;
    reg reset;
    reg [63:0] WriteData;
    reg regWrite;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;

    Top a1(instruction, clk, reset, WriteData, regWrite, ReadData1, ReadData2);

    initial begin
        clk = 0;
        reset = 1;
        regWrite = 0;
        WriteData = 64'd35;
        instruction = 64'd10;

        #10 reset = 0;
        regWrite = 1;
        WriteData = 64'd35;
        instruction = 64'd10;

        #10 reset = 1;
        regWrite = 1;
        WriteData = 64'd35;
        instruction = 64'd10;

        #10 reset = 0;
        regWrite = 0;
        WriteData = 64'd35;
        instruction = 64'd10;
    end

    always
        #5 clk = ~clk;

endmodule
