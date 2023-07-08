`timescale 1ns / 1ps

module fifo_tb#
    (
    parameter memory_width = 8,
    parameter memory_depth = 8,
    parameter countersize = $clog2(memory_depth+1)
    );
    reg clk = 0, rst;
    wire empty, full;
    wire  [7:0]fullempty_msg;
    wire  [countersize-1:0] memocount;
    
    reg [memory_width-1:0] data_in;
    reg wr_enable=0;
    
    wire [memory_width-1:0]data_out;
    reg rd_enable=0;
    wire  send_reg;
    
    fifo dut( .clk(clk), .rst(rst), .empty(empty), .full(full), .fullempty_msg(fullempty_msg), .memocount(memocount),
     .data_in(data_in), .wr_enable(wr_enable), .data_out(data_out), .rd_enable(rd_enable), .send_reg(send_reg));
     
     always begin
     #2 clk= ~clk;
     end
     
     initial begin
     rst=1;
     #4
     rst = 0;
     wr_enable = 1;
     data_in = 5;
     #4
     data_in = 10;
     #4
     data_in = 15;
     #4
     data_in = 25;
     #4
     data_in = 35;
     #4
     data_in = 45;
     #4
     data_in = 55;
     #4
     data_in = 65;
     #4
     data_in = 75;
     #8
     wr_enable = 0;
     rd_enable= 1;
     #30
     $finish;
     end
endmodule
