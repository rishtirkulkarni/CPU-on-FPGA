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

    
    reg [15:0] RAM [0:16383];
    integer i;

    initial begin
        // 1. Clear everything to 0
        for (i = 0; i < 16384; i = i + 1) begin
            RAM[i] = 16'b0;
        end
        
        // 2. TEST VALUES 
        
        RAM[0] = 16'd3;  // Operand A
        RAM[1] = 16'd4;  // Operand B (Counter)
        
    end
    
    // 3. WRITE OPERATION
    
    always @(posedge clk) begin
        if (load && !initialize)
            RAM[address[13:0]] <= in;
    end 
    
    
    // 4. READ OPERATION (Asynchronous)
    
    always @(*) begin
        out = RAM[address[13:0]];
    end

endmodule
