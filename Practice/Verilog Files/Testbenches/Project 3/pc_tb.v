`timescale 1ns / 1ps

// Create Date: 04/24/2025 08:29:24 PM
// Module Name: pc_tb

module pc_tb;
    reg [15:0] in;
    reg reset;
    reg load;
    reg inc;
    reg clk;
    wire [15:0] out;
    
    pc uut(
        .in(in), .reset(reset), .load(load), .inc(inc), .clk(clk), .out(out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 0;
        inc = 0;
        load = 0;
        in = 16'b0000000000000000; #10
        
        in = 16'b0000000000101010;
        load = 1; #10;
        load = 0;

        inc = 1; #20;
        inc = 0;
        
        in = 16'b0000000001100100;
        load = 1; #10;
        load = 0;
        
        reset = 1; #10;
        reset = 0;
        
        inc = 1; #20;
        inc = 0;

        $finish;
    end
    
endmodule
