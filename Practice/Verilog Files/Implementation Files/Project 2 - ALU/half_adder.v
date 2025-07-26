`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 05:05:19 PM
// Module Name: half_adder.v
// Description: Behavioral description of a 1-bit half adder
//              Adds 2 inputs, produces a sum and carry outpts
// Inputs: a, b - 1-bit inputs
// Outputs: sum - 1-bit sum output
//          c_out - 1-bit carry output
// Author: Rishti
// Notes: Logical operators and procedural assignments have been used to implement the half adder functionaity

module half_adder(
    input wire a,
    input wire b,
    output reg sum,
    output reg c_out
    );
    
    always @(*)begin
        sum = a ^ b;     // Performs EXOR of inputs to produce sum bit
        c_out = a & b;   // Performs AND of inputs to produce carry output bit
    end
endmodule
