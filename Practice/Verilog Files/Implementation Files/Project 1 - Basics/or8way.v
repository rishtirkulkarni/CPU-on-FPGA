`timescale 1ns / 1ps
 
// Create Date: 04/26/2025 
// File Name: or8way.v
// Description: Dataflow implementation of an 8-way OR gate.
//              Produces a high output if any of the 8 inputs are high.
// Inputs:
//    a, b, c, d, e, f, g, h - Single-bit inputs
// Outputs:
//    out - Single-bit output (1 if any input is high)
// Author: Rishti 
// Notes: Uses a single continuous assignment to perform OR across all inputs.

module or8way(
    input  a, b, c, d, e, f, g, h,  
    output out
    );
    
    assign out = a | b | c | d | e | f | g | h;
endmodule
