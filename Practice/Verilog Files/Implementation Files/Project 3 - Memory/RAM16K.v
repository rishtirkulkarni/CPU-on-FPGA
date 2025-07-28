`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 06:13:51 PM
// File: RAM16K.v
// Description: 16K-word RAM module (16-bit each).
// Provides read and write access to 16384 memory locations.
// Inputs:
//    in      - 16-bit data input
//    address - 14-bit address (selects one of 16384 memory locations)
//    load    - Write enable (when high, writes 'in' to memory[address])
//    clk     - Clock input
// Outputs:
//    out     - 16-bit data output (contents of memory[address])
// Author: Rishti
// Notes: 
// - Write occurs on the rising edge of the clock when load=1.
// - Read is asynchronous (output reflects memory[address] continuously).

module RAM16K(
    input wire [15:0] in,
    output reg [15:0] out,
    input wire [13:0] address,
    input wire clk,
    input wire load
    );
    
    // 16384 locations of 16 bits each
    reg [15:0] memory [0:16383];
 
    // Write: synchronous on clock edge
    always@(posedge clk) begin
        if(load) begin
            memory[address]<= in;
        end
    end
 
    // Read: asynchronous (always reflect current value)
    always@(*)begin
        out = memory[address];
    end
    
endmodule
