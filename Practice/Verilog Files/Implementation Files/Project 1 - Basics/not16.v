`timescale 1ns / 1ps 
// Create Date: 03/26/2025 09:09:15 AM
// File: not16.v
// Description: Behavioral description of a 16-bit not gate
//              Performs bitise inversion on each bit of a 16-bit input
// Input: in - 16-bit input
// Output: out - 16-bit output (bitwise complement of input a)
// Author: Rishti
// Notes: Uses a for loop or bitwise NOT operator for inversion.

module not16(
    input [15:0] in,
    output reg [15:0] out
    
    );
    
    integer i; // Loop variable for iterating through bits
    
    always @(*) begin
        // Iterate through each bit and perform NOT operation
        for (i=0; i<16; i=i+1)begin
            if (in[i] == 1'b1)
                out[i] = 1'b0;
            else
                out[i] = 1'b1;
        end        
    end
endmodule
