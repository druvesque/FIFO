`include "fifo_params.vh"
module gray_to_binary_converter(
                                 input [RD_PTR_WIDTH - 1 : 0] g_in,
                                 output [RD_PTR_WIDTH - 1 : 0] reg b_out
                               );

    genvar i;
    generate
        for(i = 0; i < RD_PTR_WIDTH, i = i + 1) begin
            assign b_out[i] = ^g_in[RD_PTR_WIDTH - 1 : i];
        end
    endgenerate
endmodule
