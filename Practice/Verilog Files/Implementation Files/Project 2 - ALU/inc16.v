`timescale 1ns / 1ps
 
// Create Date: 04/02/2025 11:04:34 AM
// Rishti 
// Module Name: inc16 - 16 bit incrementer



module inc16(
    input wire [15:0] in,
    output reg [15:0] out
    );
    
    always @(*) begin
        out = 16'b1 + in;
    end
endmodule
