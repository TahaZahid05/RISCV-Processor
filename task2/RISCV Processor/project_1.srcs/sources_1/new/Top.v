`timescale 1ns / 1ps

module Top(
    input [31:0] instruction,
    input clk,
    input reset,
    input [63:0] WriteData,
    input regWrite,
    output wire [63:0] ReadData1,
    output wire [63:0] ReadData2
);

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    // Instruction decoder instantiation
    inst_parser a1(
        instruction,
        opcode,
        rd,
        funct3,
        rs1,
        rs2,
        funct7
    );

    // Register file instantiation
    RegisterFile b1(
        .WriteData(WriteData),
        .RS1(rs1),
        .RS2(rs2),
        .RD(rd),
        .RegWrite(regWrite),
        .clk(clk),
        .reset(reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

endmodule
