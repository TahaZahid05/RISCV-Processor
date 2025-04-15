module RegisterFile_tb ();

    reg [63:0] WriteData;
    reg [4:0] RS1;
    reg [4:0] RS2;
    reg [4:0] RD;
    reg RegWrite, clk, reset;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;

    registerFile regFile (
        WriteData,
        RS1,
        RS2,
        RD,
        RegWrite,
        clk,
        reset,
        ReadData1,
        ReadData2
    );

    initial begin
        clk = 0;
        RegWrite = 0;
        reset = 1;

        // add x20, x10, x20
        RS1 = 10;             // ReadData1 reads value of register 10
        RS2 = 20;             // ReadData2 reads value of register 20
        WriteData = 64'd35;   // Arbitrary value to write
        RD = 20;              // Write to register 20
        #10 reset = 0;
        #10 RegWrite = 1;     // Enable writing
    end

    always #5 clk = ~clk;

endmodule
