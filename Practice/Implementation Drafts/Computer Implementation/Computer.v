// Top Computer Module
// Date: 26/09/2025

module computer(
    input reset,
    input clk_in,
    input [15:0] switches,     // manual instruction input
    input modeBtn,              // toggle between ROM and manual
    output [15:0] led_output    // shows result of computation in binary
    );
  
    // Mode selection flip-flop
    
    reg inputMode;             
    reg btnPrev;

    always @(posedge clk_in or posedge reset) begin
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
    
    wire [14:0] pc_wire;
    wire [15:0] ROM_out;

    ROM32k inst_rom (
        .address(pc_wire),
        .clk(clk_in),
        .out(ROM_out)
    );
  
    // 3. Data memory (RAM16K for now)
    
    wire [15:0] mem_out, outM_out;
    wire writeM_out;
    wire [14:0] addressM_out;

    memory inst_mem (
        .in(outM_out),
        .address(addressM_out),
        .load(writeM_out),
        .clk(clk_in),
        .out(mem_out)
    );
  
    // 4. MUX: Select between ROM or manual switches
    
    wire [15:0] instr_selected = (inputMode) ? switches : ROM_out;
  
    // CPU
    
    CPU inst_cpu (
        .inM(mem_out),
        .instruction(instr_selected),
        .reset(reset),
        .clk(clk_in),
        .outM(outM_out),
        .writeM(writeM_out),
        .addressM(addressM_out),
        .pc(pc_wire)
    );

    // 6. Optional LED output to observe result
  
    assign led_output = outM_out;

endmodule
