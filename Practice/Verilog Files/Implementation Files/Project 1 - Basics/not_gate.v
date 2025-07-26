`timescale 1ns / 1ps

// Create Date: 03/24/2025 04:41:56 PM
// File: not_gate.v
// Description: Behavioral implementation of a 1-bit NOT gate.
// Inputs:
//    a   - Single-bit input
// Outputs:
//    y   - Output (logical inversion of input)
// Created by Rishti
 

module not_gate(
    input wire a,
    output reg y
    );
    
     always @(*) begin
        if (a == 1'b1)
            y = 1'b0;
        else
            y = 1'b1;
     end
endmodule
