//====================================================
// Time Counter for Digital Clock
// Counts seconds, minutes, hours
// Includes manual setting for hour & minute
// Enable Signal To Stop the Clock
//====================================================
module time_counter (
    input  wire clk_1Hz,     // 1 Hz clock input
    input  wire rst,  
    input wire en,       // active-high reset
    input  wire set_min,     // manual minute increment button
    input  wire set_hr,      // manual hour increment button
    output reg [5:0] sec,    // 0-59
    output reg [5:0] min,    // 0-59
    output reg [4:0] hr      // 0-23
);
    //------------------------------------------------
    // Seconds counter
    //------------------------------------------------
    always @(posedge clk_1Hz or posedge rst) begin
        if (rst)
            sec <= 0;
         else if(en==1'b1) 
            sec<=sec;
        else if (sec == 59)
            sec <= 0;
        else
            sec <= sec + 1;
    end

    //------------------------------------------------
    // Minutes counter
    //------------------------------------------------
    always @(posedge clk_1Hz or posedge rst) begin
        if (rst)
            min <= 0;
        else if(en==1'b1)begin
               min<=min;
                 if (set_min) // manual set
                   min <= (min == 59) ? 0 : min + 1;
             end
        else if (sec == 59)
            min <= (min == 59) ? 0 : min + 1;
    end

    //------------------------------------------------
    // Hours counter
    //------------------------------------------------
    always @(posedge clk_1Hz or posedge rst) begin
        if (rst)
            hr <= 0;
        else if(en==1'b1) begin
            hr<=hr;
              if (set_hr) // manual set
            hr <= (hr == 23) ? 0 : hr + 1;
         end
        else if ((min == 59) && (sec == 59))
            hr <= (hr == 23) ? 0 : hr + 1;
    end
endmodule
