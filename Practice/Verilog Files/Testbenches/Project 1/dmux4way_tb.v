`timescale 1ns / 1ps

// Create Date: 04/26/2025  
// Module Name: dmux4way_tb



module dmux4way_tb;
    reg in;
    reg [1:0] sel;
    wire a, b, c, d;
    
    demux4way uut (
        .in(in),
        .sel(sel),
        .a(a), .b(b), .c(c), .d(d)
    );
    
    initial begin
        in = 1'b1;
    
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
    
        in = 1'b0;
    
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
    
        $finish;
    end
endmodule
