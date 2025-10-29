
module clock_divider #(
    parameter DIVISOR = 50000000   // divide 50 MHz → 1 Hz
)(
    input  wire clk_in,    // main FPGA clock
    input  wire rst,       // synchronous reset (active high)
    output reg  clk_out    // divided clock output
);

    // need log2(DIVISOR) bits to count
    localparam WIDTH = $clog2(DIVISOR);
    reg [WIDTH-1:0] counter = 0;

    always @(posedge clk_in) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == (DIVISOR - 1)) begin
                counter <= 0;
                clk_out <= ~clk_out;  // toggle output every half period
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule

 