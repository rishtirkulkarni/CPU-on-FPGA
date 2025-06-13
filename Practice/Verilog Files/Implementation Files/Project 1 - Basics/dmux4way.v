`timescale 1ns / 1ps
 
// Create Date: 04/26/2025 
// Rishti 
// Module Name: dmux4way

module demux4way(
    input in,
    input [1:0] sel,
    output reg a, b, c, d
);

always @(*) begin
    case (sel)
        2'b00: a = in;
        2'b01: b = in;
        2'b10: c = in;
        2'b11: d = in;
    endcase
end

endmodule
