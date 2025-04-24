`timescale 1ns / 1ps
// Create Date: 03/25/2025 08:45:47 PM
// Design Name: testbench for Demux
// Module Name: demux_1to2_tb



module demux_1to2_tb(

    );
    
    reg in;
    reg sel;
    wire a;
    wire b;
    
    demux_1to2 uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b)
    );
    
    initial begin
        
        $display("x sel | y0 y1");
        $display("--------|-------");

        
        in = 0; sel = 0; #10; 
        in = 1; sel = 0; #10; 
        in = 0; sel = 1; #10; 
        in = 1; sel = 1; #10; 

        $stop; 
    end
endmodule
