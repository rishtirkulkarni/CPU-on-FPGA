`timescale 1ns / 1ps
 
// Create Date: 04/02/2025 12:10:00 PM 
// Module Name: ALU_tb



module ALU_tb(

    );
    
    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;

    wire [15:0] out;
    wire zr, ng;

    
    ALU uut (
        .x(x), .y(y), .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
        .out(out), .zr(zr), .ng(ng)
    );

    initial begin
       
        x = 16'b0000000000000011;
        y = 16'b0000000000000010;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0; 
        #10;

        
        x = 16'b1111111111111111; 
        y = 16'b0000111100001111; 
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0; 
        #10;

     
        x = 16'b1010101010101010; 
        y = 16'b0101010101010101; 
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 1; 
        #10;

        
        x = 16'b0001001000110100; 
        y = 16'b0000000000000000; 
        zx = 0; nx = 1; zy = 1; ny = 0; f = 1; no = 0; 
        #10;

        
        x = 16'b0000000000000001; 
        y = 16'b0000000000000001; 
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 1;
        #10;

        
        x = 16'b0000000000000000; 
        y = 16'b0000000000000000;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0; 
        #10;

        
        x = 16'b1000000000000000; 
        y = 16'b0000000000000000; 
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0; 
        #10;

        $finish;
    end


endmodule
