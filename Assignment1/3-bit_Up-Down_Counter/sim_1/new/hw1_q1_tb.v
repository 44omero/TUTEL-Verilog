`timescale 1ns / 1ps

module hw1_q1_tb;

reg clk = 0, rst, x;
wire [2:0] counter;

hw1_q1 dut (.clk(clk), .rst(rst), .x(x), .counter(counter));

always begin
    clk= ~clk;
    #5;
end

initial begin
    rst = 0;
    x = 0;
    #500
    x = 1;
    #500
    rst = 1;
    x = 0;
    #200
    rst = 0;
    $finish;
end

endmodule
