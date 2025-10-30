`ifndef SIMPLE_LINEAR_FIFO_PARAMS

`define SIMPLE_LINEAR_FIFO_PARAMS

`ifndef DATA_WIDTH
    `define DATA_WIDTH 4
`endif

`ifndef MEM_WIDTH
    `define MEM_WIDTH 8
    `define PTR_WIDTH $clog2(`MEM_WIDTH)
`endif

`endif
