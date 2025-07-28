`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:40:22 PM
// File: RAM4K.v
// Description: 4K-word RAM module (16-bit each).
// Provides read and write access to 4096 memory locations.
// Inputs:
//    in      - 16-bit data input
//    address - 12-bit address (selects one of 4096 memory locations)
//    load    - Write enable (when high, writes 'in' to memory[address])
//    clk     - Clock input
// Outputs:
//    out     - 16-bit data output (contents of memory[address])
// Author: Rishti
// Notes: 
// - Write occurs on the rising edge of the clock when load=1.
// - Read is asynchronous (output reflects memory[address] continuously).

module RAM4k(
    input wire [15:0] in,
    input wire [11:0] address,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
 
    // 4096 locations of 16 bits each
    reg [15:0] memory [0:4095];

    // Write: synchronous on clock edge
    always@(posedge clk) begin
        if(load) begin
            memory[address] <= in;
        end
    end
 
    // Read: asynchronous (always reflect current value)
    always@(*) begin
        out = memory[address];
    end
    
endmodule
