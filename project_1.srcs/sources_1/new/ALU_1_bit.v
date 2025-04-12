`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:04:57 PM
// Design Name: 
// Module Name: ALU_1_bit
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


module ALU_1_bit(
    input a,
    input b,
    input CarryIn,
    input [3:0] ALUOp,
    output Result,
    output CarryOut
);

wire muxlout;
wire mux2out;
wire andgate;
wire orgate;
wire norgate;
wire adder;

assign muxlout = ALUOp[3] ? ~a : a;
assign mux2out = ALUOp[2] ? ~b : b;
assign andgate = muxlout & mux2out;
assign orgate = muxlout | mux2out;
assign norgate = ~a & ~b;
assign CarryOut = (a & CarryIn) | (b & CarryIn) | (a & b);
assign adder = muxlout + mux2out + CarryIn;
assign Result = ALUOp[1] ? (ALUOp[0] ? 0 : adder) : (ALUOp[0] ? orgate : (ALUOp[1] ? norgate : andgate));

endmodule
