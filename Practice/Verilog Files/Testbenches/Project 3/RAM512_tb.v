`timescale 1ns / 1ps

// Create Date: 04/24/2025 10:06:53 PM 
// Module Name: RAM512_tb

module RAM512_tb;
    reg clk;
    reg load;
    reg [8:0] address;
    reg [15:0] in;
    wire [15:0] out;
    
    RAM512 uut (
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
        address = 9'b000000000;  
        in = 16'b0000000000000000;    

        #10;
        address = 9'b000000001;
        in = 16'b0000000011111111;  
        load = 1; #10; load = 0;

        address = 9'b000001000;
        in = 16'b1111000011110000;  
        load = 1; #10; load = 0;
        
        address = 9'b100000000;
        in = 16'b1010101010101010;
        load = 1; #10; 
        
        load = 0;
        address = 9'b000000001; #10;

        address = 9'b000001000; #10;

        address = 9'b100000000; #10;

        $finish;
    end
endmodule
