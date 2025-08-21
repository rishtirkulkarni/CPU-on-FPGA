`timescale 1ns / 1ps

// Create Date: 08/11/2025 12:25:06 PM 
// Module Name: memory


module memory(
    input [15:0] in,
    input [14:0] address,
    input load,
    input clk,
    output [15:0] out
    );
    
    //Addresses 
    wire addr_ram = (address[14:13] == 2'b00);
    wire addr_screen = (address[14:13] == 2'b10);
    wire addr_keyboard = (address == 16'h6000);
    
    //Load routing
    wire load_ram = load & addr_ram;
    wire load_screen = load & addr_screen;
    
    //Outputs for each component
    wire [15:0] ram_out;
    wire [15:0] screen_out;
    
    
    RAM16K inst16kRAM (
        .in(in),
        .out(ram_out),
        .address(address[13:0]), // take only bits 14 bits of the 15 bit address
        .clk(clk),
        .load(load_ram)
    );

    RAM8k SCREEN (
        .in(in),
        .out(screen_out),
        .address(address[12:0]), // take only bits 13 bits of the 15 bit address
        .clk(clk),
        .load(load_screen)
    );
    
    assign out = addr_ram ? ram_out:
                 addr_screen ? screen_out: 
                 addr_keyboard ? in:
                 16'h0000;  
    
endmodule
