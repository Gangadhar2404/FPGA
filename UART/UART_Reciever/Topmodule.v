  
`timescale 1ns/1ps

module top(
    input  wire clk,      // 100 MHz on Basys3 (W5)
    input  wire rst_btn,  // reset button (btnC)
    input  wire rs_rx,    // UART from USB-serial (connects to PC TX)
    output wire [7:0] led // LED[7:0]
);

wire tick;
wire [7:0] data_out;

wire rst = rst_btn; // active-high reset for your modules

// baudrate: parameters match your modules (100 MHz, 9600 baud)
baudrate #(
    .freq(100_000_000),
    .baud(9600)
) br (
    .clk(clk),
    .rst(rst),
    .tick(tick)
);

// receiver: uses 'tick' generated above
receiver rx_inst (
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .rx(rs_rx),
    .rx_done(),
    .data_out(data_out),
    .busy()
);

// Drive LEDs with received byte (LED[7] = MSB)
assign led = data_out;

endmodule


