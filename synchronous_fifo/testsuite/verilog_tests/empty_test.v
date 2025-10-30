`include "../src/simple_linear_fifo_params.vh"
module empty_test;
    reg                       wr_en, rd_en, frstn;
    reg                       clk = 0;
    reg  [`DATA_WIDTH - 1 : 0] data_in;
    wire [`DATA_WIDTH - 1 : 0] data_out;
    wire                      empty, full;

    simple_linear_fifo slf(
        .FCLK(clk),
        .FRSTN(frstn),
        .WR_EN(wr_en),
        .RD_EN(rd_en),
        .DATA_IN(data_in),
        .DATA_OUT(data_out),
        .EMPTY(empty),
        .FULL(full)
    );

    initial 
        forever #10 clk = ~clk;

    initial begin
        $monitor("Time: %g, Reset: %b, Empty: %b", $time, frstn, empty);
        #200 $finish;
    end

    initial begin
        #10 frstn = 1'b0;
        #10 frstn = 1'b1;
    end
endmodule
