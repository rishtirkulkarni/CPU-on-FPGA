`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 07:06:50 PM
// Rishti 
// Module Name: add16 - 16 bit adder



module add16(
    input wire [15:0] a, wire [15:0] b, wire c_in,
    output reg [15:0] sum, reg c_out
    );
    
    reg carry;
    integer i; 

    always @(*) begin
        carry = c_in; 
        for (i = 0; i < 16; i = i + 1) begin
            if ((a[i] ^ b[i] ^ carry) == 1)
                sum[i] = 1;
            else
                sum[i] = 0;
    
            if ((a[i] & b[i]) || (a[i] & carry) || (b[i] & carry))
                carry = 1;
            else
                carry = 0;
        end
    
        c_out = carry; 
    end
    
    
endmodule
