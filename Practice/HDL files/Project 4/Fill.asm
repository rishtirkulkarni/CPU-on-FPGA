(START)
    @KBD
    D=M              // Read keyboard input
    @BLACK
    D;JNE            // If key is pressed (non-zero), jump to BLACK
    @WHITE
    0;JMP            // Else, jump to WHITE

(BLACK)
    @SCREEN
    D=A
    @ADDR
    M=D              // Initialize address = SCREEN base (16384)

    @8192
    D=A
    @COUNT
    M=D              // Set count = 8192 (number of words on screen)

(BLACK_LOOP)
    @COUNT
    D=M
    @START
    D;JEQ            // If COUNT == 0, jump to START (done)

    @ADDR
    A=M
    M=-1             // Write 0xFFFF (black) to current screen word

    @ADDR
    M=M+1            // addr++
    @COUNT
    M=M-1            // count--
    @BLACK_LOOP
    0;JMP

(WHITE)
    @SCREEN
    D=A
    @ADDR
    M=D              // Initialize address = SCREEN

    @8192
    D=A
    @COUNT
    M=D              // Set count = 8192

(WHITE_LOOP)
    @COUNT
    D=M
    @START
    D;JEQ            // If COUNT == 0, jump to START

    @ADDR
    A=M
    M=0              // Write 0 to current screen word

    @ADDR
    M=M+1            // addr++
    @COUNT
    M=M-1            // count--
    @WHITE_LOOP
    0;JMP
