`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 08:19:24 PM
// Design Name: 
// Module Name: rev_seqckt
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


module rev_seqckt(
    input wire d_in,
    input wire clk,
    output reg d_out
    );
    
    reg comb1,comb2;
    reg q1, q2;
    
    always@(posedge clk)begin
        q1 = d_in;
    end
    
    always@(posedge clk)begin
        comb1 = q1&1'b1;
        comb2 = comb1|1'b0;
    end
    
    always@(posedge clk)begin
        d_out = comb2;
    end
        
endmodule
