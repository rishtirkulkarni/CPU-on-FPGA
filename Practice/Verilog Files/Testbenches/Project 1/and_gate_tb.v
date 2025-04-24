`timescale 1ns / 1ps 
// Create Date: 03/24/2025 05:22:16 PM
// Design Name: testbench for AND gate
// Module Name: and_gate_tb



module and_gate_tb(

    );
    
    reg a;
    reg b;
    wire y;
    
   and_gate uut (
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

        // End Simulation
        $finish;
    end
       
endmodule
