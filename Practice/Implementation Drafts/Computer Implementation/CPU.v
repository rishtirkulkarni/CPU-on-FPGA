//CPU module
//26/09/2025

module CPU(
    input [15:0] inM,
    input [15:0] instruction,
    input reset,
    input clk,
    output [15:0] outM,
    output writeM,
    output [14:0] addressM,
    output [14:0] pc
    );
    
    reg [15:0] Areg, Dreg;
    
    wire inst_c = instruction[15];
    
    wire jgt = instruction[0];
    wire jeq = instruction[1];
    wire jlt = instruction[2];
    
    wire destA = instruction[3];
    wire destD = instruction[4];
    wire destM = instruction[5];
    
    wire a_bit = instruction[12];
   
    assign addressM = Areg[14:0];
   
    wire [15:0] y_sel = (a_bit) ? inM : Areg;
    wire [15:0] alu_out;
    wire        zr, ng;    
   
    ALU alu_inst (
        .x(Dreg),
        .y(y_sel),
        .zx(instruction[6]),
        .nx(instruction[7]),
        .zy(instruction[8]),
        .ny(instruction[9]),
        .f(instruction[10]),
        .no(instruction[11]),
        .out(alu_out),
        .zr(zr),
        .ng(ng)
    );
      
    assign outM = alu_out;
    assign writeM =  inst_c & destM;
      
    wire loadA = (~inst_c) | (inst_c & destA);
    wire loadD = inst_c & destD;
      
    wire [15:0] A_in = (~inst_c) ? instruction : alu_out;
      
    wire cond_lt = ng;
    wire cond_eq = zr;
    wire cond_gt = (~zr) & (~ng);
      
    wire take_jump = inst_c & (
        (jgt & cond_gt) |
        (jeq & cond_eq) |
        (jlt & cond_lt)
    );

    wire [15:0] pc_out16; 
       
    pc pc_inst (
        .in(Areg),
        .reset(reset),
        .load(take_jump),
        .inc(1'b1),
        .clk(clk),
        .out(pc_out16)
    );
      
    assign pc = pc_out16[14:0];
      
    always @(posedge clk) begin
        if (loadA)  
            Areg <= A_in;
        if (loadD)
            Dreg <= alu_out;
    end
      
endmodule
