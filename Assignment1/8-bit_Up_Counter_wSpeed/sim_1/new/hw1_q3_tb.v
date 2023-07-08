`timescale 1ns / 1ps

module hw1_q3_tb;

reg clk = 0, rst;
reg speedupdown;
wire [7:0] counter;

hw1_q3 dut(.clk(clk), .rst(rst), .counter(counter), .speedupdown(speedupdown));

always begin
    clk = ~clk;
    #5;
end

initial begin
    rst = 1;
    #10
    rst = 0;
    speedupdown = 1'b0;
    #500
    speedupdown = 1'b1;
    #500
    $finish;
end

endmodule
