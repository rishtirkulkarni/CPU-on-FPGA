`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 07:59:35 PM
// Design Name: 
// Module Name: tb_memory_FPGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module tb_memory_FPGA;

    reg [15:0] SW;
    reg BTN_addr, BTN_write, clk, initialise;
    wire [15:0] out;

    memory_FPGA uut (
        .SW(SW),
        .BTN_addr(BTN_addr),
        .BTN_write(BTN_write),
        .clk(clk),
        .initialise(initialise),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Case 1: Initialize memory
        initialise = 1; BTN_addr = 0; BTN_write = 0; SW = 16'b0;
        #10 initialise = 0;

        // Case 2: Latch address = 000000000000001
        SW = 16'b0000000000000001; BTN_addr = 1; #10 BTN_addr = 0;

        // Case 3: Read from initialized location
        #10;

        // Case 4: Write new data 1111000011110000 at latched address
        SW = 16'b1111000011110000; BTN_write = 1; #10 BTN_write = 0;

        // Case 5: Read back written data
        #10;

        // Case 6: Change address = 000000000000010
        SW = 16'b0000000000000010; BTN_addr = 1; #10 BTN_addr = 0;

        // Case 7: Write and read 1010101010101010
        SW = 16'b1010101010101010; BTN_write = 1; #10 BTN_write = 0;
        #10;

        $finish;
    end
endmodule

