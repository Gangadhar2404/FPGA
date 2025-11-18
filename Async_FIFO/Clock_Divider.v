module clock_divider(
    input  wire clk,     // 100 MHz board clock
    input  wire rst,
    output reg  wclk,    // write clock (2s)
    output reg  rclk     // read clock  (4s)
);

    parameter DIV_W = 100_000_000;  // toggle every 1s → 2s period
    parameter DIV_R = 200_000_000;  // toggle every 2s → 4s period

    reg [31:0] cnt_w = 0;
    reg [31:0] cnt_r = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_w <= 0; wclk <= 0;
        end else if (cnt_w == DIV_W-1) begin
            cnt_w <= 0; wclk <= ~wclk;
        end else begin
            cnt_w <= cnt_w + 1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_r <= 0; rclk <= 0;
        end else if (cnt_r == DIV_R-1) begin
            cnt_r <= 0; rclk <= ~rclk;
        end else begin
            cnt_r <= cnt_r + 1;
        end
    end
endmodule
