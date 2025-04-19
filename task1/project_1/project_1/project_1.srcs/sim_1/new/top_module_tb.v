`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:16:34 PM
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb();

    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] ALUOp;
    reg CarryIn;
    wire [7:0] result;

    top_module al(a,b,ALUOp,CarryIn,result);

 initial
 begin
   a = 8'd4;
   b = 8'd5;
   CarryIn = 1'b0;
   ALUOp = 4'b0010;

 end

 endmodule
