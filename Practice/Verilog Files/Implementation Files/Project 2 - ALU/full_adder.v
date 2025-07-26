`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 06:23:05 PM
// File Name: full_adder.v
// Description: Behavioral description of a simple 1-bit full adder
//              Adds 2 1-bit inputs along with the carry input (from previous additions) producing sum and carry output bits
// Inputs: a, b, c_in - 1-bit inputs
// Outputs: sum - 1-bit sum output
//          c_out - 1-bit carry output
// Author: Rishti  
// Notes: Uses the concatenation operator and '+' operator to calculate sum and c_out

module full_adder(
    input wire a, b, c_in,
    output reg sum, c_out
    );
    
    always @(*) begin
     // Add the three 1-bit inputs (a, b, c_in).
     // The result is 2 bits: the least significant bit becomes 'sum' and the most significant bit becomes 'c_out'.
     {c_out, sum} = a + b + c_in;
    end

endmodule
