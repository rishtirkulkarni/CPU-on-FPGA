`timescale 1ns / 1ps

// Create Date: 04/24/2025 08:04:04 PM
// Module Name: bit_tb

module bit_tb;
    reg in;
    reg load;
    reg clk;
    wire out;
    
    bit uut(.in(in), .load(load), .clk(clk), .out(out));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        load = 0;
        in = 1'b1; #10
        
        load = 1;
        in = 1'b1; #10
        
        load = 0;
        in = 1'b0; #10
        
        load = 1;
        in = 1'b0; #10
        
        $finish; 
    end
endmodule
