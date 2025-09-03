`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 09:20:50 AM
// Design Name: 
// Module Name: ALU_FPGA
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


module ALU_FPGA(
    input clk,
    input zx, nx, zy, ny, f, no, initialise,
    input [4:0] address_a, address_b,
    output [15:0] result,
    output zr, ng,
    output [6:0] seg,
    output [3:0] an
    );
        
    //memory locations to store operands a and b
    reg [15:0] mem_locations_a [0:31];
    reg [15:0] mem_locations_b [0:31];
    
    //precoding values into memory locations
    always@(posedge clk)begin
        if(initialise)begin
            // ====== mem_locations_a ======
            mem_locations_a[0]  <= 16'b0000000000000000; // 0
            mem_locations_a[1]  <= 16'b0000000000000001; // 1
            mem_locations_a[2]  <= 16'b0000000000000010; // 2
            mem_locations_a[3]  <= 16'b0000000000000011; // 3
            mem_locations_a[4]  <= 16'b0000000000000100; // 4
            mem_locations_a[5]  <= 16'b0000000000000101; // 5
            mem_locations_a[6]  <= 16'b0000000000000111; // 7
            mem_locations_a[7]  <= 16'b0000000000001000; // 8
            mem_locations_a[8]  <= 16'b0000000001111111; // +127
            mem_locations_a[9]  <= 16'b0000000011111111; // +255
            mem_locations_a[10] <= 16'b0000111111111111; // +4095
            mem_locations_a[11] <= 16'b0111111111111111; // +32767
    
            mem_locations_a[12] <= 16'b1111111111111111; // -1
            mem_locations_a[13] <= 16'b1111111111111110; // -2
            mem_locations_a[14] <= 16'b1111111111111101; // -3
            mem_locations_a[15] <= 16'b1111111111111000; // -8
            mem_locations_a[16] <= 16'b1111111110000000; // -128
            mem_locations_a[17] <= 16'b1111111100000000; // -256
            mem_locations_a[18] <= 16'b1111000000000000; // -4096
            mem_locations_a[19] <= 16'b1000000000000000; // -32768
    
            mem_locations_a[20] <= 16'b0101010101010101; // pattern 0101
            mem_locations_a[21] <= 16'b1010101010101010; // pattern 1010
            mem_locations_a[22] <= 16'b0000111100001111; // nibble pattern
            mem_locations_a[23] <= 16'b1111000011110000; // inverse nibble
            mem_locations_a[24] <= 16'b0001000100010001; // sparse 1s
            mem_locations_a[25] <= 16'b0010001000100010; // shifted sparse
            mem_locations_a[26] <= 16'b1001100110011001; // checker pattern
            mem_locations_a[27] <= 16'b0110011001100110; // another checker
            mem_locations_a[28] <= 16'b0000100000001000; // isolated bits
            mem_locations_a[29] <= 16'b1000000000000001; // MSB+LSB
            mem_locations_a[30] <= 16'b0111000011110000; // mixed half
            mem_locations_a[31] <= 16'b1111111100000001; // mostly 1s edge
    
            // ====== mem_locations_b (same values) ======
            mem_locations_b[0]  <= 16'b0000000000000000;
            mem_locations_b[1]  <= 16'b0000000000000001;
            mem_locations_b[2]  <= 16'b0000000000000010;
            mem_locations_b[3]  <= 16'b0000000000000011;
            mem_locations_b[4]  <= 16'b0000000000000100;
            mem_locations_b[5]  <= 16'b0000000000000101;
            mem_locations_b[6]  <= 16'b0000000000000111;
            mem_locations_b[7]  <= 16'b0000000000001000;
            mem_locations_b[8]  <= 16'b0000000001111111;
            mem_locations_b[9]  <= 16'b0000000011111111;
            mem_locations_b[10] <= 16'b0000111111111111;
            mem_locations_b[11] <= 16'b0111111111111111;
    
            mem_locations_b[12] <= 16'b1111111111111111;
            mem_locations_b[13] <= 16'b1111111111111110;
            mem_locations_b[14] <= 16'b1111111111111101;
            mem_locations_b[15] <= 16'b1111111111111000;
            mem_locations_b[16] <= 16'b1111111110000000;
            mem_locations_b[17] <= 16'b1111111100000000;
            mem_locations_b[18] <= 16'b1111000000000000;
            mem_locations_b[19] <= 16'b1000000000000000;
    
            mem_locations_b[20] <= 16'b0101010101010101;
            mem_locations_b[21] <= 16'b1010101010101010;
            mem_locations_b[22] <= 16'b0000111100001111;
            mem_locations_b[23] <= 16'b1111000011110000;
            mem_locations_b[24] <= 16'b0001000100010001;
            mem_locations_b[25] <= 16'b0010001000100010;
            mem_locations_b[26] <= 16'b1001100110011001;
            mem_locations_b[27] <= 16'b0110011001100110;
            mem_locations_b[28] <= 16'b0000100000001000;
            mem_locations_b[29] <= 16'b1000000000000001;
            mem_locations_b[30] <= 16'b0111000011110000;
            mem_locations_b[31] <= 16'b1111111100000001;
        end        
    end
    
    //ALU instantiation
    ALU inst_ALU (
        .x(mem_locations_a[address_a]),
        .y(mem_locations_b[address_b]),
        .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
        .out(result),
        .zr(zr), .ng(ng)    
    );
    
    display_flags disp(
        .clk(clk),
        .zr(zr),
        .ng(ng),
        .seg(seg),
        .an(an)
    );
endmodule
