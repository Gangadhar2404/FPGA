//====================================================
// Display Formatter
// Splits hr, min, sec into individual BCD digits
//====================================================
module display_formatter (
    input  wire [5:0] sec,     // 0-59
    input  wire [5:0] min,     // 0-59
    input  wire [4:0] hr,      // 0-23
    output wire [3:0] sec_ones,
    output wire [3:0] sec_tens,
    output wire [3:0] min_ones,
    output wire [3:0] min_tens,
    output wire [3:0] hr_ones,
    output wire [3:0] hr_tens
);

    // seconds
    assign sec_ones = sec % 10;
    assign sec_tens = sec / 10;

    // minutes
    assign min_ones = min % 10;
    assign min_tens = min / 10;

    // hours
    assign hr_ones = hr % 10;
    assign hr_tens = hr / 10;

endmodule
