`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:31:15 PM
// Rishti 
// 16 bit register

module register(
    input wire [15:0] in,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
    
    always@(posedge clk)begin
        if(load)
            out <= in;
    end
    
endmodule
