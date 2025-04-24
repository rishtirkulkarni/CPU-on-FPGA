`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 06:13:51 PM
// Rishti 
// RAM16K - 16384 memory locations

module RAM16K(
    input wire [15:0] in,
    output reg [15:0] out,
    input wire [13:0] address,
    input wire clk,
    input wire load
    );
    
    reg [15:0] memory [0:16383];
    
    always@(posedge clk) begin
        if(load) begin
            memory[address]<= in;
        end
    end
    
    always@(*)begin
        out = memory[address];
    end
    
endmodule
