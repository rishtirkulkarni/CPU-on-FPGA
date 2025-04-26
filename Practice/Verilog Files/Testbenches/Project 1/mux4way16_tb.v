`timescale 1ns / 1ps
 
// Create Date: 04/26/2025 
// Module Name: mux4way16_tb


module mux4way16_tb;
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;
    
    mux4way16 uut (
        .a(a), .b(b), .c(c), .d(d),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        a = 16'b0000000000000001;
        b = 16'b0000000000000010;
        c = 16'b0000000000000100;
        d = 16'b0000000000001000;
    
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
    
        $finish;
    end
endmodule
