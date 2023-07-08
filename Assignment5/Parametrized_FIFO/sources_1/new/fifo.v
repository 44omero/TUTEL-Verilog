`timescale 1ns / 1ps

module fifo#
    (
    parameter memory_width = 8,
    parameter memory_depth = 8,
    parameter countersize = $clog2(memory_depth+1)
    )
    (
    input clk, rst,
    output empty, full,
    output reg [countersize-1:0] memocount,
    
    input [memory_width-1:0] data_in,
    input wr_enable,
    
    output [memory_width-1:0]data_out,
    input rd_enable
    );
    //reg wr_enable, rd_enable, rst;
    //debouncer push(.clk(clk), .in(write), .out(wr_enable));
    //debouncer pop(.clk(clk), .in(read), .out(rd_enable));
    //debouncer reset(.clk(clk), .in(rst_enable), .out(rst));
    reg [memory_width-1:0] memo [memory_depth-1:0];
    reg [memory_width-1:0] memo_next [memory_depth-1:0];
    integer counter;
    
    assign empty = (memocount == 0);
    assign full = (memocount == memory_depth);
    assign data_out = memo[0];
    
    always @* begin
        for (counter = 0 ; counter < (memory_depth-1); counter = counter + 1)begin
            memo_next[counter] = memo[counter + 1];
        end
        memo_next[memory_depth-1] = (full & wr_enable) ? data_in : {memory_width{1'b0}};
    end
    
    always @(posedge clk) begin
        if(rst) begin
            memocount <= 1'b0;
        end
        else begin
            if(wr_enable & ((~rd_enable & ~full) | empty))begin
                memocount <= memocount + 1'b1;
            end
            else if(rd_enable & ~wr_enable & ~empty)begin
                memocount <= memocount - 1'b1;
            end
        end
    end
    
    always @(posedge clk) begin
        if(rst) begin
            for(counter = 0 ; counter < memory_depth; counter = counter + 1) begin
                memo[counter] <= {memory_width{1'b0}};
            end
        end
        else begin
            if (rd_enable)begin
                for(counter = 0 ; counter < memory_depth; counter = counter + 1) begin
                    memo[counter] <= (rd_enable & ((counter+1) == memocount))? data_in : memo_next[counter];
                end
            end
            else if(wr_enable & ~full)begin
                memo[memocount] <= data_in;
            end
        end
    end
endmodule
