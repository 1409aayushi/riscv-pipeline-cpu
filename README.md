# RISC-V 5-Stage Pipelined CPU in Verilog

## Overview

This project implements a simplified 32-bit RISC-V processor using a classic 5-stage pipeline architecture in Verilog HDL.

The goal of the project is to gain hands-on experience with digital design, computer architecture, RTL development, pipelining, hazard handling, and hardware verification through simulation.

The processor is organized into the following stages:

* Instruction Fetch (IF)
* Instruction Decode (ID)
* Execute (EX)
* Memory Access (MEM)
* Write Back (WB)

The design is simulated using Icarus Verilog and waveform analysis is performed using GTKWave-compatible VCD viewers.

---

## Features

### Pipeline Stages

* Instruction Fetch Stage
* Instruction Decode Stage
* Execute Stage
* Memory Stage
* Writeback Stage

### Pipeline Registers

* IF/ID Register
* ID/EX Register
* EX/MEM Register
* MEM/WB Register

### Core Components

* Program Counter (PC)
* Instruction Memory
* Register File
* Immediate Generator
* Control Unit
* Arithmetic Logic Unit (ALU)
* Data Memory

### Hazard Handling

* Forwarding Unit
* Hazard Detection Unit

### Verification

* Individual module testbenches
* Top-level pipeline simulation
* Waveform verification using VCD files
<img width="1391" height="721" alt="image" src="https://github.com/user-attachments/assets/25f26039-2b2c-4cde-9676-b999a44b7e2d" />

---

## Project Structure

```text
riscv-pipeline-cpu/
│
├── rtl/
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── register_file.v
│   ├── immediate_generator.v
│   ├── control_unit.v
│   ├── alu.v
│   ├── fetch_stage.v
│   ├── decode_stage.v
│   ├── execute_stage.v
│   ├── memory_stage.v
│   ├── writeback_stage.v
│   ├── if_id_reg.v
│   ├── id_ex_reg.v
│   ├── ex_mem_reg.v
│   ├── mem_wb_reg.v
│   ├── forwarding_unit.v
│   ├── hazard_detection_unit.v
│   └── riscv_pipeline_top.v
│
├── tb/
│   ├── alu_tb.v
│   ├── control_unit_tb.v
│   ├── execute_stage_tb.v
│   ├── memory_stage_tb.v
│   ├── writeback_stage_tb.v
│   └── riscv_pipeline_tb.v
│
├── images/
│   └── waveform.png
│
└── README.md
```

---

## Supported Instructions

Current implementation focuses on a subset of the RV32I instruction set:

### R-Type

* ADD
* SUB
* AND
* OR

### I-Type

* ADDI
* LW

### S-Type

* SW

### B-Type

* BEQ (initial support)

---

## Simulation

Compile:

```bash
iverilog rtl/*.v tb/riscv_pipeline_tb.v
```

Run:

```bash
vvp a.out
```

Generate waveform:

```bash
gtkwave riscv_pipeline.vcd
```

---

## Sample Pipeline Flow

Example instruction sequence:

```assembly
addi x1, x0, 5
addi x2, x0, 10
add  x3, x1, x2
```

Pipeline execution:

```text
Cycle 1 : IF
Cycle 2 : IF + ID
Cycle 3 : IF + ID + EX
Cycle 4 : IF + ID + EX + MEM
Cycle 5 : IF + ID + EX + MEM + WB
```

---

## Current Status

Implemented:

* Five-stage pipeline datapath
* Pipeline registers
* Hazard detection unit
* Forwarding unit
* Top-level processor integration
* Simulation environment

Work In Progress:

* Full forwarding integration
* Load-use hazard stalling
* Branch handling and pipeline flush
* Expanded RV32I instruction support
* Automated program loading using `$readmemh`

---

## Learning Outcomes

Through this project, I gained practical experience with:

* RTL Design using Verilog
* RISC-V Instruction Formats
* Pipelined Processor Design
* Data Hazards and Control Hazards
* Forwarding and Stall Mechanisms
* Computer Architecture Fundamentals
* Digital Design Verification

---

## Future Enhancements

* Complete RV32I support
* Branch prediction
* Pipeline flushing
* CSR support
* Cache integration
* FPGA implementation
* Performance benchmarking

---
