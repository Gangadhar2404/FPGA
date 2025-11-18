# Async FIFO on FPGA (Verilog)

This repository contains an implementation of an **Asynchronous FIFO** using Verilog, along with FPGA integration, clock divider logic, and pin-constraint mappings.

---

## 📌 Project Overview

This design implements an asynchronous FIFO using:
- Binary write/read pointers  
- Gray code conversion  
- Pointer synchronization (2-FF CDC)  
- Full/Empty flag detection logic  

Two different clock domains are generated from the 100 MHz system clock:
- **wclk** → Write clock (2-second period)  
- **rclk** → Read clock (4-second period)

FIFO depth = `2^ADDR_WIDTH`.

---

## 📁 Repository Structure

/Async-FIFO-FPGA/

├── async_fifo.v           # FIFO RTL design

├── clock_divider.v        # Clock divider for write/read domains

├── top_async_fifo_fpga.v  # FPGA top module

├── constraints.xdc        # Pin mapping for FPGA board

└── README.md              # Documentation


---

## ⚙️ How It Works

### **Write Operation**
- Press **btn_write**
- Data from switches `sw[7:0]` is written into FIFO
- Write pointer increments only when FIFO is **not full**

### **Read Operation**
- Press **btn_read**
- FIFO outputs the data to LEDs `led[7:0]`

### **Status LEDs**
- `full_led`  → FIFO is full  
- `empty_led` → FIFO is empty  

---

## 🧠 Key Concepts Used

- Binary → Gray pointer encoding  
- 2-FF synchronizers across clock domains  
- Asynchronous reset domains  
- Full/Empty flag logic based on pointer comparison  
- FPGA top-level wiring  
- Use of on-chip RAM (`reg [ ] mem`)  

---

## 🕒 Clock Divider Details

The divider converts 100 MHz to slow clocks for visual observation:

| Signal | Toggle Rate | Output Period |
|--------|-------------|----------------|
| wclk   | 1 second    | 2 seconds      |
| rclk   | 2 seconds   | 4 seconds      |

These slow clocks allow you to clearly see FIFO operations on LEDs.

---

## 🔌 FPGA Pin Connections (XDC)

- SW0–SW7 → Input data  
- LEDs → Read data  
- Buttons:  
  - `btn_write` → Write  
  - `btn_read` → Read  
  - `rst` → Reset  

Full XDC file included in `/constraints.xdc`.

---

## ▶️ Usage Instructions (FPGA Demo)

1. Program FPGA with generated bitstream  
2. Set switches `sw[7:0]` for your data  
3. Press **Write** to store into FIFO  
4. Press **Read** to display data on LEDs  
5. Check **Full/Empty LED indicators**  

---

## 🚀 Future Enhancements

- UART display of FIFO contents  
- Add BRAM support for deeper FIFO  
- Add testbench + simulation waveforms  
- Add OLED/7-segment visualization  

---

## 👤 Author

**Gangadhara K**  
Electronics & Communication Engineer  
RTL • Digital Design • Verilog • FPGA

---

