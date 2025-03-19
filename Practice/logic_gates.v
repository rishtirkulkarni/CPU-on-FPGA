module logic_gates(
    input a,b,
    output y0, y1, y2, y3, y4, y5, y6
    );
    assign y0=~a; // NOT
    assign y1=a&b; // AND
    assign y2=a|b; // OR
    assign y3=~(a&b); // NAND
    assign y4=~(a|b); // NOR
    assign y5=a^b; // EXOR
    assign y6=~(a^b); // EXNOR
    
endmodule
