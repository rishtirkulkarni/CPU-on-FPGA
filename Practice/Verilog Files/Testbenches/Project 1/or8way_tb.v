`timescale 1ns / 1ps

// Create Date: 04/26/2025 
// Module Name: or8way_tb



module or8way_tb;
    reg a, b, c, d, e, f, g, h;
    wire out;
    
    or8way uut (
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .out(out)
    );
    
    initial begin
        a = 0; b = 0; c = 0; d = 0;
        e = 0; f = 0; g = 0; h = 0;
        #10; 
        
        a = 1; b = 0; c = 0; d = 0;
        e = 0; f = 0; g = 0; h = 0;
        #10;
        
        a = 0; b = 1; c = 1; d = 0;
        e = 0; f = 1; g = 0; h = 0;
        #10;
        
        a = 1; b = 1; c = 1; d = 1;
        e = 1; f = 1; g = 1; h = 1;
        #10;
        
        a = 0; b = 1; c = 0; d = 1;
        e = 0; f = 0; g = 1; h = 0;
        #10;

        $finish;
    end
    
endmodule
