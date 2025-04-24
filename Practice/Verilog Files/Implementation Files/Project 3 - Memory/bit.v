`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 07:23:30 PM
// Rishti 
// 1 Bit register

module bit(
    input wire in,
    input wire load,
    input wire clk,
    output reg out
    );
    
    always@(posedge clk)begin
        if(load)
            out <= in;
    end
    
endmodule
