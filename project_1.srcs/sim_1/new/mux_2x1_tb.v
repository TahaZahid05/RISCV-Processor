`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 09:51:38 PM
// Design Name: 
// Module Name: mux_2x1_tb
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


module mux_2x1_tb;

    reg [63:0] a;
    reg [63:0] b;
    reg sel;
    wire [63:0] data_out;

    mux_2x1 m1(.a(a), .b(b), .sel(sel), .data_out(data_out));

    initial begin
        a = 64'h21;
        b = 64'h32;

        sel = 0;
        #100 sel = 1;
    end

endmodule

