`timescale 1ns / 1ps

// Create Date: 04/02/2025 07:37:15 PM
// Module Name: diff_time


module diff_time(
    input wire clk, 
    input wire reset,      
    input wire d_in,      
    output reg q_out
    );
 
          

    reg q1;               
    reg comb_out1;         
    reg comb_out2;    
    reg enable;    

    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q1 <= 0;
        else
            q1 <= d_in;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            enable <= 0;
        else
            enable <= 1; 
    end
    
    always @(*) begin
        if (enable)begin
            comb_out1 = q1&1'b1;
            comb_out2 = comb_out1|1'b0;
        end
        else
            comb_out2 = q1;  
    end
        

    
    always @(posedge clk) begin
        if (reset)
            q_out <= 0;
        else
            q_out <= comb_out2; 
    end



endmodule
