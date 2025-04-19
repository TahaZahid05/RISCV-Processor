`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:20:15 PM
// Design Name: 
// Module Name: zero
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


module zero(
    input [63:0] a,
    input [63:0] b,
    input [3:0] ALU00p,
    output [63:0] result,
    output zero_out
);

assign result = ALU00p[1] ? (ALU00p[0] == 0 ? (ALU00p[2] == 0 ? a+b : a-b) : 0) : (ALU00p[0] ? a|b : (ALU00p[3] ? -a&-b : a&b));

assign zero_out = result == 0 ? 1 : 0;

endmodule