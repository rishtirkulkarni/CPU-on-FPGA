`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:23:30 PM
// File: bit.v
// Description: 1-bit register with load control.
// Stores a single bit on the rising edge of the clock when load is high.
// Inputs:
//    in    - Data input
//    load  - Load control (when high, captures 'in' on clock edge)
//    clk   - Clock input
// Outputs:
//    out   - Stored bit value
// Author: Rishti

module bit(
    input wire in,
    input wire load,
    input wire clk,
    output reg out
    );
    
    always@(posedge clk)begin
        if(load)
            out <= in; // Capture input when load is high
            // Otherwise, retain the previous value of out
    end
    
endmodule
