`timescale 1ns / 1ps



module uart_wrapper    #
   (parameter data_width = 8,
    parameter fifo_depth = 8,
    parameter countersize = $clog2(fifo_depth+1),
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate)
    (
    input clk, rst,
    input rx_in,
    output tx_out,
    output [countersize-1:0]memocount,
    output [data_width-1:0] data_out,
    input read, write,
    output empty, full
    );

    wire [data_width-1:0] data_in;
    wire [7:0] fullempty_msg;
    wire wr_enable, rd_enable, send_reg, rst_enable;
    
    fifo #(.data_width(data_width), .fifo_depth(fifo_depth),.countersize(countersize)) 
    fifo (.clk(clk), .rst_enable(rst_enable), .data_in(data_in), .memocount(memocount), .data_out(data_out),
     .rd_enable(rd_enable), .wr_enable(wr_enable), .empty(empty), .full(full), .fullempty_msg(fullempty_msg), .send_reg(send_reg)) ; 
    debouncer push(.clk(clk), .in(write), .out(wr_enable));
    debouncer pop(.clk(clk), .in(read), .out(rd_enable));
    debouncer reset(.clk(clk), .in(rst), .out(rst_enable));
    Tx #(.clk_freq(clk_freq), .baudrate(baudrate),.tick_per_bit(tick_per_bit))
    transmitter(.clk(clk), .data_in(fullempty_msg), .send(send_reg), .data_out(tx_out));
    Rx #(.clk_freq(clk_freq), .baudrate(baudrate),.tick_per_bit(tick_per_bit)) 
    receiver(.clk(clk), .data_in(rx_in), .data_out(data_in));
    
endmodule
