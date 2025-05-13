`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:12:23 PM
// Rishti 
// Program Counter

module pc(
    input wire [15:0] in,
    input wire reset,
    input wire load,
    input wire inc,
    input wire clk,
    output reg [15:0] out
    );
    
    always@(posedge clk)begin
        if(reset)
            out <= 16'b0000000000000000;
        else if(load)
            out <= in;
        else if(inc)
            out <= out + 1;
    end
    
endmodule
