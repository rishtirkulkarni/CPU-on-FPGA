`timescale 1ns / 1ps
 
// Create Date: 04/02/2025 11:29:05 AM
// Rishti
// Module Name: ALU



module ALU(
    input wire [15:0] x,
    input wire [15:0] y,
    input wire zx,
    input wire nx,
    input wire zy,
    input wire ny,
    input wire f,
    input wire no,
    output reg [15:0] out,
    output reg zr,
    output reg ng
    );
    
    reg [15:0] x_temp,y_temp;
    
    always @(*)begin
        if (zx == 1'b1)
            x_temp = 16'b0;
        else 
            x_temp = x;
        
        if (nx == 1'b1)
            x_temp = ~x_temp;
       
        if (zy == 1'b1)
            y_temp = 16'b0;
        else
            y_temp = y;
        
        if (ny == 1'b1)
            y_temp = ~y_temp;
        
        if (f == 1'b1)
            out = x_temp + y_temp;
        else
            out = x_temp & y_temp;
        
        if (no == 1'b1)
            out = ~out;
            
        
        if (out == 16'b0)
            zr = 1'b1;
        else 
            zr = 1'b0;
        
        ng = out[15];
        
    end
