`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 06:23:05 PM
// Rishti  
// Module Name: full_adder



module full_adder(
    input wire a, b, c_in,
    output reg sum, c_out
    );
    
    always @(*) begin
        if ((a + b + c_in) == 1 || (a + b + c_in) == 3)
            sum = 1;
        else
            sum = 0;
    end
   
    always @(*) begin
        if ((a & b) || (a & c_in) || (b & c_in))
            c_out = 1;
        else 
            c_out = 0;
    end

endmodule
