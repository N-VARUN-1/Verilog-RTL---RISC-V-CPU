# RISC-V CPU Design in Verilog HDL

## 📌 Project Overview
This project implements a **RISC-V based CPU** designed completely from scratch using **Verilog HDL**.  
The CPU was developed, simulated, and functionally verified using **Xilinx Vivado**.  
All instructions were validated through testbenches, and the simulation results matched the expected behavior.

This project focuses on **RTL-level CPU design**, emphasizing correctness, modularity, and understanding of core computer architecture concepts.

---

## 🎯 Key Objectives
- Design a RISC-V compliant CPU using Verilog HDL  
- Understand and implement core CPU components  
- Verify correct execution of RISC-V instructions through simulation  
- Validate functionality without FPGA deployment (simulation-only project)

---

## 🧠 Architecture Highlights
- **Instruction Fetch (IF)**
- **Instruction Decode (ID)**
- **Execute (EX)**
- **Memory Access (MEM)** *(if applicable)*
- **Write Back (WB)** *(if applicable)*

> The design is modular, with each stage implemented and tested independently before full integration.

---

## ⚙️ Supported Features
- RISC-V **RV32I** base instruction set *(or mention exact subset if limited)*
- Arithmetic and Logical Instructions  
- Register File implementation  
- ALU with control logic  
- Program Counter (PC) and instruction sequencing  
- Control Unit for instruction decoding

---

## 🧪 Verification & Simulation
- Developed **custom Verilog testbenches**
- Simulated using **Xilinx Vivado Simulator**
- Verified:
  - Correct instruction execution
  - Proper register updates
  - Accurate ALU operations
  - Expected control signal behavior

✔️ All test cases produced correct and validated outputs.

---

## 🛠 Tools & Technologies
- **Hardware Description Language:** Verilog HDL  
- **EDA Tool:** Xilinx Vivado  
- **Simulation:** Vivado Simulator  
- **Target:** RTL-level design (no FPGA synthesis)

---

## 📌 Current Status
- ✅ RTL Design Completed  
- ✅ Simulation Verified  
- ⏳ FPGA Implementation (In Progress)  
- ⏳ Pipeline Hazard Handling *(In Progress)*

---

## 🔮 Future Enhancements
- Add **Pipeline Hazard Detection & Forwarding**
- Implement **Control & Data Hazard Handling**
- Extend instruction support
- Add **cache/memory hierarchy**
- Synthesize and deploy on FPGA

---

## Results & Outcomes
![Waveform-1 : Clock cycles, Reset, PC and Instructions Waveform](Images/Screenshot from 2025-12-30 15-06-19.png)
![Waveform-1 : Results of ALU operations reflected in Register File](Images/Screenshot from 2025-12-30 15-06-40.png)

## 👨‍💻 Author
**N. Varun**  
---

## 📜 License
This project is intended for **learning, research, and demonstration purposes**.  
Unauthorized commercial use is not permitted.
