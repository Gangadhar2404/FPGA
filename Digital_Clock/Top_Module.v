//====================================================
// Digital Clock Top Module
// Shows: Hours on LEDs, Minutes & Seconds on 7-segment
// Includes: Clock divider, Debounce, Time counter, Formatter, Refresh
//====================================================
module digital_clock_top (
    input  wire clk,          // main FPGA clock (e.g., 50 MHz)
    input  wire rst,          // reset button
    input wire en,  
    input  wire btn_min_raw,  // raw button input for minute set
    input  wire btn_hr_raw,   // raw button input for hour set
    output wire [6:0] seg,    // 7-segment segments (active low)
    output wire [3:0] an,     // 7-segment anodes (active low)
    output wire [4:0] led     // 4 LEDs showing hour (binary)
);

    //------------------------------------------------
    // 1) Generate 1Hz clock from main clock
    //------------------------------------------------
    wire clk_1Hz;
    clock_divider #(
        .DIVISOR(50000000)
    ) 
    u_div (
        .rst(rst),
        .clk_in(clk),
        .clk_out(clk_1Hz)
    );


    //------------------------------------------------
    // 3) Time Counter: counts seconds, minutes, hours
    //------------------------------------------------
    wire [5:0] sec, min;
    wire [4:0] hr;

    time_counter u_time (
        .clk_1Hz(clk_1Hz),
        .rst(rst),
        .en(en),
        .set_min(btn_min_raw),
        .set_hr(btn_hr_raw),
        .sec(sec),
        .min(min),
        .hr(hr)
    );

    //------------------------------------------------
    // 4) Display Formatter: split hr, min, sec into digits
    //------------------------------------------------
    wire [3:0] sec_ones, sec_tens;
    wire [3:0] min_ones, min_tens;
  

    display_formatter u_fmt (
        .sec(sec),
        .min(min),
        .hr(hr),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens)

    );

    //------------------------------------------------
    // 5) Refresh Display: show MM:SS on 7-segment
    //------------------------------------------------
    refresh_mux #(
        .INPUT_FREQ(50000000),
        .REFRESH_HZ(1000)
    ) u_disp (
        .clk_in(clk),
        .rst(rst),
        .d3(min_tens),  // leftmost
        .d2(min_ones),
        .d1(sec_tens),
        .d0(sec_ones),  // rightmost
        .an(an),
        .seg(seg)
    );

    //------------------------------------------------
    // 6) Show Hours on LEDs
    //------------------------------------------------
    assign led = hr[4:0];   // show lower 4 bits of hour (0-23)

endmodule
