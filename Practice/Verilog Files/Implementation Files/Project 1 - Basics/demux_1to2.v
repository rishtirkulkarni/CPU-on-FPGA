`timescale 1ns / 1ps
 
// Create Date: 03/25/2025 08:32:06 PM
// File: demux-1to2.v
// Description: Behavioral description of 1-to-2 demultiplexer
//              Routes a single input to two different outputs based on a 1-bit select signal
// Input: in (1-bit)
//        sel (1-bit select line)
// Outputs: a,b - 1-bit outputs (Only active at a time)
// Created by Rishti



module demux_1to2(
    input wire in,
    input wire sel,
    output reg a,
    output reg b
    );
    
    always @(*) begin
        if (sel == 1'b0) begin
            a = in;         // Route input to y0
            b = 1'b0;      // y1 is set to 0
        end
        else begin
            a = 1'b0;      // y0 is set to 0
            b = in;         // Route input to y1
        end
    end
endmodule
