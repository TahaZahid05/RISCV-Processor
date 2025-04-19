`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:13:43 PM
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(
    input [7:0] a,
    input [7:0] b,
    input [3:0] ALUOp,
    input CarryIn,
    output [7:0] result
);
  
    wire CarryOut1, CarryOut2, CarryOut3, CarryOut4;
    wire CarryOut5, CarryOut6, CarryOut7, CarryOut8;
    
    
    ALU_1_bit alu0 (.a(a[0]), .b(b[0]), .CarryIn(CarryIn),   .ALUOp(ALUOp), .Result(result[0]), .CarryOut(CarryOut1));
    ALU_1_bit alu1 (.a(a[1]), .b(b[1]), .CarryIn(CarryOut1), .ALUOp(ALUOp), .Result(result[1]), .CarryOut(CarryOut2));
    ALU_1_bit alu2 (.a(a[2]), .b(b[2]), .CarryIn(CarryOut2), .ALUOp(ALUOp), .Result(result[2]), .CarryOut(CarryOut3));
    ALU_1_bit alu3 (.a(a[3]), .b(b[3]), .CarryIn(CarryOut3), .ALUOp(ALUOp), .Result(result[3]), .CarryOut(CarryOut4));
    ALU_1_bit alu4 (.a(a[4]), .b(b[4]), .CarryIn(CarryOut4), .ALUOp(ALUOp), .Result(result[4]), .CarryOut(CarryOut5));
    ALU_1_bit alu5 (.a(a[5]), .b(b[5]), .CarryIn(CarryOut5), .ALUOp(ALUOp), .Result(result[5]), .CarryOut(CarryOut6));
    ALU_1_bit alu6 (.a(a[6]), .b(b[6]), .CarryIn(CarryOut6), .ALUOp(ALUOp), .Result(result[6]), .CarryOut(CarryOut7));
    ALU_1_bit alu7 (.a(a[7]), .b(b[7]), .CarryIn(CarryOut7), .ALUOp(ALUOp), .Result(result[7]), .CarryOut(CarryOut8));
endmodule
