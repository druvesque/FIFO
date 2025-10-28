`include "fifo_params.vh"
module binary_to_gray_converter(
                                 input [WR_PTR_WIDTH - 1 : 0] b_in,
                                 output [WR_PTR_WIDTH - 1 : 0] reg g_out
                               );

    assign g_out = b_in ^ (b_in >> 1);
endmodule
