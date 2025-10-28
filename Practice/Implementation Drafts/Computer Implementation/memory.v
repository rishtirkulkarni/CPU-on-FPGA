// Data Memory
// 26/09/2025
// Revised on: 28/10/2025

module data_memory(
    input  wire        clk,
    input  wire        initialize,  // preload trigger
    input  wire        load,        // CPU write enable
    input  wire [14:0] address,
    input  wire [15:0] in,
    output reg  [15:0] out
);

    // 16K x 16-bit data memory
    reg [15:0] RAM [0:16383];

    // Initialize Required Data

    always @(posedge clk) begin
        if (initialize) begin
            // Example data values
            RAM[0] <= 16'h0000;  // result placeholder
            RAM[1] <= 16'h0002;  // operand 1
            RAM[2] <= 16'h0003;  // operand 2
        end
    end

    // Write operation

    always @(posedge clk) begin
        if (load && !initialize)
            RAM[address[13:0]] <= in;
    end 
    
    // Read operation
    
    always @(posedge clk) begin
        out <= RAM[address[13:0]];
    end

endmodule
