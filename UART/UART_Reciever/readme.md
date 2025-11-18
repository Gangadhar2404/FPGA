# UART Receiver – FPGA (Verilog, Basys3)

This project implements a UART Receiver on the Basys3 FPGA and displays incoming serial data on the 8 onboard LEDs.  
The FPGA receives bytes from the PC using the built-in USB-UART (FTDI) interface and reconstructs the 8-bit data using a UART state machine.

---

## 📌 Features

- UART receiver (8 data bits, no parity, 1 stop bit)
- Baud rate: **9600**
- Start-bit detection and oversampling using tick
- RX shift register with LSB-first sampling
- Byte output via LEDs
- Tera Term tested (PC → FPGA)
- Clean 4-state FSM: IDLE → START → DATA → STOP

---

## 🧩 Module Overview

### 1️⃣ **receiver.v**
Implements the UART receive logic:

State | Meaning
------|---------
IDLE  | Waits for start bit (rx = 0)
START | Verifies start bit at baud tick
DATA  | Shifts 8 incoming data bits
STOP  | Checks stop bit and finalizes byte

Outputs:
- `data_out[7:0]` = received byte  
- `rx_done` = 1-cycle "data valid" pulse  
- `busy` = receiver in active frame  

---

### 2️⃣ **baudrate.v**
Generates baud ticks from 100 MHz → 9600 Hz:

ccpt = 100_000_000 / 9600

One tick = sample point for UART.

---

### 3️⃣ **top.v**
Hardware connection for Basys3:
- RX from FTDI → FPGA pin
- Byte → LEDs
- btnC → reset

---

## 🖥️ Using With Tera Term

1. Connect Basys3 board to PC via USB
2. Open Tera Term  
3. Select the COM port labeled **USB Serial / FTDI**
4. Configure:

Baud : 9600
Data Bits : 8
Parity : None
Stop Bits : 1
Flow Ctrl : None


5. Type characters in Tera Term → they appear as LED patterns:
   - `'A'` (0x41) → `0100_0001`
   - `'g'` (0x67) → `0110_0111`

---

## 📁 Project Structure

uart_rx_fpga/

├── receiver.v

├── baudrate.v

├── top.v

└── constraints.xdc


---

## 🔌 Basys3 Pins Used

- `clk` → W5  
- `rst_btn` → U18  
- `rs_rx` (UART input from PC) → B18  
- `led[7:0]` → U16, E19, U19, V19, W18, U15, U14, V14  

All provided in the XDC file.

---

## 🧪 Testing Status

✔ Fully tested using Tera Term  
✔ Correct sampling of start, data, and stop bits  
✔ LEDs update correctly for all ASCII inputs  
✔ Stable at 9600 baud  

---


