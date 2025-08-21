`timescale 1ns / 1ps

// Create Date: 08/20/2025 02:48:16 PM 
// Module Name: computer


module computer(
    input reset,
    input clk_in
    );
    
    wire [14:0] pc_out;
    wire [15:0] ROM_out;
    
    ROM32k inst_rom (
        .address(pc_out),
        .clk(clk_in),
        .out(ROM_out)
    );
    
    wire [15:0] mem_out, outM_out;
    wire writeM_out;
    wire [14:0] addresM_out;
    
    CPU inst_cpu (
        .inM(mem_out),
        .instruction(ROM_out),
        .reset(reset),
        .clk(clk_in),
        .outM(outM_out),
        .writeM(writeM_out),
        .addressM(addresM_out),
        .pc(pc_out)
    );
    
    memory inst_mem(
        .in(outM_out),
        .address(addresM_out),
        .load(writeM_out),
        .clk(clk_in),
        .out(mem_out)
    );
     
endmodule
