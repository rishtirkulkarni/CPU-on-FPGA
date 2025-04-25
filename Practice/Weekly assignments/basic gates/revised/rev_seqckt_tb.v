`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 08:26:19 PM
// Design Name: 
// Module Name: rev_seqckt_tb
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


module rev_seqckt_tb;
    reg d_in;
    reg clk;
    wire d_out;
    
    rev_seqckt uut (
        .d_in(d_in),
        .clk(clk),
        .d_out(d_out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        d_in = 0;
        #10;
        d_in = 1;
        #10;
        d_in = 0;
        #10;
        d_in = 1;
        #10;
        $finish;
    end

endmodule
