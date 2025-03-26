`timescale 1ns / 1ps

// Create Date: 03/25/2025 08:18:01 PM
// Design Name: 2 to 1 Mux
// Module Name: mux_2to1 
// Description: Created by Rishti


module mux_2to1(
    input wire a,
    input wire b,
    input wire sel,
    output reg y
    );
    
    always @(*) begin
        if (sel == 1'b0)
            y = a;
        else 
            y = b;
    end
endmodule
