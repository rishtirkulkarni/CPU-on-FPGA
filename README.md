# CPU on FPGA – Nand2Tetris Implementation

This repository implements the hardware components of the **Nand2Tetris** computer architecture using **Verilog** on a **Basys 3 Artix‑7 FPGA**.  
It translates the concepts from *The Elements of Computing Systems* into synthesizable hardware, forming a foundation for executing Hack assembly programs and interactive applications on an FPGA.

---

## Features
- **Bottom‑up hardware design:** Implements all Part I modules from Nand2Tetris using Verilog.
- **Custom testbenches:** Ensures correctness, modularity, and reusability.
- **Synthesizable HDL code:** Designed and tested for FPGA deployment.
- **Planned application:** Run Hack assembly programs and a simplified Tetris game on FPGA hardware.

---

## Tools & Technologies
- **FPGA:** Basys 3 Artix‑7  
- **HDL:** Verilog  
- **Development Environment:** Vivado 2024.2 (with XSIM for simulation)  
- **Reference:** *The Elements of Computing Systems* by Nisan & Schocken  

---

## Project Roadmap
1. **Boolean Logic** – Basic gates (NAND, NOT, AND, OR, XOR).  
2. **Combinational Chips** – Multiplexers, demultiplexers, adders, hierarchical reuse.  
3. **Sequential Logic** – Flip‑flops, registers, counters, RAM modules.  
4. **ALU** – 16‑bit arithmetic & logic operations with control‑based functionality.  
5. **CPU** *(In Progress)* – Integrating ALU, control logic, program counter, and instruction execution.  
6. **Machine Programs** *(Planned)* – Execute Hack Assembly programs and interactive applications.  

---

## Challenges
- Adapting to hardware‑oriented thinking and writing synthesizable Verilog as a first‑time user.  
- Understanding and utilizing the Nand2Tetris Web IDE for program execution and verification.  

---

## Acknowledgments
- **MARVEL UVCE** – [https://hub.uvcemarvel.in](https://hub.uvcemarvel.in)
- Mentor: **Anish Krishnakumar** [https://github.com/anishk2]
- Peers: **A V Sohan Aiyappa** [https://github.com/AV-Sohan-Aiyappa], **Virajit G P** [https://github.com/virajitgp]
- **Noam Nisan & Shimon Schocken** – Creators of the Nand2Tetris course  

