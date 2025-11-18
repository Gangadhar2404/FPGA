module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3
)(
    input  wire                 wclk, rclk,
    input  wire                 wrstn, rrstn,
    input  wire                 w_en, r_en,
    input  wire [DATA_WIDTH-1:0] wdata,
    output reg  [DATA_WIDTH-1:0] rdata,
    output wire                 full, empty
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    // Memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Binary pointers
    reg [ADDR_WIDTH:0] wptr_bin, rptr_bin;

    // Gray pointers (combinational)
    wire [ADDR_WIDTH:0] wptr_gray = (wptr_bin >> 1) ^ wptr_bin;
    wire [ADDR_WIDTH:0] rptr_gray = (rptr_bin >> 1) ^ rptr_bin;

    // Synchronized pointers
    reg [ADDR_WIDTH:0] wq1_rptr, wq2_rptr;
    reg [ADDR_WIDTH:0] rq1_wptr, rq2_wptr;

    //----------------------------------------
    // WRITE DOMAIN
    //----------------------------------------
    always @(posedge wclk or negedge wrstn) begin
        if (!wrstn) begin
            wptr_bin <= 0;
            wq1_rptr <= 0;
            wq2_rptr <= 0;
        end else begin
            wq1_rptr <= rptr_gray;
            wq2_rptr <= wq1_rptr;
            if (w_en && !full) begin
                mem[wptr_bin[ADDR_WIDTH-1:0]] <= wdata;
                wptr_bin <= wptr_bin + 1'b1;
            end
        end
    end

    //----------------------------------------
    // READ DOMAIN
    //----------------------------------------
    always @(posedge rclk or negedge rrstn) begin
        if (!rrstn) begin
            rptr_bin <= 0;
            rq1_wptr <= 0;
            rq2_wptr <= 0;
            rdata    <= 0;
        end else begin
            rq1_wptr <= wptr_gray;
            rq2_wptr <= rq1_wptr;
            if (r_en && !empty) begin
                rdata <= mem[rptr_bin[ADDR_WIDTH-1:0]];
                rptr_bin <= rptr_bin + 1'b1;
            end
        end
    end

    //----------------------------------------
    // FLAG LOGIC
    //----------------------------------------
    assign full  = (wptr_gray == {~wq2_rptr[ADDR_WIDTH:ADDR_WIDTH-1], wq2_rptr[ADDR_WIDTH-2:0]});
    assign empty = (rptr_gray == rq2_wptr);

endmodule
