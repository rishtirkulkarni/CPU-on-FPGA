`timescale 1ns / 1ps
 
// Create Date: 04/26/2025 
// Rishti 
// Module Name: or8way



module or8way(
    input  a, b, c, d, e, f, g, h,  
    output out
    );
    
    assign out = a | b | c | d | e | f | g | h;
endmodule
