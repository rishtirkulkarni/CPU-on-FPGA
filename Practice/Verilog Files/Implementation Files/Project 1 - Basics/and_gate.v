`timescale 1ns / 1ps
// Create Date: 03/24/2025 05:15:48 PM
// File: and_gate.v
// Description: Behavioral implementation of a 1-bit AND gate.
// Inputs:
//    a, b   - Single-bit inputs
// Outputs:
//    y      - Output (1 if both inputs are high)
// Created by Rishti



module and_gate(
    input wire a,
    input wire b,
    output reg y
    );
    
    always @(*) begin
        if (a == 1'b1 && b == 1'b1) //Conditional statement can also be replaced by '&' operator.
            y = 1'b1;
        else 
            y = 1'b0;
    end
endmodule
