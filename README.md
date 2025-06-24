# Enhanced ALU in Verilog

This project presents a synthesizable 16-bit Enhanced Arithmetic Logic Unit (ALU) designed in Verilog. It is optimized for performance using pipelined and modular design principles, and is intended for showcasing in VLSI or hardware design internship applications.

## Features

- **Synthesizable** on standard EDA tools (e.g.Xilinx Vivado)
- **16-bit** operand support with a **32-bit** result output
- **Arithmetic Operations:**
  - Addition via four 4-bit Carry Look-Ahead Adders (CLAs) to enhance speed
  - Subtraction using 2’s complement logic and CLA
  - Pipelined multiplication to improve throughput
  - Division using the restoring division algorithm
- **Logical Operations:**
  - AND, OR, NAND, NOR, XOR, XNOR
- **Bitwise Shifts:**
  - Left Shift
  - Right Shift
- **Design Principles:**
  - Case-based control structure for operation selection
  - Modular architecture for readability, testing, and reuse

