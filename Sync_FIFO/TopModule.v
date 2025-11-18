module top (
    input clk,              // 100 MHz Basys3 clock
    input rst,              // Active-high reset
    input w_en,             // Write enable (e.g., pushbutton)
    input r_en,             // Read enable (e.g., pushbutton)
    input [7:0] data_in,    // Input data from switches
    output [7:0] data_out,  // Output data to LEDs
    output full,            // FIFO full indicator LED
    output empty            // FIFO empty indicator LED
);

    wire clk_1hz; // Divided clock output from clock divider

    // Instantiate clock divider
    clock_divider u_clk_div (
        .clk(clk),
        .clk_1hz(clk_1hz)
    );

    // Instantiate FIFO (use divided 1 Hz clock for visible read/write on FPGA)
    FIFO #(
        .width(8),
        .depth(8)
    ) u_fifo (
        .clk(clk_1hz),
        .rst(rst),
        .w_en(w_en),
        .r_en(r_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

endmodule
