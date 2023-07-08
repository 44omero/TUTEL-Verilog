`timescale 1ns / 1ps

module fifo#(
    parameter data_width = 8,
    parameter fifo_depth = 8,
    parameter countersize = $clog2(fifo_depth+1)
    )(
    input clk, rst_enable,
    output empty, full,
    output reg [countersize-1:0]memocount = 0,
    output reg send_reg, 
    output reg [7:0]fullempty_msg,
    
    input [data_width-1:0]data_in,
    input wr_enable,
    
    output reg [data_width-1:0]data_out,
    input rd_enable
    );
    reg[data_width-1:0]memo[fifo_depth-1:0];
    reg [2:0] rd_ptr = 3'b000;
    reg [2:0] wr_ptr = 3'b000;
    
    assign empty = (memocount == 0);
    assign full  = (memocount == fifo_depth);
    
//    always @(posedge clk) begin
//        memo [0] <= 65;
//        memo [1] <= 66;
//        memo [2] <= 67;
//        memo [3] <= 68;
//        memo [4] <= 69;
//        memo [5] <= 70;
//        memo [6] <= 71;
//        memo [7] <= 72;
//    end
    always @(posedge clk) begin: fullempty
        if(empty && !full) begin
            fullempty_msg <= 8'b01100101;
            send_reg <= 1;
        end
        else if (!empty && full)begin
            fullempty_msg <= 8'b01100110;
            send_reg <= 1;
        end
        else send_reg <= 0;
    end
    always @(posedge clk) begin: writeblk
        if(wr_enable == 1'b1 & full == 1'b0)
            memo[wr_ptr] <= data_in;
        else if (wr_enable && rd_enable)
            memo[wr_ptr] <= data_in;
    end
    always @(posedge clk) begin: readblk
        if(rd_enable && !empty)
            data_out <= memo[rd_ptr];
        else if (rd_enable && wr_enable)
            data_out <= memo[rd_ptr];
    end
    always @(posedge clk) begin: ptrblk
//        rd_ptr <= 0;
//            wr_ptrr <= 0;
        if(rst_enable) begin
            rd_ptr <= 0;
            wr_ptr <= 0;
        end
        else begin
            wr_ptr <= ((wr_enable == 1'b1 & full == 1'b0) ||(wr_enable && rd_enable))? wr_ptr + 1'b1 : wr_ptr;
            rd_ptr <= ((rd_enable && !empty)||(wr_enable && rd_enable))? rd_ptr +1'b1  : rd_ptr;
        end
    end
    always @(posedge clk) begin: memocountblk
        if(rst_enable) begin
            memocount <= 0;
        end
        else begin
            if (!wr_enable && !rd_enable)  memocount <= memocount;
            if (!wr_enable && rd_enable) memocount <= (memocount == 0) ? 0: memocount-1;
            if (wr_enable && !rd_enable) memocount <= (memocount == 8) ? fifo_depth : memocount+1;
            if (wr_enable && rd_enable)  memocount <= memocount;
            
//            case({wr_enable,rd_enable})
//                2'b00   : memocount <= memocount;
//                2'b01   : memocount <= (memocount == 0) ?     0      : memocount-1;
//                2'b10   : memocount <= (memocount == 8) ? fifo_depth : memocount+1;
//                2'b11   : memocount <= memocount;
//                default : memocount <= memocount;
//            endcase
        end
    end
endmodule
