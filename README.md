# Enhanced ALU (Arithmetic Logic Unit) – 16-bit Signed

This project implements a fully functional **enhanced ALU** capable of performing signed 16-bit arithmetic and logic operations. The design is written in synthesizable **Verilog HDL** and includes a custom testbench to verify its correctness across a variety of input combinations.

## ✅ Features

- **Signed Arithmetic Operations:**
  - Addition (with carry and overflow detection)
  - Subtraction
  - Multiplication (signed 16×16 → 32-bit)
  - Division (restoring division algorithm with sign support)

- **Logical & Bitwise Operations:**
  - AND, OR, XOR, NOR, NAND, XNOR
  - Left and right shift (logical)

- **Status Flags:**
  - `Z` (Zero)
  - `N` (Negative)
  - `C` (Carry)
  - `V` (Overflow)

- **Testbench Verification:**
  - All operations verified using a dedicated Verilog testbench
  - Includes signed input combinations (positive & negative)

- **Synthesizable Design:**
  - Successfully passed **RTL elaboration and synthesis** in Vivado
  - Modular, reusable design suitable for FPGA/ASIC projects

## 📁 File Structure



