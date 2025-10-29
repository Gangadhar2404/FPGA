//====================================================
// Refresh (Multiplexing) Module with Internal Clock Divider
// Generates its own ~1kHz refresh clock for switching digits
// Active-Low outputs (for Common-Anode 7-seg display)
//====================================================
module refresh_mux #(
    parameter INPUT_FREQ = 50000000,  // main FPGA clock (e.g. 50 MHz)
    parameter REFRESH_HZ = 1000       // target refresh frequency
)(
    input  wire clk_in,       // main board clock
    input  wire rst,          // active high reset
    input  wire [3:0] d3,     // leftmost digit
    input  wire [3:0] d2,
    input  wire [3:0] d1,
    input  wire [3:0] d0,     // rightmost digit
    output reg  [3:0] an,     // anode control (active low)
    output wire [6:0] seg     // segment output (active low)
);

    //------------------------------------------------
    // 1) Internal clock divider to make ~1kHz refresh clock
    //------------------------------------------------
    localparam integer COUNT_MAX = INPUT_FREQ / (2 * REFRESH_HZ);
    reg [31:0] count = 0;
    reg clk_refresh = 0;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_refresh <= 0;
        end else begin
            if (count >= COUNT_MAX - 1) begin
                count <= 0;
                clk_refresh <= ~clk_refresh;
            end else
                count <= count + 1;
        end
    end

    //------------------------------------------------
    // 2) Digit selection counter (2 bits for 4 digits)
    //------------------------------------------------
    reg [1:0] sel = 0;
    always @(posedge clk_refresh or posedge rst) begin
        if (rst)
            sel <= 0;
        else
            sel <= sel + 1;
    end

    //------------------------------------------------
    // 3) Choose which digit to display
    //------------------------------------------------
    reg [3:0] current_digit;
    always @(*) begin
        case (sel)
            2'd0: begin an = 4'b1110; current_digit = d0; end // rightmost
            2'd1: begin an = 4'b1101; current_digit = d1; end
            2'd2: begin an = 4'b1011; current_digit = d2; end
            2'd3: begin an = 4'b0111; current_digit = d3; end // leftmost
            default: begin an = 4'b1111; current_digit = 4'd0; end
        endcase
    end

    //------------------------------------------------
    // 4) Seven segment decoder for the selected digit
    //------------------------------------------------
    seven_seg u_seg (
        .digit(current_digit),
        .seg(seg)
    );

endmodule
