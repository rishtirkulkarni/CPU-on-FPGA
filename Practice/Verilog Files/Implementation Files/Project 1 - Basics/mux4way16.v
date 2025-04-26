`timescale 1ns / 1ps

// Create Date: 04/26/2025 
// Rishti 
// Module Name: mux4way16



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