# Enhanced ALU with cocotb Verification

## 🔧 Overview
This project implements a 16-bit signed Enhanced Arithmetic Logic Unit (ALU) in Verilog. It supports multiple operations including:
- Addition, Subtraction, Multiplication, Division
- Bitwise AND, OR, XOR, NAND, NOR, XNOR

The ALU is tested using the **cocotb** Python-based verification framework and visualized using **GTKWave**.

---

## 🛠 Features

| Opcode | Operation    |
|--------|--------------|
| 0000   | ADD          |
| 0001   | SUBTRACT     |
| 0010   | MULTIPLY     |
| 0011   | DIVIDE       |
| 0100   | AND          |
| 0101   | OR           |
| 0110   | NOR          |
| 0111   | NAND         |
| 1000   | XOR          |
| 1001   | XNOR         |

