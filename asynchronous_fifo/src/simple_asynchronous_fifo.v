`include "fifo_params.vh"

module simple_asynchronous_fifo (
    input                           wr_clk,
    input                           rd_clk, 
    input                           rstn,
    input      [DATA_WIDTH - 1 : 0] data_in,
    input                           wr_en,
    input                           rd_en, 
    output reg [DATA_WIDTH - 1 : 0] data_out,
    output                          empty,
    output                          full
);

endmodule
