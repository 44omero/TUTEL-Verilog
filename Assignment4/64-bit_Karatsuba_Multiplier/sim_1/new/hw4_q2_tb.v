`timescale 1ns / 1ps

module hw4_q2_tb;
    reg clk=1, rst;
    reg [63:0] inA;
    reg [63:0] inB;
    wire [127:0]out;
    
hw4_q2 dut (.inA(inA), .inB(inB), .out(out), .clk(clk), .rst(rst));

always begin
    clk = ~clk;
    #10;
end

initial begin
    #1 rst <= 1;
    #1 rst <= 0;
    #1
    inA = 32'h0fffffff;
    inB = 32'hffffffff;
    #1000
    $finish;
end
endmodule
