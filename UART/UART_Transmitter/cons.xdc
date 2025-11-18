
## Clock 100 MHz
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## Reset (btnC)
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

## Transmit Trigger Button (btnU)
set_property PACKAGE_PIN T18 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]

## UART TX to USB-UART (FTDI)
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

## Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}] ;# SW0
set_property PACKAGE_PIN V16 [get_ports {sw[1]}] ;# SW1
set_property PACKAGE_PIN W16 [get_ports {sw[2]}] ;# SW2
set_property PACKAGE_PIN W17 [get_ports {sw[3]}] ;# SW3
set_property PACKAGE_PIN W15 [get_ports {sw[4]}] ;# SW4
set_property PACKAGE_PIN V15 [get_ports {sw[5]}] ;# SW5
set_property PACKAGE_PIN W14 [get_ports {sw[6]}] ;# SW6
set_property PACKAGE_PIN V14 [get_ports {sw[7]}] ;# SW7

## LED shows UART busy
set_property PACKAGE_PIN U16 [get_ports led_busy]
set_property IOSTANDARD LVCMOS33 [get_ports led_busy]


