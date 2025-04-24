`timescale 1ns / 1ps
 
// Create Date: 04/24/2025 04:36:10 PM
// Rishti 
// RAM8 - 8 memory locations

module RAM8(
    input wire [15:0] in,
    output reg [15:0] out,
    input wire [2:0] address,
    input wire load,
    input wire clk
    );
    
    reg [15:0] memory [0:7];
    
    always @(posedge clk)begin
        if(load) begin
            memory[address] <= in;
        end
    end
    
    always@(*)begin
        out = memory[address];
    end
endmodule
