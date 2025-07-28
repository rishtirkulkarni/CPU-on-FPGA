`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:10:09 PM
// File: RAM64.v
// Description: 64-word RAM module (16-bit each).
// Provides read and write access to 64 memory locations.
// Inputs:
//    in      - 16-bit data input
//    address - 6-bit address (selects one of 64 memory locations)
//    load    - Write enable (when high, writes 'in' to memory[address])
//    clk     - Clock input
// Outputs:
//    out     - 16-bit data output (contents of memory[address])
// Author: Rishti
// Notes: 
// - Write occurs on the rising edge of the clock when load=1.
// - Read is asynchronous (output reflects memory[address] continuously).

module RAM64(
    input wire [15:0] in,
    input wire [5:0] address,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
    
    reg [15:0] memory [0:63]; // 64 locations of 16 bits each

    // Write: synchronous on clock edge
    always@(posedge clk) begin
        if(load) begin
         memory[address] <= in; 
        end
    end

    // Read: asynchronous (always reflect current value)
    always@ (*) begin
        out = memory[address];
    end
endmodule
