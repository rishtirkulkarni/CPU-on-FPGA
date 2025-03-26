`timescale 1ns / 1ps 
// Create Date: 03/26/2025 06:32:24 PM
// Design Name: 16 Bit Mux (2 to1)
// Module Name: mux16
// Description: Created by Rishti 

module mux16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire sel,
    output reg [15:0] out
    );
    
    always @(*) begin
        if (sel == 1'b0)
            out = a;
        else 
            out = b;
    end
endmodule
