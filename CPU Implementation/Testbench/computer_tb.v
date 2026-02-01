module computer_tb;

    // 1. SIGNALS
    reg reset;
    reg clk;
    reg [15:0] switches;
    reg modeBtn;    
    reg stepBtn;    
    reg initialize; 
    wire [15:0] led_output;

    // 2. INSTANTIATE
    computer uut (
        .reset(reset), 
        .clk(clk), 
        .switches(switches), 
        .modeBtn(modeBtn), 
        .stepBtn(stepBtn), 
        .initialize(initialize), 
        .led_output(led_output)
    );
    
    // 3. OVERRIDE DEBOUNCERS
    defparam uut.db_mode.DEBOUNCE_LIMIT = 10;
    defparam uut.db_step.DEBOUNCE_LIMIT = 10;

    // 4. CLOCK
    always #5 clk = ~clk;

    // 5. TASKS
    task press_mode;
        begin
            modeBtn = 1; #200; modeBtn = 0; #200;       
        end
    endtask

    task press_step;
        begin
            stepBtn = 1; #200; stepBtn = 0; #200;       
        end
    endtask

    // 6. MAIN TEST
    initial begin
        // --- SETUP ---
        clk = 0; reset = 1; switches = 0;
        modeBtn = 0; stepBtn = 0; initialize = 0;

        // Reset the System
        #100; reset = 0;
        #1000; // Warm up debouncers

        // =========================================================
        // PHASE 1: INITIALIZATION (With Reset HELD HIGH)
        // =========================================================
      
        reset = 1;      
        initialize = 1; 
        #50;            
        
        // Pulse Clock (Manual Step)
        
        press_step;     
        
        // Turn off signals
        initialize = 0; 
        #50;
        reset = 0;      // Release Reset. System is ready at PC=0.
        
        #200; 

        // =========================================================
        // PHASE 2: AUTO MODE
        // =========================================================
        $display("--- 2. Switching to Auto Mode ---");

        press_mode; // Manual to Auto
        
        #5000; 
        
        // =========================================================
        // PHASE 3: MANUAL MODE
        // =========================================================

        press_mode; // Auto to Manual

        // @15
        switches = 16'b0000000000001111; press_step; 
        // D=A
        switches = 16'b1110110000010000; press_step;
        // @2
        switches = 16'b0000000000000010; press_step;
        // M=D
        switches = 16'b1110001100001000; press_step;

        #100;
        
        $finish;
    end
endmodule
