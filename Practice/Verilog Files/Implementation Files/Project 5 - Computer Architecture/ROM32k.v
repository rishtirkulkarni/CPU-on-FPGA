`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 02:52:00 PM
// Design Name: 
// Module Name: ROM32k
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


module ROM32k(
    input [14:0] address,
    input clk,
    output reg [15:0] out
    );
    
    reg [15:0] ROM [0:32767];
    
    always@(posedge clk)begin
        out <= ROM[address];
    end
    
endmodule
