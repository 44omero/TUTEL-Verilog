`timescale 1ns / 1ps

module hw4_q3_tb;
    reg clk=1, rst;
    reg [63:0] inA;
    reg [63:0] inB;
    wire [127:0]out;
    
hw4_q3 dut (.inA(inA), .inB(inB), .out(out), .clk(clk), .rst(rst));

always begin
    clk = ~clk;
   #2;
end

initial begin
    #1 rst <= 1;
    #1 rst <= 0;
    #10
    inA = 64'hffffffffffffffff;
    inB = 64'hffffffffffffffff;
    #300
    #1 rst <= 1;
    #1 rst <= 0;
    #10
    inA = 64'h00fffffffabcfff;
    inB = 64'h0000abcf;
        #300
    #1 rst <= 1;
    #1 rst <= 0;
    #10
    inA = 64'h00fffffffa123fff;
    inB = 64'h0000a12354f;
    #1000
    
    $finish;
end
endmodule
