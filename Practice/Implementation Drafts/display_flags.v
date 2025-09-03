`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 05:31:51 PM
// Design Name: 
// Module Name: display_flags
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_flags(
    input clk,
    input zr, ng,
    output reg [6:0] seg,
    output reg [3:0] an
);
    reg state = 0;

    always @(posedge clk) begin
        state <= ~state;  // toggle between showing zr and ng

        if (state) begin
            // Show ZR flag on digit0 (rightmost)
            an <= 4'b1110;  
            seg <= (zr) ? 7'b1111001 : 7'b1000000; // "1" or "0"
        end else begin
            // Show NG flag on digit1 (next digit)
            an <= 4'b1101;  
            seg <= (ng) ? 7'b1111001 : 7'b1000000; // "1" or "0"
        end
    end
endmodule

