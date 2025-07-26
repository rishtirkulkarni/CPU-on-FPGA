`timescale 1ns / 1ps 
// Create Date: 03/26/2025 06:32:24 PM
// File: mux16.v
// Description: Behavioral description 16-bit 2-to-1 Multiplexer
//              Selects between 2 different 16-bit inputs to route to the output line based on a 1-bit select line
// Inputs: a, b - 16-bit inputs
//         sel - 1-bit select line
// Outputs: out - 16-bit output line that gets only one of the two inputs at a time
// Author: Rishti 
// Notes: Uses if-else statement to implement the multiplexer functionality

module mux16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire sel,
    output reg [15:0] out
    );
    
    always @(*) begin
        if (sel == 1'b0)
            out = a;
        else 
            out = b;
    end
endmodule
