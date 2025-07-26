`timescale 1ns / 1ps
 
// Create Date: 04/02/2025 11:04:34 AM
// File Name: inc16.v
// Description: Behavioral implementation of a 16-bit incrementor
//              Adds 1 to the 16-bit input value and produces the incremented result.
// Inputs: in   - 16-bit input value
// Outputs: out  - 16-bit output (input + 1)
// Author: Rishti 
// Notes: Simple increment operation done using '+' operator

module inc16(
    input wire [15:0] in,
    output reg [15:0] out
    );
    
    always @(*) begin
        out = 16'b1 + in; // Increment input by 1
    end
endmodule
