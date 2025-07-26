`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 07:06:50 PM
// File Name: add16.v
// Description: Behavioral implementation of a 16-bit ripple-carry adder.
//              Adds two 16-bit numbers with an input carry and produces a sum and carry-out.
// Inputs:
//    a, b   - 16-bit inputs
//    c_in   - Carry-in input
// Outputs:
//    sum    - 16-bit sum output
//    c_out  - Final carry-out after the addition
// Author: Rishti 
// Notes: Implements addition bit by bit using a ripple-carry approach.

module add16(
    input wire [15:0] a, wire [15:0] b, wire c_in,
    output reg [15:0] sum, reg c_out
    );
    
    reg carry;   // Temporary carry for intermediate stages
    integer i;   // Loop variable
    

    always @(*) begin
        carry = c_in; // Initialize carry
        for (i = 0; i < 16; i = i + 1) begin
             sum[i]  = a[i] ^ b[i] ^ carry;  // Sum bit (XOR of inputs & carry)
             carry   = (a[i] & b[i]) | (a[i] & carry) | (b[i] & carry); // Next carry
        end
    
        c_out = carry; 
    end
    
    
endmodule
