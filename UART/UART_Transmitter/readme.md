# UART Transmitter – FPGA (Verilog)

A complete UART Transmitter implemented on FPGA using Verilog, tested with Tera Term.  
The design sends an 8-bit data byte through UART by loading values from switches and pressing a trigger button.

---

## 📌 Project Overview

This project includes:

- UART Transmitter (8-bit, 9600 baud)
- Baud Rate Generator (100 MHz → 9600 baud)
- Manual trigger-based transmission using FPGA switches
- Busy indicator output
- Rising-edge detection for button press
- Fully tested with Tera Term serial monitor

The TX signal is routed to the FPGA’s USB-UART (FTDI) interface.

---

## 🧩 Modules Description

### 1️⃣ `baudrate.v`
Generates a single-cycle tick at 9600 Hz from a 100 MHz input clock.

- Counter = `100_000_000 / 9600`
- Tick is used by the transmitter to shift each UART bit

### 2️⃣ `transmitter.v`
Implements the UART transmitter FSM:

State | Description
------|------------
IDLE  | Line stays HIGH (idle state)
START | Sends start bit (0)
DATA  | Shifts 8 data bits (LSB first)
STOP  | Sends stop bit (1) and returns to IDLE

Also provides:
- `tx` = serialized data output  
- `busy` = transmitter occupied indicator  

### 3️⃣ `uart_tx_manual.v` (Top Module)
- Reads 8 switches → data byte
- Uses `btnU` rising-edge to load & start transmission
- Uses `btnC` as reset
- Connects baud generator + transmitter
- Drives `tx` out to FTDI
- Displays UART busy status on LED

---

## 🖥️ Using Tera Term

1. Connect FPGA board using USB cable  
2. Open **Tera Term → Serial → Select FTDI COM port**
3. Set the serial settings:

Baud : 9600
Data Bits : 8
Parity : None
Stop Bits : 1
Flow Ctrl : None


4. On FPGA:
   - Set `sw[7:0]` to desired data
   - Press **btnU**
   - The transmitted byte appears in Tera Term

---

## 📌 Example

If switches are set to:

0110_0001


This is `0x61` → ASCII `'a'`.

Press **btnU**, Tera Term displays:


a


---

## 📁 FPGA Pin Constraints (XDC)

Includes mapping for:

- `clk` (100 MHz)
- Reset button `btnC`
- Send button `btnU`
- UART TX pin
- Switches `sw[0]`–`sw[7]`
- Busy LED

---

## 🧪 Testing Status

- Verified with Tera Term
- All data patterns tested
- Busy LED sync confirmed
- Clean UART waveform observed on logic analyzer

---

## 📦 Files in Project

transmitter.v
baudrate.v
uart_tx_manual.v
constraints.xdc
README.md

---


