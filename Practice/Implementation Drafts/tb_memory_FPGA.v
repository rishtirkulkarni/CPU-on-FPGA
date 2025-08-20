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


module tb_memory_FPGA;
    reg [15:0] SW;
    reg BTN_addr;
    reg BTN_write;
    reg clk;
    wire [15:0] out;
    
    memory_FPGA uut (
        .SW(SW),
        .BTN_addr(BTN_addr),
        .BTN_write(BTN_write),
        .clk(clk),
        .out(out)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        SW = 16'b0;
        BTN_addr = 0;
        BTN_write = 0;
        #20;

        SW = 16'b0000000000000101;
        BTN_addr = 1;
        #10;
        BTN_addr = 0;
        #10;

        SW = 16'b0011000000111001;
        BTN_write = 1;
        #10;
        BTN_write = 0;
        #10;

        SW = 16'b0000000000000101;
        #10;
        $display("Read value at address 5: %b", out);

        SW = 16'b0000011111011001;
        BTN_addr = 1;
        #10;
        BTN_addr = 0;
        #10;

        SW = 16'b1010101111001101;
        BTN_write = 1;
        #10;
        BTN_write = 0;
        #10;

        #10;
        $display("Read value at address 1001: %b", out);

        $finish;
    end

endmodule
