module computer(
    input reset,
    input clk,              // System Clock (100MHz)
    input [15:0] switches,  
    input modeBtn,          // SLIDE SWITCH: 1=Auto, 0=Manual
    input stepBtn,          // Button: Manual Clock "Step"
    input initialize,       
    output reg [15:0] led_output 
);
    // Clock Divider - 50Mhz
    reg slow_clk; // Initialize to 0

    always @(posedge clk or posedge reset) begin
        if (reset) begin
           slow_clk <= 0;      // Force to 0 on Reset
        end else begin
           slow_clk <= ~slow_clk; // Toggle normally otherwise
        end
    end
    // ============================================================
    // 1. DEBOUNCERS
    // ============================================================
    wire clean_mode; 
    wire clean_step;

    debouncer #(
        .TOGGLE_MODE(1)      
    ) db_mode (
        .clk(clk),
        .btn_in(modeBtn),
        .btn_out(clean_mode)  // This wire stays 1 or 0 automatically
    );

    // 2. Step Button: NORMAL (Default param is 0)
    debouncer db_step (
        .clk(clk),
        .btn_in(stepBtn),
        .btn_out(clean_step)
    );

    
    // ============================================================
    // 2. CLOCK MUX
    // ============================================================
    // If Manual Mode (Active=0) -> Use Step Button. 
    // If Auto Mode   (Active=1) -> Use System Clock.
    wire cpu_clk = (clean_mode) ? slow_clk : clean_step;

    // ============================================================
    // 3. MEMORY & CPU (Driven by cpu_clk)
    // ============================================================
    wire [14:0] pcT;
    wire [15:0] ROM_out;

    ROM32k inst_rom (
        .address(pcT),
        .clk(cpu_clk),    
        .initialize(initialize),
        .out(ROM_out)
    );

    wire [15:0] inMT, outMT;
    wire writeMT;
    wire [14:0] addressMT;

    data_memory inst_mem (
        .in(outMT),
        .address(addressMT),
        .load(writeMT),
        .clk(cpu_clk),     
        .initialize(initialize),
        .out(inMT)
    );

    // Instruction Mux: Switches (Manual) or ROM (Auto)
    wire [15:0] fin_inst = (clean_mode) ? ROM_out : switches;
    
    CPU inst_cpu (
        .inM(inMT),
        .instruction(fin_inst),
        .reset(reset),
        .clk(cpu_clk),     
        .outM(outMT),
        .writeM(writeMT),
        .addressM(addressMT),
        .pc(pcT)
    );
    
    // ============================================================
    // 4. HYBRID LED LOGIC
    // ============================================================
    
    reg [15:0] latch_value;

    // A. The Latch (Captures result for Auto Mode)
    // Runs on system clock to catch the write event reliably
    always @(posedge clk or posedge reset) begin
        if (reset) 
            latch_value <= 0;
        else if (writeMT && addressMT == 15'd2) 
            latch_value <= outMT;
    end

    // B. The Output Mux
    always @(*) begin
        if (clean_mode) 
            // Manual Mode: Real-time Memory Monitor
            // Shows content of whatever address is in A-Register
            led_output = latch_value;       
        else 
            // Auto Mode: Show the Frozen Result (RAM[2])
            led_output = inMT; 
    end

endmodule
