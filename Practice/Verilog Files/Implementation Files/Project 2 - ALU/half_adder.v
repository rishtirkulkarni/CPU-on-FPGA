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
        if (a == b)begin
            sum = 0;
            c_out = (a&b);
        end else begin
            sum = 1;
            c_out = 0;
        end     
    end
endmodule
