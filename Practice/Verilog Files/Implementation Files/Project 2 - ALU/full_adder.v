`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 06:23:05 PM
// Rishti  
// Module Name: full_adder



module full_adder(
    input wire a, b, c_in,
    output reg sum, c_out
    );
    
    always @(*) begin
       {c_out, sum} = a + b + c_in;
    end

endmodule
