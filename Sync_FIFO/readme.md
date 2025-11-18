# FIFO-Based FPGA Design on Basys3

This repository contains a complete FPGA implementation of an 8-bit, 8-depth FIFO (First-In First-Out) memory using Verilog HDL.  
Designed and tested on the **Basys3 Artix-7 FPGA board**, the project demonstrates FIFO design concepts, clock division, pointer management, and real-time hardware interaction through switches, pushbuttons, and LEDs.

---

## 📂 Repository Contents

FIFO-FPGA/

├── FIFO.v # Parameterized FIFO RTL design

├── clock_divider.v # 100 MHz -> 1 Hz clock division logic

├── top.v # Top-level integration module

└── constraints.xdc # Basys3 pin mapping file


---

## 🚀 Project Overview

The project highlights fundamental RTL design concepts:

- FIFO buffer implementation  
- Read and write pointer management  
- Full and empty flag generation  
- Clock divider for slow visible operations  
- Complete hardware interfacing with Basys3 I/O  
- Clean modular architecture suitable for learning and demonstrations  

The system allows the user to manually write data into the FIFO using switches and pushbuttons, read the data back, and visualize it in real time using LEDs.

---

## 🔧 Module Descriptions

### **1. FIFO.v**
A fully parameterized FIFO module featuring:

- Configurable **width** and **depth**
- Write and read pointer logic
- Circular buffer implementation using register memory
- Synchronous read/write operations
- Full flag detection using MSB inversion technique
- Empty flag detection using pointer equality

Key logic:
- **Full Condition:**  
  `{~w_ptr[MSB], w_ptr[LSB]} == r_ptr`
- **Empty Condition:**  
  `w_ptr == r_ptr`

---

### **2. clock_divider.v**
Converts the 100 MHz Basys3 clock to **1 Hz**.

- Uses a 27-bit counter  
- Toggles output clock every 100,000,000 cycles  
- Allows users to *visually observe* FIFO operations step-by-step

---

### **3. top.v**
Integrates all modules and maps them to hardware.

Responsibilities:

- Connect switches to FIFO `data_in`
- Connect LEDs to `data_out`
- Map pushbuttons for write/read/reset
- Instantiate FIFO and clock divider
- Provide clean interface for FPGA demonstration

---

### **4. constraints.xdc**
Defines Basys3 pin mapping:

- 8 switches → FIFO input data  
- 8 LEDs → FIFO output data  
- Buttons → write enable, read enable, reset  
- LEDs → FIFO full & empty indicators  
- Clock → 100 MHz board clock  
- All mapped with **LVCMOS33** I/O standard  

This file ensures your design works immediately when loaded onto the FPGA.

---

## 🛠️ How to Build & Run

1. Open Vivado → Create a new RTL project  
2. Add all Verilog files  
3. Add the `constraints.xdc` file  
4. Run:
   - Synthesis  
   - Implementation  
   - Bitstream Generation  
5. Program the Basys3 board  
6. Use the board:
   - Set 8-bit value using switches  
   - Press **w_en** to write  
   - Press **r_en** to read  
   - Observe LED output  
   - Check full/empty status LEDs  
   - Press **rst** to reset FIFO  

---

## 🎯 Learning Outcomes

This project helps you understand:

- FIFO design principles  
- Register-based memory implementation  
- Pointer wrap-around logic  
- Synchronous digital design  
- Verilog coding best practices  
- FPGA-based prototyping  
- Clock division and timing behavior  

Perfect for students, interview preparation, or lab demonstrations.

---

## 📌 Applications

Although basic, the FIFO design is foundational for:

- UART/Serial communication buffers  
- DSP pipelines  
- Data stream decoupling  
- Clock domain crossing (in ASYNC FIFOs)  
- Embedded systems  
- Network routers and switches  

---

## 🌱 Future Enhancements

You can extend this design by adding:

- Seven-segment display output  
- UART interface for PC communication  
- Asynchronous FIFO with Gray code pointers  
- Testbench for simulation  
- AXI-stream compatible FIFO wrapper  

---

## 👨‍💻 Author
**Gangadhar**  
FPGA & RTL Design | STA | CDC | Verilog Enthusiast


