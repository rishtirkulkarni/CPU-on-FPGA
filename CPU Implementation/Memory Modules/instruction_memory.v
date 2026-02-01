//Instruction Memory
//26/09/2025
// Revised on 28/10/2025

module ROM32k(
    input  wire [14:0] address,
    input  wire        clk,
    input  wire        initialize,  // active-high initialization trigger
    output reg  [15:0] out
);
  
    reg [15:0] ROM [0:32767];
    integer i;
    // Initialization block
    // Only writes when 'initialize' is HIGH
    always @(posedge clk) begin
        if (initialize) begin
                       
                        // --- MULTIPLICATION: 3 * 4 = 12 ---
            // Stores result in RAM[2]
            
            // 1. SETUP: R0=3, R1=4, R2=0
            ROM[0]  <= 16'b0000000000000011; // @3      (A=3)
            ROM[1]  <= 16'b1110110000010000; // D=A     (D=3)
            ROM[2]  <= 16'b0000000000000000; // @0      (A=0 -> R0)
            ROM[3]  <= 16'b1110001100001000; // M=D     (RAM[0] = 3)
            
            ROM[4]  <= 16'b0000000000000100; // @4      (A=4)
            ROM[5]  <= 16'b1110110000010000; // D=A     (D=4)
            ROM[6]  <= 16'b0000000000000001; // @1      (A=1 -> R1)
            ROM[7]  <= 16'b1110001100001000; // M=D     (RAM[1] = 4)
            
            ROM[8]  <= 16'b0000000000000010; // @2      (A=2 -> R2)
            ROM[9]  <= 16'b1110101010001000; // M=0     (RAM[2] = 0)
            
            // 2. LOOP CHECK (Label: LOOP_START at line 10)
            ROM[10] <= 16'b0000000000000001; // @1      (A=1 -> R1)
            ROM[11] <= 16'b1111110000010000; // D=M     (D = Counter value)
            ROM[12] <= 16'b0000000000010110; // @22     (A=22 -> Target: END)
            ROM[13] <= 16'b1110001100000110; // D;JLE   (If Counter <= 0, Goto END)
            
            // 3. DO MATH (Accumulate)
            ROM[14] <= 16'b0000000000000000; // @0      (A=0 -> R0)
            ROM[15] <= 16'b1111110000010000; // D=M     (D = 3)
            ROM[16] <= 16'b0000000000000010; // @2      (A=2 -> R2)
            ROM[17] <= 16'b1111000010001000; // M=D+M   (RAM[2] = 3 + RAM[2])
            
            // 4. DECREMENT COUNTER
            ROM[18] <= 16'b0000000000000001; // @1      (A=1 -> R1)
            ROM[19] <= 16'b1111110010001000; // M=M-1   (RAM[1] = RAM[1] - 1)
            
            // 5. LOOP BACK
            ROM[20] <= 16'b0000000000001010; // @10     (A=10 -> LOOP_START)
            ROM[21] <= 16'b1110101010000111; // 0;JMP   (Jump to 10)
            
            // 6. END INFINITE LOOP (Label: END at line 22)
            ROM[22] <= 16'b0000000000010110; // @22     (A=22)
            ROM[23] <= 16'b1110101010000111; // 0;JMP   (Freeze here)
        end
    end
    
    // Read block
    
    always @(*) begin
        out <= ROM[address];
    end

endmodule
