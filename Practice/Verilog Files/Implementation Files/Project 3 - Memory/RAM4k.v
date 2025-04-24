`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:40:22 PM
// Rishti 
// RAM4K - 4096 memory locations

module RAM4k(
    input wire [15:0] in,
    input wire [11:0] address,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
    
    reg [15:0] memory [0:4095];
    
    always@(posedge clk) begin
        if(load) begin
            memory[address] <= in;
        end
    end
    
    always@(*) begin
        out = memory[address];
    end
    
endmodule
