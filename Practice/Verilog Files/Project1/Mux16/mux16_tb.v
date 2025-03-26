`timescale 1ns / 1ps
// Create Date: 03/26/2025 06:37:37 PM
// Design Name: testbench for 16 bit mux
// Module Name: mux16_tb


module mux16_tb(

    );
    
    reg [15:0] a;
    reg [15:0] b;
    reg sel;
    wire [15:0] out;
    
    mux16 uut (
       .a(a),
       .b(b),
       .sel(sel),
       .out(out)
   );
   
   initial begin
    // Monitor the outputs
    $monitor("Time = %0t | a = %h | b = %h | sel = %b | out = %h", $time, a, b, sel, out);
    
    // Test Case 1: sel = 0, output should be a
    a = 16'hAAAA; // Example input 1010101010101010
    b = 16'h5555; // Example input 0101010101010101
    sel = 0;
    #10;
    
    // Test Case 2: sel = 1, output should be b
    sel = 1;
    #10;

    // Test Case 3: Change inputs with sel = 0
    a = 16'h1234;
    b = 16'h5678;
    sel = 0;
    #10;
    
    // Test Case 4: Change inputs with sel = 1
    sel = 1;
    #10;
    
    // Test Case 5: Random inputs
    a = $random;
    b = $random;
    sel = $random % 2;
    #10;

    // Finish simulation
    $finish;
  end
    
endmodule
