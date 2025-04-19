`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:24:13 PM
// Design Name: 
// Module Name: zeroTb
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


module zeroTb();

    reg [63:0] a;

    reg [63:0] b;

    reg [3:0] ALUOp;

    wire [63:0] result;

    wire zero_out;

    exercise z1(a,b,ALUOp,result,zero_out);

    initial

    begin

    a = 64'd5;

    b = 64'd3;

    ALUOp = 4'b0010;

    #100 a = 64'd5;

    b = 64'd3;

    ALUOp = 4'b0001;

    #100 a = 64'd5;

    b = 64'd3;

    ALUOp = 4'b0110;

    #100 a = 64'd5;

    b = 64'd3;

    ALUOp = 4'b1100;

    #100 a = 64'd5;

    b = 64'd3;

    ALUOp = 4'b0000;
    
    end
    endmodule;
