`include "fifo_params.vh"
module two_flop_synchronizer(
                              input clk,
                              input [ADDR_WIDTH : 0] in,
                              output [ADDR_WIDTH : 0] reg out
                            );

    reg [ADDR_WIDTH : 0] q1;

    always @(posedge clk)
    begin
        q <= in;
        out <= q;
    end
endmodule
