`include "asynchronous_fifo_params.vh"
module binary_to_gray_converter(
    input [`PTR_WIDTH - 1 : 0] b_in,
    output [`PTR_WIDTH - 1 : 0] reg g_out
);

    assign g_out = b_in ^ (b_in >> 1);
endmodule
