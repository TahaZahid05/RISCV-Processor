module Data_Memory_tb();

    reg [63:0] Mem_addr;
    reg [63:0] Write_data;
    reg clk;
    reg MemWrite;
    reg MemRead;
    wire [63:0] Read_Data;

    Data_Memory dl(Mem_addr, Write_data, clk, MemWrite, MemRead, Read_Data);

    initial begin
        clk = 1;
        MemWrite = 1;
        MemRead = 1;
        Mem_addr = 10;
        Write_data = 800;

        #200
        Write_data = 500;

        #100
        Write_data = 1000;
    end

    always
        #100
        clk = ~clk;

endmodule