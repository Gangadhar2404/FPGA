module uart_full_duplex_sw_tx (
    input  wire clk,         // 100 MHz
    input  wire rst_btn,     // Reset (btnC)
    input  wire btnU,        // Send button
    input  wire [7:0] sw,    // Switches -> data to transmit
    input  wire rs_rx,       // From PC
    output wire rs_tx,       // To PC
    output wire [7:0] led    // Show received data
);

wire tick;
wire [7:0] rx_byte;


reg  load;
reg  btnU_prev;

// Baudrate 9600
baudrate #(
    .freq(100_000_000),
    .baud(9600)
) BR (
    .clk(clk),
    .rst(rst_btn),
    .tick(tick)
);

// Receiver (PC → FPGA)
receiver RX(
    .clk(clk),
    .rst(rst_btn),
    .tick(tick),
    .rx(rs_rx),
    .rx_done(),
    .data_out(rx_byte),
    .busy()
);

// Show received data on LEDs
assign led = rx_byte;

// Transmitter (FPGA → PC)
transmitter TX(
    .clk(clk),
    .rst(rst_btn),
    .load(load),
    .tick(tick),
    .data_in(sw),      // switches drive TX byte
    .tx(rs_tx),
    .busy()
);

// Rising-edge pulse for TX load
always @(posedge clk) begin
    if (rst_btn) begin
        btnU_prev <= 1'b0;
        load      <= 1'b0;
    end else begin
        btnU_prev <= btnU;
        load <= (btnU && !btnU_prev);  // trigger on button press
    end
end

endmodule
