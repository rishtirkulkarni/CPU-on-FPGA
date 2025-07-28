`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 04:36:10 PM
// File: RAM8.v
// Description: 8-word RAM module (16-bit each).
// Provides read and write access to 8 memory locations.
// Inputs:
//    in      - 16-bit data input
//    address - 3-bit address (selects one of 8 memory locations)
//    load    - Write enable (when high, writes 'in' to memory[address])
//    clk     - Clock input
// Outputs:
//    out     - 16-bit data output (contents of memory[address])
// Author: Rishti
// Notes: 
// - Write occurs on the rising edge of the clock when load=1.
// - Read is asynchronous (output reflects memory[address] continuously).

module RAM8(
    input wire [15:0] in,
    output reg [15:0] out,
    input wire [2:0] address,
    input wire load,
    input wire clk
    );
    
 reg [15:0] memory [0:7]; // 8 locations of 16 bits each

    // Write: synchronous on clock edge 
    always @(posedge clk)begin
        if(load) begin
            memory[address] <= in;
        end
    end

    // Read: asynchronous (always reflect current value)
    always@(*)begin
        out = memory[address];
    end
endmodule
