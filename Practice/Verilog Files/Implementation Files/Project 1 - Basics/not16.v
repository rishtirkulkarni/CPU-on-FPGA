`timescale 1ns / 1ps 
// Create Date: 03/26/2025 09:09:15 AM
// Design Name: 16 bit NOT gate
// Module Name: not16 
// Description: Created by Rishti


module not16(
    input [15:0] in,
    output reg [15:0] out
    
    );
    
    integer i;
    
    always @(*) begin
        for (i=0; i<16; i=i+1)begin
            if (in[i] == 1'b1)
                out[i] = 1'b0;
            else
                out[i] = 1'b1;
        end        
    end
endmodule
