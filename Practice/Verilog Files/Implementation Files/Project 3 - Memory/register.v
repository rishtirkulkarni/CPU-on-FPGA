`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:31:15 PM
// File: register.v
// Description: 16-bit register with load control.
// Stores a 16-bit value on the rising edge of the clock when load is high.
// Inputs:
//    in    - 16-bit data input
//    load  - Load control (when high, captures 'in' on clock edge)
//    clk   - Clock input
// Outputs:
//    out   - 16-bit stored value
// Author: Rishti

module register(
    input wire [15:0] in,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
    
    always@(posedge clk)begin
        if(load)
            out <= in; // Capture input when load is high
            // Otherwise, retain previous value
    end
    
endmodule
