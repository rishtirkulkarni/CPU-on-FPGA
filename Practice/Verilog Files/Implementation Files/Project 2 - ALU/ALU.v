`timescale 1ns / 1ps
 
// Create Date: 04/02/2025 11:29:05 AM
// File Name: ALU
// Description: 16-bit Arithmetic Logic Unit (ALU).
//              Performs computation on two 16-bit inputs based on control signals:
//                - Zeroing, negating inputs
//                - Choosing between addition and bitwise AND
//                - Optional negation of the result
// Also outputs flags for zero and negative results.
// Inputs:
//    x, y   - 16-bit operands
//    zx     - Zero the x input if set
//    nx     - Negate the x input if set
//    zy     - Zero the y input if set
//    ny     - Negate the y input if set
//    f      - Function select (1: add, 0: AND)
//    no     - Negate the final output if set
// Outputs:
//    out    - 16-bit ALU result
//    zr     - Zero flag (1 if result is 0)
//    ng     - Negative flag (1 if result is negative)
// Author: Rishti

module ALU(
 input wire [15:0] x, y
    input wire zx, nx, zy, ny, f, no
    output reg [15:0] out,
    output reg zr, ng
    );
    
 reg [15:0] x_temp,y_temp; // Intermediate values after transformations
    
    always @(*)begin
      // Preprocess x
        x_temp = (zx) ? 16'b0 : x;      // Zero x if zx set
        if (nx) x_temp = ~x_temp;       // Negate x if nx set
        
        // Preprocess y
        y_temp = (zy) ? 16'b0 : y;      // Zero y if zy set
        if (ny) y_temp = ~y_temp;       // Negate y if ny set
        
        // Main operation
        out = (f) ? (x_temp + y_temp)   // If f=1, perform addition
                  : (x_temp & y_temp);  // If f=0, perform bitwise AND
        
        // Post-process output
        if (no) out = ~out;             // Negate final output if no set
        
        // Set flags
        zr = (out == 16'b0);            // Zero flag
        ng = out[15];                   // Negative flag (MSB)       
    end
    
    
endmodule
