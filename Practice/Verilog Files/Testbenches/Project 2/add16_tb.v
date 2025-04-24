`timescale 1ns / 1ps
// Create Date: 03/31/2025 07:51:35 PM
// Module Name: add16_tb


module add16_tb(

    );
    
     reg [15:0] a, b;
    reg c_in;
    wire [15:0] sum;
    wire c_out;


    add16 uut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );

    
    initial begin
        
        a = 16'b0000000000000000; 
        b = 16'b0000000000000000; 
        c_in = 0; 
        #10; 
        a = 16'b0000000000000001; 
        b = 16'b0000000000000010; 
        c_in = 0; 
        #10; 
        a = 16'b0000000000000011; 
        b = 16'b0000000000000001; 
        c_in = 1; 
        #10; 
        a = 16'b1111111111111111; 
        b = 16'b1111111111111111; 
        c_in = 1; 
        #10; 
        a = 16'b1010101010101010; 
        b = 16'b0101010101010101; 
        c_in = 0; 
        #10;
        a = 16'b1000000000000000; 
        b = 16'b1000000000000000; 
        c_in = 0; 
        #10;
        $finish;
    end
endmodule
