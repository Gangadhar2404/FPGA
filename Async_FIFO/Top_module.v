module top_async_fifo_fpga(
    input  wire clk,             // 100 MHz board clock
    input  wire rst,             // active high
    input  wire [7:0] sw,        // manual data input from switches
    input  wire btn_write,       // write pushbutton
    input  wire btn_read,        // read pushbutton
    output wire [7:0] led,       // show read data
    output wire full_led,        // full indicator
    output wire empty_led        // empty indicator
);
    // Clock signals
    wire wclk, rclk;

    // FIFO signals
    wire full, empty;
    wire [7:0] rdata;

    // Instantiate clock divider
    clock_divider clkdiv (
        .clk(clk),
        .rst(rst),
        .wclk(wclk),
        .rclk(rclk)
    );

    // Instantiate FIFO
    async_fifo fifo_inst (
        .wclk(wclk),
        .rclk(rclk),
        .wrstn(~rst),
        .rrstn(~rst),
        .w_en(btn_write),
        .r_en(btn_read),
        .wdata(sw),
        .rdata(rdata),
        .full(full),
        .empty(empty)
    );

    // Output connections
    assign led       = rdata;   // Show read data on LEDs
    assign full_led  = full;    // Indicates FIFO full
    assign empty_led = empty;   // Indicates FIFO empty

endmodule
