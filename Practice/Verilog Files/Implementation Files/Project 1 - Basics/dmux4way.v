`timescale 1ns / 1ps
 
// Create Date: 04/26/2025 
// File: dmux4way.v
// Description: Behavioral description of a 1-to-4 demultiplexer
//              Routes a single 1-bit input to 4 different output lines based on 2 bit select lines
// Inputs: in (1-bit)
//         sel (2-bit select line)
// Outputs: a, b, c, d - 1-bit outputs (only one active at a time)
// Author: Rishti 
// Notes: Case statement is used to route the input to different output lines, based on the 2-bit select lines
module demux4way(
    input in,
    input [1:0] sel,
    output reg a, b, c, d
);

always @(*) begin
    case (sel)
        2'b00: begin a = in; b = 0; c = 0; d = 0; end
        2'b01: begin a = 0; b = in; c = 0; d = 0; end
        2'b10: begin a = 0; b = 0; c = in; d = 0; end
        2'b11: begin a = 0; b = 0; c = 0; d = in; end
    endcase
end

endmodule
