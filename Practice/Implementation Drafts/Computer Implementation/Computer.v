// Top Computer Module
// Date: 26/09/2025

module computer(
    input reset,
    input clk,
    input [15:0] switches,     // manual instruction input
    input modeBtn,              // toggle between ROM and manual
    output [15:0] led_output    // shows result of computation in binary
    );
  
    // Mode selection flip-flop
    
    reg inputMode;             
    reg btnPrev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            inputMode <= 1'b0;
            btnPrev   <= 1'b0;
        end else begin
            if (modeBtn && !btnPrev)
                inputMode <= ~inputMode; // toggle between 0 and 1
            btnPrev <= modeBtn;
        end
    end
  
    // Instruction memory (ROM32K)
    
    wire [14:0] pcT;
    wire [15:0] ROM_out;

    ROM32k inst_rom (
        .address(pcT),
        .clk(clk),
        .out(ROM_out)
    );
  
    // 3. Data memory (RAM16K for now)
    
    wire [15:0] inMT, outMT;
    wire writeMTt;
    wire [14:0] addressMT;

    memory inst_mem (
        .in(outMT),
        .address(addressMT),
        .load(writeMT),
        .clk(clk),
        .out(inMT)
    );
  
    // 4. MUX: Select between ROM or manual switches
    
    wire [15:0] fin_inst = (inputMode) ? ROM_out : switches;
  
    // CPU
    
    CPU inst_cpu (
        .inM(inMT),
        .instruction(fin_inst),
        .reset(reset),
        .clk(clk),
        .outM(outMT),
        .writeM(writeMT),
        .addressM(addressMT),
        .pc(pcT)
    );

    // 6. Optional LED output to observe result
  
    assign led_output = outMT;

endmodule
