module clock_divider (
    input clk,         // 100 MHz clock from Basys3
    output reg clk_1hz // 1 Hz clock output
);
    reg [26:0] count = 0; // 27 bits for 100M count

    always @(posedge clk) begin
        if (count == 99_999_999) begin
            count <= 0;
            clk_1hz <= ~clk_1hz;
        end else begin
            count <= count + 1;
        end
    end
endmodule
