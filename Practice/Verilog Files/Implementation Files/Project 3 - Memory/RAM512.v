`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:26:37 PM
// Rishti 
// RAM512 - 512 memory locations

module RAM512(
    input wire [15:0] in,
    input wire [8:0] address,
    input wire clk,
    input wire load,
    output reg [15:0] out
    );
    
    reg [15:0] memory [0:512];
    
    always@(posedge clk) begin
        if(load) begin
            memory[address] <= in;
        end
    end
    
    always@(*)begin
        out = memory[address];
    end
endmodule
