`timescale 1ns / 1ps

// Create Date: 03/25/2025 08:18:01 PM
// File: mux_2to1.v
// Description: Behavioral description of a 2-to-1 Multiplexer
//              Selects between 2 1-bit inputs to route to the output line based on a 1-bit select line
// Inputs: a, b - 1-bit inputs
//         sel - 1-bit select line
// Outputs: y - 1-bit output line that gets one of the inputs at a time
// Author: Rishti

module mux_2to1(
    input wire a,
    input wire b,
    input wire sel,
    output reg y
    );
    
    always @(*) begin
        if (sel == 1'b0) // If-else statements used to select different inputs
            y = a;       // based on different values of the select line
        else 
            y = b;
    end
endmodule
