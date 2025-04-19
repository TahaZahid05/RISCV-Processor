`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 09:55:39 PM
// Design Name: 
// Module Name: inst_parser_tb
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


module inst_parser_tb(
    );
    reg [31:0] inst;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [6:0] opcode;

    inst_parser ip1(.inst(inst), .opcode(opcode), .func3(func3), .rd(rd), .rs1(rs1), .rs2(rs2), .func7(func7));

    initial begin
        inst = 32'b00000000000100011010001010000011;
    end
endmodule

