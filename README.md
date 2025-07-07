# Enhanced ALU (Arithmetic Logic Unit)

This project implements a fully synthesizable 16-bit signed Arithmetic Logic Unit (ALU) in Verilog, designed for academic and VLSI internship purposes.

## 💡 Features

- **16-bit signed arithmetic**
- Handles all major operations: 
  - Addition, Subtraction, Multiplication, Division
  - Bitwise AND, OR, XOR, NAND, NOR, XNOR
  - Logical Shifts (Left, Right)
- **Signed Restoring Division** using bitwise algorithm
- **Carry-Lookahead Adder (CLA)** for fast addition
- **Status Flags:**
  - `Z` (Zero)
  - `N` (Negative)
  - `C` (Carry)
  - `V` (Overflow)
- **Fully synthesizable RTL design** (Verified via toolchain synthesis)

