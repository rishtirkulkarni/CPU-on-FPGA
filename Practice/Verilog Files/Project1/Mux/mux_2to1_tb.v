`timescale 1ns / 1ps 
// Create Date: 03/25/2025 08:24:49 PM
// Design Name: testbench for 2 to 1 Mux
// Module Name: mux_2to1_tb



module mux_2to1_tb(

    );
    
    reg a;
    reg b;
    reg sel;
    wire y;
    
   mux_2to1 uut (
       .a(a),
       .b(b),
       .sel(sel),
       .y(y)
   );
   
   initial begin
        
        $display("a b sel | y");
        $display("---------|--");

        
        a = 0; b = 0; sel = 0; #10; 
        a = 0; b = 1; sel = 0; #10; 
        a = 1; b = 0; sel = 0; #10; 
        a = 1; b = 1; sel = 0; #10; 

        a = 0; b = 0; sel = 1; #10;  
        a = 0; b = 1; sel = 1; #10;  
        a = 1; b = 0; sel = 1; #10;  
        a = 1; b = 1; sel = 1; #10;  

        $stop; 
    end
endmodule
