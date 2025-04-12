`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:00:46 PM
// Design Name: 
// Module Name: imm_data_gen_tb
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


module imm_dat_gen_tb(
    );
    reg [31:0] inst;
    wire [63:0] imm;

    imm_dat_gen img1(.inst(inst), .imm(imm));

    initial begin
        inst = 32'b10000000000100010000010100000011;
        #100 inst = 32'b00000000000100010011010100100011;
        #100 inst = 32'b00000000000100010000010101100011;
    end
endmodule

