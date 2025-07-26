`timescale 1ns / 1ps 
// Create Date: 03/25/2025 08:02:53 PM
// File: xor_gate.v
// Description: Behavioral implementation of a 1-bit XOR gate.
// Inputs:
//    a, b   - Single-bit inputs
// Outputs:
//    y      - Output (1 if exactly one input is high)
// Created by Rishti


module xor_gate(
    input wire a,
    input wire b,
    output reg y
    );
    
    always @(*) begin
        if (a == 1'b1 && b == 1'b0)
            y = 1'b1;
        else if(a == 1'b0 && b == 1'b1)
            y = 1'b1;
       else 
            y = 1'b0;
    end
endmodule
