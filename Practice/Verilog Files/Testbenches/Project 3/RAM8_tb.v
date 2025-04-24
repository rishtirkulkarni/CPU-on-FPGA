`timescale 1ns / 1ps
// Create Date: 04/24/2025 10:23:33 PM
// Module Name: RAM8_tb
module RAM8_tb;
    reg clk;
    reg load;
    reg [2:0] address;
    reg [15:0] in;
    wire [15:0] out;

    RAM8 uut (
        .clk(clk),
        .load(load),
        .address(address),
        .in(in),
        .out(out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        load = 0;
        address = 3'b000;  
        in = 16'b0000000000000000;  #10;

        address = 3'b001;
        in = 16'b0000000011111111;  
        load = 1; #10; 
        
        load = 0;
        address = 3'b010;
        in = 16'b1111000011110000;  
        load = 1; #10; load = 0;

        address = 3'b100;
        in = 16'b1010101010101010;  
        load = 1; #10; load = 0;

        address = 3'b001; #10;

        address = 3'b010; #10;
        
        address = 3'b100; #10;
        
        address = 3'b000; #10;
        address = 3'b001; #10;
        address = 3'b010; #10;
        address = 3'b011; #10;
        address = 3'b100; #10;
        address = 3'b101; #10;
        address = 3'b110; #10;
        address = 3'b111; #10;

        $finish;
    end
endmodule
