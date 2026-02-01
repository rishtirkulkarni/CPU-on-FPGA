module debouncer(
    input clk,
    input btn_in,
    output reg btn_out
);
    
    
    parameter DEBOUNCE_LIMIT = 20'hFFFFF; 
    parameter TOGGLE_MODE = 0; // New: 0=Normal, 1=Toggle/Latch

    // DEBOUNCE LOGIC
    reg [19:0] counter = 0;
    reg btn_prev = 0;
    reg clean_signal = 0; // Internal signal for the "Cleaned" button
    
    always @(posedge clk) begin
        if (btn_in == btn_prev) begin
            if (counter < DEBOUNCE_LIMIT) 
                counter <= counter + 1;
            
            if (counter == DEBOUNCE_LIMIT) 
                clean_signal <= btn_in; // Save to internal signal first
        end else begin
            counter <= 0;
            btn_prev <= btn_in;
        end
    end

    
    // This part handles the "Memory" 
    reg toggle_state = 0;
    reg prev_clean = 0;

    always @(posedge clk) begin
        if (TOGGLE_MODE == 0) begin
            // Normal Mode: Just pass the signal out directly
            btn_out <= clean_signal;
        end else begin
            // Toggle Mode: Flip state only on Rising Edge (0->1)
            if (clean_signal == 1 && prev_clean == 0) begin
                toggle_state <= ~toggle_state;
            end
            btn_out <= toggle_state;
            prev_clean <= clean_signal;
        end
    end

endmodule
