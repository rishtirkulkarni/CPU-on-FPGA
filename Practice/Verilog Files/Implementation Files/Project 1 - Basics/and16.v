`timescale 1ns / 1ps
// Create Date: 03/24/2025 05:15:48 PM
// File: and_gate.v
// Description: Behavioral implementation of a 16-bit AND gate.
//              Performs bitwise AND operation across each bit.
// Inputs:
//    a, b   - 16-bit inputs
// Outputs:
//    y      - 16-bit output where each bit is 1 only if both inputs' bits are 1
// Created by Rishti
// Notes: Uses a for loop to implement bitwise AND across all 16 bits.

module and16(
    input wire [15:0] a,
    input wire [15:0] b,
    output reg [15:0] y
    );
    
    integer i; // Loop variable for iterating through bits
    
    always @(*) begin
        // Iterate through each bit and perform AND operation
        for (i=0; i<16; i=i+1) begin 
            if (a[i] == 1'b1 && b[i] == 1'b1)
                y[i] = 1'b1; // Set bit if both inputs are 1
            else
                y[i] = 1'b0; // Otherwise, clears bit
        end
    end
endmodule
