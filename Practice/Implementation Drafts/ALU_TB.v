`timescale 1ns / 1ps

module ALU_TB;

  // DUT inputs
  reg        clk;
  reg        zx, nx, zy, ny, f, no, initialise;
  reg [4:0]  address_a, address_b;

  // DUT outputs
  wire [15:0] result;
  wire        zr, ng;
  wire [6:0]  seg;
  wire [3:0]  an;

  // Instantiate DUT
  ALU_FPGA dut (
    .clk(clk),
    .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no), .initialise(initialise),
    .address_a(address_a), .address_b(address_b),
    .result(result), .zr(zr), .ng(ng),
    .seg(seg), .an(an)
  );

  // 100 MHz clock
  always #5 clk = ~clk;

  initial begin
    // init
    clk = 0;
    {zx,nx,zy,ny,f,no} = 6'b0;
    initialise = 0;
    address_a = 5'b00000;
    address_b = 5'b00000;

    // preload memories 
    #12 initialise = 1;
    #10 initialise = 0;
    #10;

    // TESTS 

    // --- T1: ADD (x + y)
    // ctrl = 000010 (zx=0 nx=0 zy=0 ny=0 f=1 no=0)
    // A=addr 00001 -> 0000_0000_0000_0001 ; B=addr 00010 -> 0000_0000_0000_0010
    // Expected result = 0000_0000_0000_0011, zr=0, ng=0
    address_a = 5'b00001;
    address_b = 5'b00010;
    {zx,nx,zy,ny,f,no} = 6'b000010; #20
     
    // --- T2: AND (x & y)
    // ctrl = 000000
    // A=addr 10100 -> 0101_0101_0101_0101 ; B=addr 10101 -> 1010_1010_1010_1010
    // Expected result = 0000_0000_0000_0000, zr=1, ng=0
    address_a = 5'b10100;
    address_b = 5'b10101;
    {zx,nx,zy,ny,f,no} = 6'b000000; #20

    // --- T3: OR (x | y) via ~(~x & ~y)
    // ctrl = 010101 (zx=0 nx=1 zy=0 ny=1 f=0 no=1)
    // A=0101_0101_0101_0101 ; B=1010_1010_1010_1010
    // Expected result = 1111_1111_1111_1111, zr=0, ng=1
    address_a = 5'b10100;
    address_b = 5'b10101;
    {zx,nx,zy,ny,f,no} = 6'b010101; #20 
    
    // --- T4: Edge add: +32767 + (-32768) = -1
    // ctrl = 000010 (add)
    // A=addr 01011 -> 0111_1111_1111_1111 ; B=addr 10011 -> 1000_0000_0000_0000
    // Expected result = 1111_1111_1111_1111, zr=0, ng=1
    address_a = 5'b01011;
    address_b = 5'b10011;
    {zx,nx,zy,ny,f,no} = 6'b000010; #20

    // --- T5: PASS X (x)
    // y forced to 1111_1111_1111_1111 → x & 1111_1111_1111_1111 = x
    // ctrl = 001100
    // A=addr 11101 -> 1000_0000_0000_0001
    // Expected res = 1000_0000_0000_0001, ng=1
    address_a = 5'b11101;
    address_b = 5'b00000;
    {zx,nx,zy,ny,f,no} = 6'b001100; #20 

    // --- T6: NOT X (~x)
    // ctrl = 011100
    // A=addr 01100 -> 1111_1111_1111_1111
    // Expected res = 0000_0000_0000_0000, zr=1, ng=0
    address_a = 5'b01100;
    address_b = 5'b00000;
    {zx,nx,zy,ny,f,no} = 6'b011100; #20 

    // --- T7: ZERO constant
    // ctrl = 101010 (force x=0, y=0, add)
    // Expected res = 0000_0000_0000_0000, zr=1, ng=0
    address_a = 5'b00001;
    address_b = 5'b00010;
    {zx,nx,zy,ny,f,no} = 6'b101010; #20

    // --- T8: NAND ( ~(x & y) )
    // ctrl = 000001
    // A=addr 10110 -> 0000_1111_0000_1111 ; B=addr 10111 -> 1111_0000_1111_0000
    // x&y = 0000_0000_0000_0000 → NAND = 1111_1111_1111_1111, zr=0, ng=1
    address_a = 5'b10110;
    address_b = 5'b10111;
    {zx,nx,zy,ny,f,no} = 6'b000001; #20 

    // --- T9: OR on mixed bits
    // ctrl = 010101
    // A=addr 11100 -> 0000_1000_0000_1000 ; B=addr 11101 -> 1000_0000_0000_0001
    // Expected res = 1000_1000_0000_1001, zr=0, ng=1
    address_a = 5'b11100;
    address_b = 5'b11101;
    {zx,nx,zy,ny,f,no} = 6'b010101; #20
    
    // --- T10: AND with negatives/positives
    // ctrl = 000000
    // A=addr 10001 -> 1111_1111_0000_0000 ; B=addr 01001 -> 0000_0000_1111_1111
    // Expected res = 0000_0000_0000_0000, zr=1, ng=0
    address_a = 5'b10001;
    address_b = 5'b01001;
    {zx,nx,zy,ny,f,no} = 6'b000000; #20

    // done
    #50 $finish;
  end

endmodule
