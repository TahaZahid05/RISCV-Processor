`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 08:33:43 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk,                
    input [63:0] PC_addr,     
    input [31:0] Inst,     
    output reg [63:0] PC_addr_store,  
    output reg [31:0] Inst_store 
);

always @(posedge clk)
begin
    PC_addr_store <= PC_addr;
    Inst_store <= Inst;
end

//assign PC_addr_store = PC_addr;
//assign Inst_store = Inst;

endmodule
