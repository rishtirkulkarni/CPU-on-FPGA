`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 05:10:09 PM
// Rishti 
// RAM64 - 64 memory locations

module RAM64(
    input wire [15:0] in,
    input wire [5:0] address,
    input wire load,
    input wire clk,
    output reg [15:0] out
    );
    
    reg [15:0] memory [0:63];
    
    always@(posedge clk) begin
        if(load) begin
            memory[address] <= in;
        end
    end
    
    always@ (*) begin
        out = memory[address];
    end
endmodule
