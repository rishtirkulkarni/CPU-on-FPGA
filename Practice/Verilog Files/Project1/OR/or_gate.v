`timescale 1ns / 1ps 
// Create Date: 03/24/2025 05:44:03 PM
// Design Name: OR gate
// Module Name: or_gate
// Description: Created by Rishti


module or_gate(
    input wire a,
    input wire b,
    output reg y
    );
    
    always @(*) begin
        if (a == 1'b1 || b == 1'b1)
            y = 1'b1;
        else 
            y = 1'b0;
    end
    
endmodule
