`timescale 1ns / 1ps 
// Create Date: 03/24/2025 05:52:47 PM
// Design Name: testbench for OR gate
// Module Name: or_gate_tb



module or_gate_tb(

    );
    reg a;
    reg b;
    wire y;
    
   or_gate uut (
       .a(a),
       .b(b),
       .y(y)
   );
   
   initial begin
       $display("Time | A | B | Y (A AND B)");
        $monitor("%4d  | %b | %b | %b", $time, a, b, y);

        // Test Case 1: A=0, B=0
        a = 1'b0; b = 1'b0;
        #10;

        // Test Case 2: A=0, B=1
        a = 1'b0; b = 1'b1;
        #10;

        // Test Case 3: A=1, B=0
        a = 1'b1; b = 1'b0;
        #10;

        // Test Case 4: A=1, B=1
        a = 1'b1; b = 1'b1;
        #10;

        // End Simulation
        $finish;
    end
endmodule
