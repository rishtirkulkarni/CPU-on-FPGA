`timescale 1ns / 1ps
// Create Date: 03/26/2025 10:31:26 AM
// Design Name: 16 bit And gate
// Module Name: and16
// Description: Created by Rishti



module and16(
    input wire [15:0] a,
    input wire [15:0] b,
    output reg [15:0] y
    );
    
    integer i;
    
    always @(*) begin
        for (i=0; i<16; i=i+1) begin
            if (a[i] == 1'b1 && b[i] == 1'b1)
                y[i] = 1'b1;
            else
                y[i] = 1'b0;
        end
    end
endmodule
