`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:11:06 PM
// Design Name: 
// Module Name: ALU_1_bit_tb
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


module ALU_1_bit_tb();
    reg a;
    reg b;
    reg CarryIn;
    reg [3:0] ALUOp;
    wire Result;
    wire CarryOut;

    ALU_1_bit s1(a, b, CarryIn, ALUOp, Result, CarryOut);

    initial
    begin
        // Add
        a = 1'b1;
        b = 1'b1;
        CarryIn = 1'b0;
        ALUOp = 4'b0010;
        
        // Subtract
        #100 a = 1'b1;
        b = 1'b1;
        CarryIn = 1'b1;
        ALUOp = 4'b0110;
        
        // OR
        #100 a = 1'b1;
        b = 1'b1;
        CarryIn = 1'b0;
        ALUOp = 4'b0001;
        
        // AND
        #100 a = 1'b1;
        b = 1'b1;
        CarryIn = 1'b0;
        ALUOp = 4'b0000;
        
        // NOR
        #100 a = 1'b1;
        b = 1'b1;
        CarryIn = 1'b0;
        ALUOp = 4'b1100;
    end
endmodule
