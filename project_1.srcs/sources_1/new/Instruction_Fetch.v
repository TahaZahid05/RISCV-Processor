`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 09:51:04 PM
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch(
    input clk,
    input reset,
    output [31:0] Instruction
    );
    
    wire [63:0] PC_In;
    wire [63:0] PC_Out;
    
    Program_Counter a1(clk,reset,PC_In,PC_Out);
    Instruction_Memory c1(PC_Out, Instruction);
    adder b1(PC_Out, 4, PC_In);
    
endmodule
