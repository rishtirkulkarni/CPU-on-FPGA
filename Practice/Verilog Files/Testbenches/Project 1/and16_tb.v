`timescale 1ns / 1ps 
// Create Date: 03/26/2025 10:35:56 AM
// Design Name: testbench for 16 bit AND gate
// Module Name: and16_tb



module and16_tb(

    );
    
    reg [15:0] a;           
    reg [15:0] b;
    wire [15:0] y;          

    
    and16 uut (
        .a(a),
        .b(b),
        .y(y)
    );
    
    initial begin
        $display("Time\t a\t\t\t b\t\t\t y (Output)");
        $monitor("%0t\t %b\t %b\t %b", $time, a, b, y);

        
        a = 16'b0000_0000_0000_0000;
        b = 16'b0000_0000_0000_0000;
        #10; 
        a = 16'b1111_1111_1111_1111;
        b = 16'b0000_0000_0000_0000;
        #10; 
        a = 16'b1100_1100_1100_1100;
        b = 16'b1010_1010_1010_1010;
        #10; 
        a = 16'b1111_1111_1111_1111;
        b = 16'b1111_1111_1111_1111;
        #10; 
        a = 16'b0011_1100_1010_1111;
        b = 16'b1100_0011_1010_1100;
        #10; 

        $stop; 
    end
endmodule
