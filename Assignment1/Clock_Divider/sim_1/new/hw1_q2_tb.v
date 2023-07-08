`timescale 1ns / 1ps

module hw1_q2_tb;

reg clk=0, rst;
reg [1:0] x;
wire clk_out;

hw1_q2 dut (.clk(clk), .rst(rst), .x(x), .clk_out(clk_out));

always begin
    #10
    clk=~clk;
end

initial begin
    rst = 0;
    #20
    rst = 1;
    x = 2'b00;
    #400
    x = 2'b01;
    #400
    x = 2'b10;
    #400
    x = 2'b11;
    #400
    $finish;
end

endmodule
