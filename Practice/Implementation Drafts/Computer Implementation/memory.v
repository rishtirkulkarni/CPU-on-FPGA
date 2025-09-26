// Data Memory
// 26/09/2025

module memory(
    input [15:0] in,
    input [14:0] address,
    input load,
    input clk,
    output [15:0] out
    );

    wire [15:0] ram_out;

    RAM16K inst16kRAM (
        .in(in),
        .out(ram_out),
        .address(address[13:0]), // 14-bit address = 16K
        .clk(clk),
        .load(load)
    );
  
    assign out = ram_out;

endmodule
