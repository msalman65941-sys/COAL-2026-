# Computer Organization & Assembly Language (COAL) — Coursework Repository

A collection of assembly-language assignments, laboratory tasks, and small console-based programs developed as part of the **Computer Organization & Assembly Language (COAL)** coursework.

The repository focuses on understanding low-level program execution, 8086 assembly instructions, registers, memory organization, arithmetic operations, branching, loops, procedures, and practical problem solving through assembly programs.

## Repository Overview

| Area | Practical work represented |
|---|---|
| 8086 Assembly Basics | Program layout, instructions, labels, and execution flow |
| Registers & Data Movement | Working with general-purpose registers and moving data |
| Arithmetic Operations | Addition, subtraction, multiplication, division, and multi-byte arithmetic |
| Comparisons & Branching | Conditional jumps, comparisons, and decision-making |
| Loops & Iteration | Counting, summation, multiplication tables, and repeated operations |
| Arrays & Memory | Array declarations, indexing, offsets, and memory inspection |
| Data Definition | BYTE, WORD, DB, DW, DUP, EQU, TYPE, LENGTHOF, and SIZEOF |
| Procedures | Defining and calling procedures, passing values through registers, and returning results |
| DOS Interrupts | Console input/output and program termination through interrupt services |
| Practical Applications | Marks calculator, grade calculator, mini calculator, and record/result systems |

## Assignments & Laboratory Work

### Assignment 1 — Student Marks Calculator
An assembly-language marks calculator that demonstrates:

- Adding marks from multiple subjects.
- Handling carry during byte-level addition.
- Calculating total marks and percentage.
- Comparing percentage against grade thresholds.
- Displaying total, percentage, and grade.
- Using a custom procedure to print multi-digit numbers.

### Assignment 2 — Arrays and Data Declarations
The second assignment practices assembly data declarations and memory-size concepts:

- Declaring BYTE and WORD arrays.
- Initializing array elements with `DUP`.
- Declaring strings and null terminators.
- Understanding `TYPE`, `LENGTHOF`, and `SIZEOF`.
- Using `EQU` and offsets to calculate or describe storage sizes.
- Displaying array and string information.

### Lab 6 — Logic, Arithmetic, Loops & Procedures
The Lab 6 folder contains individual programs covering:

- Even or odd checking.
- Positive, negative, or zero classification.
- Finding the largest of two or three numbers.
- Counting from 1 to N and summing values.
- Generating multiplication tables.
- Factorial calculation.
- Prime number checking.
- Reversing a number and counting its digits.
- Leap year checking.
- Searching an array.
- Finding array sum and maximum.
- Calculating GCD and power through procedures.
- Grade calculation and a menu-driven mini calculator.

### Lab 8 — Application-Based Programs
The Lab 8 tasks apply assembly concepts to larger console programs:

- **Bank Account Transaction Simulator:** a practical transaction-oriented program.
- **Student Result Management System:** accepts student information and subject marks, calculates totals and percentages, assigns grades, and maintains passed/failed counts.

### Lab 9 — Memory, Arrays & Instruction Practice
The Lab 9 folder includes focused exercises on:

- Array indexing.
- Constants using `EQU`.
- Repeated data declarations using `DUP`.
- Data declarations and storage sizes.
- Debugging assembly instructions.
- Arithmetic expressions and instruction tracing.
- Memory maps and offsets.
- Number-system representation.
- String bytes.
- A mini-project marks calculation.

## Concepts & Assembly Instructions Practiced

The source files demonstrate common 8086 assembly concepts and instructions, including:

- Data movement: `MOV`, `LEA`
- Arithmetic: `ADD`, `ADC`, `SUB`, `MUL`, `DIV`, `INC`, `DEC`
- Comparison and branching: `CMP`, `JE`, `JNE`, `JA`, `JAE`, `JB`, `JMP`
- Stack operations: `PUSH`, `POP`
- Loop control: `LOOP`
- Interrupt calls: `INT 10h`, `INT 21h`
- Procedures: `PROC`, `ENDP`, `CALL`, `RET`
- Memory and data directives: `DB`, `DW`, `DUP`, `EQU`, `OFFSET`, `ORG`

These examples help connect assembly instructions with register values, flags, memory locations, and program flow.

## Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **8086 Assembly Language** | Main language used for low-level programming exercises |
| **EMU8086-compatible environment** | Suitable emulator/assembler environment for running compatible 8086 exercises |
| **emu8086.inc** | Helper macros used by selected programs |
| **DOS Interrupt Services** | Console input/output and program termination in DOS-style examples |
| **Git & GitHub** | Version control and repository hosting |

*The repository contains source code written in more than one 8086 assembly program style. Select an assembler/emulator compatible with the directives and macros used by the individual file.*

## Repository Structure

```text
COAL-2026-/
│
├── Assignment 1/
│   └── Student Marks Calculator.asm
│
├── Assignment 2/
│   ├── Arrays, DUP, TYPE, LENGTHOF & SIZEOF.asm
│   └── DWORD Arithmetic.asm
│
├── LAB 6 TASKS/
│   ├── Arithmetic & number programs
│   ├── Loop and array programs
│   ├── Searching programs
│   ├── Procedures (GCD and Power)
│   └── Mini Calculator and Grade Calculator
│
├── Lab 8 TASKS/
│   ├── Bank Account Transaction Simulator.asm
│   └── Student Result Management System.asm
│
├── Lab 9 TASKS/
│   ├── Array and memory exercises
│   ├── Data declaration exercises
│   ├── Instruction tracing and debugging
│   └── Number system and mini-project tasks
│
├── calculator.asm
├── mycode.asm
└── README.md
```

## How to Run

Assembly source files must be assembled and executed using a compatible 8086 assembler/emulator.

1. Install or open an 8086-compatible environment such as EMU8086.
2. Open the required `.asm` file.
3. Assemble/compile the source using the environment's supported syntax.
4. Run the program in the emulator.
5. Inspect register values, memory, and execution flow where the exercise requires it.

### Compatibility Notes
- Some programs use `org 100h` and DOS-style interrupt services.
- Some files use `.MODEL SMALL`, `.DATA`, and `.CODE` program structure.
- Selected tasks include `emu8086.inc` and its helper macros.
- These source styles may require different project settings; use the matching assembler/emulator mode for each file.

## Learning Outcomes

This coursework provides practical exposure to:

- Understanding how low-level instructions execute.
- Working with 8086 registers and memory addresses.
- Performing arithmetic using registers and carry/borrow behavior.
- Implementing conditional logic and loops in assembly.
- Declaring arrays, constants, and strings in memory.
- Understanding data sizes and offsets.
- Creating and calling reusable assembly procedures.
- Using the stack to preserve and retrieve values.
- Handling basic console input/output with interrupt services.
- Building small problem-solving applications using assembly language.

## Academic Note

This repository contains coursework and practice programs for learning computer organization and assembly language. Individual files are independent exercises and may use different assembler conventions.

---

**Coursework:** Computer Organization & Assembly Language (COAL)  
**Architecture Focus:** 8086  
**Primary Language:** Assembly  
**Repository:** [COAL-2026-](https://github.com/msalman65941-sys/COAL-2026-)
