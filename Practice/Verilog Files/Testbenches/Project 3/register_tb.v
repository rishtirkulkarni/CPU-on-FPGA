`timescale 1ns / 1ps

// Create Date: 04/24/2025 07:35:46 PM
// Module Name: register_tb

module register_tb;
    reg [15:0] in;
    reg load;
    reg clk;
    wire [15:0] out;
    
    register uut(
        .in(in),
        .load(load),
        .clk(clk),
        .out(out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end
    
    initial begin
        
        load = 0;
        in = 16'b0000000011111111; #10;

        load = 1;
        in = 16'b0000000011111111; #10;
        
        load = 1;
        in = 16'b1010101010101010; #10;
      
        $finish;
    end

endmodule


        
        
        
        