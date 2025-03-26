`timescale 1ns / 1ps

// Create Date: 03/24/2025 04:41:56 PM
// Design Name: NOT Gate
// Module Name: not_gate 
// Description: Created by Rishti
 

module not_gate(
    input wire a,
    output reg y
    );
    
     always @(*) begin
        if (a == 1'b1)
            y = 1'b0;
        else
            y = 1'b1;
     end
endmodule
