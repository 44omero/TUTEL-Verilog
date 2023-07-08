`timescale 1ns / 1ps

module fifo_tb #(
                parameter memory_width = 8,
                parameter memory_depth = 8,
                parameter countersize = $clog2(memory_depth+1)
                );
    
    reg clk = 0, rst;
    wire empty, full;
    wire [countersize-1:0] memocount;
    reg [memory_width-1:0] data_in;
    reg rd_enable = 0, wr_enable = 0;
    wire  [memory_width-1:0]data_out; 
   
    
fifo dut (.clk(clk), .rst(rst), .data_in(data_in), .rd_enable(rd_enable), .memocount(memocount), 
            .wr_enable(wr_enable), .data_out(data_out), .empty(empty), .full(full));
            
always begin
    clk <= ~clk;
    #10;
end

initial begin
    rst <= 1;
    #10
    rst <= 0;
    #10
    wr_enable = 1;
    data_in = 3;
    #20
    data_in = 5;
    #20
    data_in = 7;
    #20
    data_in = 9;
    #20
    data_in = 2;
    #20
    data_in = 4;
    #20
    data_in = 6;
    #20
    data_in = 8;
    #20
    data_in = 1;
    #20
    data_in = 0;
    wr_enable = 0;
    rd_enable= 1;
    #160
    $finish;
    
    
end
endmodule
