# UART Full-Duplex System on Basys3 (Transmitter + Receiver)

This project implements a complete **UART Full-Duplex system** on the Basys3 FPGA board.  
It includes:

- **UART Transmitter** (FPGA → PC)
- **UART Receiver** (PC → FPGA)
- **Shared Baud Generator** (9600 baud from 100 MHz)
- **Switch-based TX input**
- **LED-based RX output**
- Tested with **Tera Term** on Windows.

All modules are written in synthesizable Verilog and mapped to Basys3 via XDC.

---

## 📌 Features

### ✔ Full UART TX + RX  
- 8 Data bits  
- 1 Stop bit  
- No parity  
- LSB-first transmission  
- Clean FSM-based design  

### ✔ FPGA ↔ PC Communication  
- Switches (SW0–SW7) → Sends a byte to PC when button pressed  
- LED[7:0] → Displays byte received from PC  

### ✔ Baudrate Generator  
- Generates `tick` at **9600 baud** from **100 MHz**  
- Single baud generator used for both TX and RX  

---

## 📁 Directory Structure

/uart_full_duplex/

├── transmitter.v

├── receiver.v

├── baudrate.v

├── uart_full_duplex_sw_tx.v # Top module

└── constraints.xdc # Basys3 pin mapping


---

## 🧠 Module Description

### 1️⃣ transmitter.v (FPGA → PC)
Implements:
- IDLE → START → DATA → STOP FSM  
- Shifts 8-bit data using LSB-first  
- `load` signal triggers transmission  
- `busy` indicates TX active  

### 2️⃣ receiver.v (PC → FPGA)
Implements:
- Detects start bit  
- Samples 8 data bits  
- Verifies stop bit  
- Outputs byte + 1-cycle `rx_done` pulse  

### 3️⃣ baudrate.v
Creates sampling tick:

tick = 100 MHz / 9600

One tick = one UART bit sample.

### 4️⃣ uart_full_duplex_sw_tx.v (Top)
- Connects TX & RX  
- Maps switches → TX byte  
- Maps received data → LEDs  
- Rising-edge button logic for `load`  
- Instantiates baudrate generator  

---

## 🧪 Tested With Tera Term

Use these serial settings:

Baud: 9600
Data: 8-bit
Parity: None
Stop: 1-bit
Flow Ctrl: None

### ✔ Sending PC → FPGA
Whatever you type in Tera Term appears on FPGA LEDs.

Example:  
Character `'A'` (0x41)  
LED pattern = `0100_0001`

### ✔ Sending FPGA → PC
Set switches to any 8-bit value.  
Press **btnU** → character appears instantly in Tera Term.

---

## 🔧 Basys3 Pin Mapping (XDC Used)

- **Clock** — W5  
- **Reset (btnC)** — U18  
- **Send Button (btnU)** — T18  
- **UART RX (PC → FPGA)** — B18  
- **UART TX (FPGA → PC)** — A18  
- **LEDs** — U16, E19, U19, V19, W18, U15, U14, V14  
- **Switches** — V17, V16, W16, W17, W15, V15, W14, W13  

---

## 👨‍💻 How to Use

1. Flash the bitstream to Basys3  
2. Open Tera Term → Select COM Port  
3. Configure UART to 9600 8N1  
4. **Receiving (PC → FPGA):**  
   - Type characters → LEDs show byte value  
5. **Transmitting (FPGA → PC):**  
   - Set SW[7:0]  
   - Press **btnU**  
   - Character appears in Tera Term  

---

## ✔ Status

- Fully functional at 9600 baud  
- Stable TX + RX  
- No metastability issues due to synchronous sampling  
- Verified on real Basys3 board  

---

## 📜 License

Open for academic, personal, and FPGA learning projects.

