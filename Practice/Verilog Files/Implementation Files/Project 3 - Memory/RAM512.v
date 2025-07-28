`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:26:37 PM
// File: RAM512.v
// Description: 512-word RAM module (16-bit each).
// Provides read and write access to 512 memory locations.
// Inputs:
//    in      - 16-bit data input
//    address - 9-bit address (selects one of 512 memory locations)
//    load    - Write enable (when high, writes 'in' to memory[address])
//    clk     - Clock input
// Outputs:
//    out     - 16-bit data output (contents of memory[address])
// Author: Rishti
// Notes: 
// - Write occurs on the rising edge of the clock when load=1.
// - Read is asynchronous (output reflects memory[address] continuously).

module RAM512(
    input wire [15:0] in,
    input wire [8:0] address,
    input wire clk,
    input wire load,
    output reg [15:0] out
    );
    
    reg [15:0] memory [0:512]; // 512 locations of 16 bits each (fixed upper bound)

    // Write: synchronous on clock edge
    always@(posedge clk) begin
        if(load) begin
         memory[address] <= in; 
        end
    end

    // Read: asynchronous (always reflect current value)
    always@(*)begin
        out = memory[address];
    end
endmodule
