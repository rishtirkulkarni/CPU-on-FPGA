@R0
D=M
@SKIP1
D;JEQ              // If R0 == 0, skip to SKIP1 (result will be 0)

@MULTIPLICAND
M=D                // MULTIPLICAND = R0

@R1
D=M
@SKIP2
D;JEQ              // If R1 == 0, skip to SKIP2 (result will be 0)

@COUNTER
M=D                // COUNTER = R1

@R2
M=0                // R2 = 0 (initialize result)

(LOOP)
    @COUNTER
    D=M
    @END
    D;JEQ          // If COUNTER == 0, we're done

    @MULTIPLICAND
    D=M
    @R2
    M=D+M          // R2 += MULTIPLICAND

    @COUNTER
    M=M-1          // COUNTER--

    @LOOP
    0;JMP

(SKIP1)
(SKIP2)
@R2
M=0                // If either input was 0, result is 0

(END)
@END
0;JMP              // Infinite loop to end program
