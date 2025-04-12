`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 04:17:14 PM
// Design Name: 
// Module Name: testbench_ALU_64_bit
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


module testbench_ALU_64_bit();
    reg [63:0] a; 
    reg [63:0] b; 
    reg Cin;
    reg [3:0] ALUOp;
    wire Cout, ZERO;
    wire [63:0] Result;
    
    ALU_64_bit Test(.a(a),.b(b),.Cin(Cin),.ALUOp(ALUOp),.Cout(Cout),.ZERO(ZERO),.Result(Result));
    
    initial begin
        // Test AND
        a = 64'b0; b = 64'b00101111; Cin = 0; ALUOp = 4'b0000;
        #10;
        
        // Test OR
        a = 64'b00101111; b = 64'b00001001; Cin = 0; ALUOp = 4'b0001;
        #10;
        
        // Test ADD
        a = 64'b00101111;; b = 64'b00001001; Cin = 0; ALUOp = 4'b0010;
        #10;
        
        // Test SUB
        a = 64'b00101111;; b = 64'b00001001; Cin = 1; ALUOp = 4'b0011;
        #10;
        
        // Test XOR operation
        a = 64'b00101111; b = 64'b00001001; Cin = 0; ALUOp = 4'b0100;
        #10;
        
        $display("Result = %b, Cout = %b", Result, Cout);
        $finish;
    end
endmodule
