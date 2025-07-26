`timescale 1ns / 1ps 
// Create Date: 03/24/2025 05:44:03 PM
// File: or_gate.v
// Description: Behavioral implementation of a 1-bit OR gate.
// Inputs:
//    a, b   - Single-bit inputs
// Outputs:
//    y      - Output (1 if at least one input is high)
// Created by Rishti


module or_gate(
    input wire a,
    input wire b,
    output reg y
    );
    
    always @(*) begin
        if (a == 1'b1 || b == 1'b1)
            y = 1'b1;
        else 
            y = 1'b0;
    end
    
endmodule
