`timescale 1ns / 1ps 
// Create Date: 03/25/2025 08:10:03 PM
// Design Name: testbench for EXOR gate
// Module Name: xor_gate_tb



module xor_gate_tb(

    );
    
    reg a;
    reg b;
    wire y;
    
   xor_gate uut (
       .a(a),
       .b(b),
       .y(y)
   );
   
   initial begin
       $display("Time | A | B | Y (A AND B)");
        $monitor("%4d  | %b | %b | %b", $time, a, b, y);

       
        a = 1'b0; b = 1'b0;
        #10;

        
        a = 1'b0; b = 1'b1;
        #10;

        
        a = 1'b1; b = 1'b0;
        #10;

        
        a = 1'b1; b = 1'b1;
        #10;

        
        $finish;
    end
endmodule
