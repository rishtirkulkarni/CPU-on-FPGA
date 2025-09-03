`timescale 1ns / 1ps
// Create Date: 08/16/2025 12:20:34 PM
// Design Name: FPGA implementation of memory
// Module Name: memory_FPGA

module memory_FPGA(
    input [15:0] SW,         // 16 switches: used for address or data
    input BTN_addr,          // pushbutton to latch address
    input BTN_write,         // pushbutton to write data
    input clk, initialise,
    output reg [15:0] out
);

    // Memory array
    reg [15:0] RAM16K_SCREEN [0:1024];
    reg [14:0] current_address;  // stores the address latched from switches
    
    
    always@(posedge clk)begin
        if (initialise)begin
        RAM16K_SCREEN[0] <= 16'b0000000011111111;
        RAM16K_SCREEN[1] <= 16'b0000111100001111;
        RAM16K_SCREEN[2] <= 16'b0011001100110011;
        RAM16K_SCREEN[3] <= 16'b0101010101010101;
        end
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
        out <= RAM16K_SCREEN[current_address];  // always show memory at current address
    end

endmodule

