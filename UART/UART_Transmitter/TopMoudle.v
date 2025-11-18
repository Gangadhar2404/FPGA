
module uart_tx_manual (
    input  wire clk,
    input  wire btnC,        // reset
    input  wire btnU,        // send button
    input  wire [7:0] sw,    // DATA from switches
    output wire tx,
    output wire led_busy
);

wire tick;
wire busy;
reg  load;
reg  btnU_prev;

// Baudrate generator
baudrate #(
    .freq(100_000_000),
    .baud(9600)
) baud_inst (
    .clk(clk),
    .rst(btnC),
    .tick(tick)
);

// UART TX
transmitter tx_inst (
    .clk(clk),
    .rst(btnC),
    .load(load),
    .tick(tick),
    .data_in(sw),     // << SWITCHES DRIVE THE UART BYTE
    .tx(tx),
    .busy(busy)
);

assign led_busy = busy;

// Rising-edge pulse for button
always @(posedge clk) begin
    if (btnC) begin
        btnU_prev <= 0;
        load      <= 0;
    end else begin
        btnU_prev <= btnU;
        load <= (btnU && !btnU_prev);  // send on rising edge
    end
end

endmodule