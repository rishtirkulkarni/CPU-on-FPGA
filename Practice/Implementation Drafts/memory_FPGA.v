`timescale 1ns / 1ps
// Create Date: 08/16/2025 12:20:34 PM
// Design Name: FPGA implementation of memory
// Module Name: memory_FPGA

module memory_FPGA(
    input [15:0] SW,         // 16 switches: used for address or data
    input BTN_addr,          // pushbutton to latch address
    input BTN_write,         // pushbutton to write data
    input clk,
    output reg [15:0] out
);

    // Memory array
    reg [15:0] RAM16K_SCREEN [0:24575];
    reg [14:0] current_address;  // stores the address latched from switches

    integer i;
    
    // Preload memory
    initial begin
        for(i = 0; i < 1000; i = i + 1)
            RAM16K_SCREEN[i] = i;
        for(i = 1001; i < 1012; i = i + 1)
            RAM16K_SCREEN[i] = 16'b0101010101010101;
    end

    // Latch address
    always @(posedge clk) begin
        if (BTN_addr) begin
            current_address <= SW[14:0];  // use lower 15 bits of switches as address
        end
    end

    // Write data
    always @(posedge clk) begin
        if (BTN_write) begin
            RAM16K_SCREEN[current_address] <= SW;  // write full 16-bit data
        end
    end

    // Read memory
    always @(*) begin
        out = RAM16K_SCREEN[current_address];  // always show memory at current address
    end

endmodule

