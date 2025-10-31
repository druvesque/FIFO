`include "asynchronous_fifo_params.vh"
module simple_linear_asynchronous_fifo (
    input                            WR_CLK,
    input                            RD_CLK, 
    input                            WR_RSTN,
    input                            RD_RSTN,
    input      [`DATA_WIDTH - 1 : 0] DATA_IN,
    input                            WR_EN,
    input                            RD_EN, 
    output reg [`DATA_WIDTH - 1 : 0] DATA_OUT,
    output                           EMPTY,
    output                           FULL
);

    // INTERNAL WIRES
    wire [`PTR_WIDTH : 0] wr_ptr, rd_ptr;
    wire [`PTR_WIDTH : 0] g_wr_ptr, g_rd_ptr;
    wire [`PTR_WIDTH : 0] g_wr_ptr_sync, g_rd_ptr_sync;
    
    // MEMORY 
    reg [`DATA_WIDTH - 1 : 0] memory ['MEM_WIDTH - 1 : 0];


    // EMPTY-FULL GENERATION VARIABLES
    reg [`PTR_WIDTH : 0] b_wr_ptr, b_rd_ptr;

    // RESET BEHAVIOUR
    integer i;
    always @(negedge FRSTN) begin: reset_condition
        if (!FRSTN)
            for (i = 0; i < `MEM_WIDTH; i = i+1)
                memory[i] = {`DATA_WIDTH{1'b0}};
    end: reset_condition
    
    // WRITE BEHAVIOUR
    always @(posedge WR_CLK, negedge FRSTN) begin: write_behaviour

        if (!FRSTN)
            wr_ptr <= {`PTR_WIDTH{1'b0}};

        else if (WR_EN && !FULL) begin
            memory[wr_ptr] <= DATA_IN; 
            wr_ptr = wr_ptr + 1;
        end

    end: write_behaviour

    // READ BEHAVIOUR
    always @(posedge FCLK, negedge FRSTN) begin: read_behaviour

        if (!FRSTN)
            rd_ptr <= {`PTR_WIDTH{1'b0}};

        else if (RD_EN && !EMPTY) begin
            DATA_OUT <= memory[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end

    end: read_behaviour
    
    // WR --> RD SYNCHRONIZATION
    binary_to_gray_converter(
        .b_in(wr_ptr), 
        .g_out(g_wr_ptr)
    );

    synchronizer(
        .clk(rd_clk), 
        .in(g_wr_ptr), 
        .out(g_wr_ptr_sync)
    );

    gray_to_binary_converter(
        .g_in(g_wr_ptr_sync), 
        .b_out(b_wr_ptr)
    );

    // RD --> WR SYNCHRONIZATION
    binary_to_gray_converter(
        .b_in(rd_ptr), 
        g_out(g_rd_ptr)
    );

    synchronizer(
        .clk(wr_clk), 
        .in(g_rd_ptr), 
        .out(g_rd_ptr_sync)
    );

    gray_to_binary_converter(
        .g_in(g_rd_ptr_sync), 
        .b_out(b_rd_ptr)
    );
    
    // EMPTY - FULL GENERATION
    assign FULL = (b_wr_ptr == `MEM_WIDTH) ? 1 : 0;
    assign EMPTY = (b_wr_ptr == b_rd_ptr) ? 1 : 0;

endmodule
