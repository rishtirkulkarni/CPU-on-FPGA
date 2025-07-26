`timescale 1ns / 1ps

// Create Date: 04/26/2025 
// File Name: mux4way16
// Description: Behavioral implementation of 16-bit 4-to-1 Multiplexer 
//              Selects between 4 different 16-bit inputs to route to the output line based on a 2-bit select line
// Inputs: a, b, c, d - 16-bit inputs
//         sel - 2-bit select line
// Outputs: out - 16-bit output that gets only one of the 4 inputs at a time
// Author: Rishti 
// Notes: Case statement has been used to select different inputs to route to the output line
//        based on the 2-bit select line

module mux4way16(
    input [15:0] a, b, c, d,
    input [1:0] sel,
    output reg [15:0] out
);

always @(*) begin
    case (sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        2'b11: out = d;
    endcase
end

endmodule
