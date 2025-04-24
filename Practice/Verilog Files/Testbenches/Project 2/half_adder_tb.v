`timescale 1ns / 1ps
 
// Create Date: 03/31/2025 05:48:22 PM
// Module Name: half_adder_tb



module half_adder_tb(

    );
    
    reg a;
    reg b;
    wire sum;
    wire c_out;
    
    half_adder uut(
        .a(a), .b(b), .sum(sum), .c_out(c_out)
    );
    
    initial begin
        a = 1'b0; b = 1'b0; #10
        a = 1'b0; b = 1'b1; #10
        a = 1'b1; b = 1'b0; #10
        a = 1'b1; b = 1'b1; #10
        $finish;
        
    end
    
endmodule
