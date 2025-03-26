`timescale 1ns / 1ps 
// Create Date: 03/24/2025 04:55:44 PM
// Design Name: testbench for NOT gate
// Module Name: not_gate_tb



module not_gate_tb(
 
    );
    
    reg a;
    wire y;
    
    not_gate uut (
        .a(a),
        .y(y)
    );  
    
    initial begin
        $display("Time | a | y");
        $monitor("%4d | %b | %b", $time, a, y);

        
        a = 1'b0;
        #10;  

        
        a = 1'b1;
        #10;

        
        $finish;
    end
    
endmodule
