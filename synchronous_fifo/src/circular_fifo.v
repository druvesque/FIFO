`include "circular_fifo_params.vh"

module circular_fifo(
    input                            FCLK,
    input                            FRSTN,
    input                            WR_EN,
    input                            RD_EN,
    input      [`DATA_WIDTH - 1 : 0] DATA_IN,
    output reg [`DATA_WIDTH - 1 : 0] DATA_OUT,
    output                           EMPTY,
    output                           FULL
);

    // INTERNAL VARIABLES
    reg [`DATA_WIDTH - 1 : 0] memory [`MEM_WIDTH - 1 : 0];
    reg [`PTR_WIDTH : 0] wr_ptr, rd_ptr;
    reg [`PTR_WIDTH : 0] wr_cnt; // KEEPS TRACK OF NUMBER OF FULL BLOCKS OF MEMORY

    // RESET BEHAVIOUR
    integer i;
    always @(negedge FRSTN) begin: reset_condition

        if (!FRSTN) begin
            for (i = 0; i < `MEM_WIDTH - 1; i = i + 1)
                memory[i] = {`DATA_WIDTH{1'b0}};
            wr_cnt <= {`PTR_WIDTH{1'b0}};
        end

    end: reset_condition

    // WRITE BEHAVIOUR
    always @(posedge FCLK, negedge FRSTN) begin: write_behaviour

        if (!FRSTN)
            wr_ptr <= {`PTR_WIDTH{1'b0}};

        else if (WR_EN && !FULL) begin
            memory[wr_ptr] <= DATA_IN;
            wr_ptr <= (wr_ptr + 1) % `MEM_WIDTH;
            wr_cnt <= wr_cnt + 1;
        end

    end: write_behaviour

    // READ BEHAVIOUR
    always @(posedge FCLK, negedge FRSTN) begin: read_behaviour

        if (!FRSTN)
            rd_ptr <= {`PTR_WIDTH{1'b0}};

        else if (RD_EN && !EMPTY) begin
            DATA_OUT <= memory[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % `MEM_WIDTH;
            wr_cnt <= wr_cnt - 1;
        end
    end: read_behaviour

    // STATUS OF FIFO
    assign FULL = (wr_cnt == `MEM_WIDTH) ? 1 : 0;
    assign EMPTY = (wr_ptr == rd_ptr) ? 1 : 0;

endmodule
