`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:12:23 PM
// File: pc.v
// Description: 16-bit Program Counter (PC).
// Supports reset, load, and increment operations.
// Inputs:
//    in     - 16-bit value to load into the PC
//    reset  - Synchronous reset (when high, clears PC to 0)
//    load   - Load control (when high, loads 'in' on clock edge)
//    inc    - Increment control (when high, increments PC by 1)
//    clk    - Clock input
// Outputs:
//    out    - Current PC value
// Author: Rishti

module pc(
    input wire [15:0] in,
    input wire reset,
    input wire load,
    input wire inc,
    input wire clk,
    output reg [15:0] out
    );
    
    always@(posedge clk)begin
        if(reset)
            out <= 16'b0;    // Reset PC to 0
        else if(load)
            out <= in;       // Load a new value into PC
        else if(inc)
            out <= out + 1;  // Increment PC by 1
    end
    
endmodule
