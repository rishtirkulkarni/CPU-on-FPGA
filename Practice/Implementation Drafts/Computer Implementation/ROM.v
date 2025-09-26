//Instruction Memory
//26/09/2025

module ROM32k(
    input [14:0] address,
    input clk,
    output reg [15:0] out
    );
    
    reg [15:0] ROM [0:32767];
    
    // Yet to initialise with instructions
  
    always@(posedge clk)begin
        out <= ROM[address];
    end
    
endmodule
