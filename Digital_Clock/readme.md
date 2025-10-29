# 🕒 FPGA Digital Clock (Verilog)



This project implements a **Digital Clock on FPGA** using Verilog HDL.  
It displays **Minutes:Seconds** on a 4-digit 7-segment display and **Hours** on LEDs.  
The design is modular and easy to understand, ideal for **beginners learning Verilog and FPGA-based digital systems**.

> **Note:** This project is designed for **simulation and FPGA testing** on boards like **Basys 3** or **Nexys A7**.

---

## **Features**

- **Modular Design** (Each function in a separate Verilog file)
- Displays **MM:SS** on a 4-digit 7-segment display  
- Displays **Hours (0–23)** on LEDs  
- **1 Hz clock generation** from 50 MHz input clock  
- Manual control for **setting hours and minutes**  
- **Pause/Enable control** for time counting  
- **Supports active-low (common-anode) 7-segment displays**
- Designed for easy simulation and understanding

---

## **Module Overview**

| Module Name | Description |
|--------------|-------------|
| `clock_divider.v` | Divides 50 MHz system clock down to 1 Hz for time counting |
| `refresh_mux.v` | Refreshes (multiplexes) the 4 digits at ~1 kHz frequency |
| `seven_seg.v` | Converts 4-bit BCD input to active-low 7-segment pattern |
| `display_formatter.v` | Splits hour, minute, and second values into individual BCD digits |
| `time_counter.v` | Counts seconds, minutes, hours; supports pause and manual set |
| `digital_clock_top.v` | Integrates all modules into a complete working clock system |

---

## **Block Diagram**
        +--------------------------------------+
        |           Digital Clock              |
        |--------------------------------------|
        |                                      |
        |   +--------------------------+       |
 clk --->|-->|      Clock Divider      |--> clk_1Hz
        |   +--------------------------+       |
        |                |                     |
        |   +--------------------------+       |
        |   |       Time Counter       |---> hr, min, sec
        |   +--------------------------+       |
        |                |                     |
        |   +--------------------------+       |
        |   |    Display Formatter     |---> BCD digits
        |   +--------------------------+       |
        |                |                     |
        |   +--------------------------+       |
        |   |       Refresh MUX        |---> seg, an
        |   +--------------------------+       |
        |                                      |
        +--------------------------------------+



---

## **Inputs and Outputs**

| Signal | Direction | Description |
|--------|------------|-------------|
| `clk` | Input | Main FPGA clock (typically 50 MHz) |
| `rst` | Input | Active-high reset |
| `en` | Input | Enable / Pause control |
| `btn_min_raw` | Input | Push button to increment minutes |
| `btn_hr_raw` | Input | Push button to increment hours |
| `seg[6:0]` | Output | 7-segment segment lines (active low) |
| `an[3:0]` | Output | 7-segment digit enables (active low) |
| `led[4:0]` | Output | Binary display of current hour |

---

## **Vivado Simulation / FPGA Setup**

### **Requirements**
- **Xilinx Vivado** (for simulation or synthesis)
- FPGA board such as **Basys 3** or **Nexys A7**

### **Steps**
1. Create a new **RTL Project** in Vivado.
2. Add all `.v` files from this project.
3. Set `digital_clock_top` as the **Top Module**.
4. (Optional) Add an `.xdc` file for FPGA pin mapping.
5. For simulation:
   - Create a simple testbench (`tb_digital_clock.v`).
   - Reduce the `DIVISOR` in `clock_divider.v` (e.g., to 10) for faster visible output.
6. Run **Behavioral Simulation** to observe seconds, minutes, and hours increment.

---

## **Sample Display Output**

| Hours (LEDs) | Display (7-Segment) | Meaning |
|---------------|--------------------|----------|
| 00010 | 01:23 | 2 hours, 1 minute, 23 seconds |
| 01001 | 12:45 | 9 hours, 12 minutes, 45 seconds |
| 10111 | 59:59 | 23 hours, 59 minutes, 59 seconds |

---

## **Advantages**

- Clear modular structure for each sub-function  
- Simple design — easy to simulate and debug  
- Teaches clock division, counters, and 7-segment multiplexing  
- Suitable for educational labs and mini-projects  

---

## **Limitations**

- No AM/PM or date feature  
- No alarm or stopwatch functionality  
- Manual button debouncing not included  
- Fixed 24-hour format only  

---

## **Future Improvements**

- Add **debounce and edge-detect** logic for button inputs  
- Add **AM/PM** display mode (12-hour format)  
- Include **alarm** or **stopwatch** feature  
- Implement **FPGA synthesis** with full pin mapping  
- Add **LCD** or **serial interface** for time display  

---

## **Author**

**Gangadhar K**  
Electronics & Communication Engineering  
Government SKSJTI, Bangalore  

---

## **License**

For **educational and learning purposes only**.  
Freely modifiable and redistributable with credit.


