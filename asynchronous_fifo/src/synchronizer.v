`include "asynchronous_fifo_params.vh"
module synchronizer(
    input clk,
    input [`PTR_WIDTH : 0] in,
    output [`PTR_WIDTH : 0] reg out
);

    reg [`ADDR_WIDTH : 0] q1;

    always @(posedge clk)
    begin
        q <= in;
        out <= q;
    end

endmodule
