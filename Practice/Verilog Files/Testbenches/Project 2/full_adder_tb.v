`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 06:40:19 PM 
// Module Name: full_adder_tb

module full_adder_tb(

    );
    
    reg a;
    reg b;
    reg c_in;
    wire sum;
    wire c_out;
    
    full_adder uut(
        .a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out)
    );
    
    initial begin
        a = 0; b = 0; c_in = 0; #10; 
        a = 0; b = 0; c_in = 1; #10; 
        a = 0; b = 1; c_in = 0; #10; 
        a = 0; b = 1; c_in = 1; #10; 
        a = 1; b = 0; c_in = 0; #10; 
        a = 1; b = 0; c_in = 1; #10; 
        a = 1; b = 1; c_in = 0; #10; 
        a = 1; b = 1; c_in = 1; #10;   
        $finish; 
    end
    
endmodule
