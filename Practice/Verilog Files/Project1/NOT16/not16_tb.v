`timescale 1ns / 1ps
// Create Date: 03/26/2025 10:19:56 AM
// Design Name: testbench for 16 bit NOT gate
// Module Name: not16_tb


module not16_tb(
    
    );

    
    reg [15:0] in;           
    wire [15:0] out;         

    
    not16 uut (
        .in(in),
        .out(out)
    );

    
    initial begin
        $display("Time\t Input (in)\t\t Output (out)");
        $monitor("%0d\t %b\t %b", $time, in, out);

       
        in = 16'b0000_0000_0000_0000; #10; 
        in = 16'b1111_1111_1111_1111; #10; 
        in = 16'b1010_1010_1010_1010; #10; 
        in = 16'b0000_1111_0000_1111; #10; 
        in = 16'b1100_1100_1100_1100; #10; 
        
        $stop; 
    end
    
endmodule
