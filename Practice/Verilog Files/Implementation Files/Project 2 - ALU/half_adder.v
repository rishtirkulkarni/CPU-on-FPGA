`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 05:05:19 PM
// Rishti
// Module Name: half_adder



module half_adder(
    input wire a,
    input wire b,
    output reg sum,
    output reg c_out
    );
    
    always @(*)begin
        sum = a ^ b;
        c_out = a & b;
    end
endmodule
