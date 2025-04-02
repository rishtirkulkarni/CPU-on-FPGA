`timescale 1ns / 1ps

// Create Date: 04/02/2025 11:08:00 AM 
// Module Name: inc16_tb



module inc16_tb(

    );
    
    reg [15:0]in;
    wire [15:0] out;
    
    inc16 uut (
        .in(in),
        .out(out)
    );
    
    initial begin  
        in = 16'b0000_0000_0000_0000; #10
        in = 16'b0000_0000_0000_1010; #10
        in = 16'b0111_1111_1111_1110; #10
        in = 16'b1111_1111_1111_1111; #10
        in = 16'b1010_1010_1010_1010; #10
        
        $finish;
    end
endmodule
