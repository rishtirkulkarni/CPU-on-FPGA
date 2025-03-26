`timescale 1ns / 1ps 
// Create Date: 03/25/2025 08:02:53 PM
// Design Name: EXOR gate
// Module Name: xor_gate 
// Description: Created by Rishti


module xor_gate(
    input wire a,
    input wire b,
    output reg y
    );
    
    always @(*) begin
        if (a == 1'b1 && b == 1'b0)
            y = 1'b1;
        else if(a == 1'b0 && b == 1'b1)
            y = 1'b1;
       else 
            y = 1'b0;
    end
endmodule
