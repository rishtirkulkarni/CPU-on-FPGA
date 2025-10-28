//Instruction Memory
//26/09/2025
// Revised on 28/10/2025

module ROM32k(
    input  wire [14:0] address,
    input  wire        clk,
    input  wire        initialize,  // active-high initialization trigger
    output reg  [15:0] out
);

    // Declare 32K x 16-bit memory
    reg [15:0] ROM [0:32767];

    // Initialization block

    // Only writes when 'initialize' is HIGH
    always @(posedge clk) begin
        if (initialize) begin
            // Hardcoded Hack Assembly: Add 2 + 3 → store at RAM[0]
            ROM[0] <= 16'b0000000000000010; // @2
            ROM[1] <= 16'b1110110000010000; // D=A
            ROM[2] <= 16'b0000000000000011; // @3
            ROM[3] <= 16'b1110000010010000; // D=D+A
            ROM[4] <= 16'b0000000000000000; // @0
            ROM[5] <= 16'b1110001100001000; // M=D
            ROM[6] <= 16'b0000000000000110; // @6
            ROM[7] <= 16'b1110101010000111; // 0;JMP
        end
    end
    
    // Read block
    
    always @(posedge clk) begin
        out <= ROM[address];
    end

endmodule

