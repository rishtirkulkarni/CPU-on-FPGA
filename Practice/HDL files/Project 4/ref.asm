// Rishti  
// 11-05-20205
// Multiplying numbers using repeated addition

@R0
D=M
@0
D;JEQ          // If R0 is 0, result is 0
@MULTIPLICAND
M=D            // Store R0 in MULTIPLICAND

@R1
D=M
@0
D;JEQ          // If R1 is 0, result is 0
@COUNTER
M=D            // Store R1 in COUNTER

@R2
M=0            // Clear R2 (accumulator)

(LOOP)
    @COUNTER
    D=M
    @END
    D;JEQ      // If counter == 0, we're done

    @MULTIPLICAND
    D=M
    @R2
    M=D+M      // R2 += MULTIPLICAND

    @COUNTER
    M=M-1      // counter--

    @LOOP
    0;JMP

(END)
    // Infinite loop just to end the program
    @END
    0;JMP
