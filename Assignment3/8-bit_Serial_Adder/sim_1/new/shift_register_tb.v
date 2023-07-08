`timescale 1ns / 1ps

module shift_register_tb();
    reg clk = 0, enable, rst = 0, load;
    reg [7:0] sr_in;
    wire sr_out;

shift_register dut (.clk(clk), .rst(rst), .enable(enable), .load(load), .sr_in(sr_in), .sr_out(sr_out));

always begin
    #10
    clk = ~clk;
end
initial begin
    #10
    sr_in = 8'b10101010;
    load = 1;
    #10
    load = 0;
    #10
    enable = 1;
    #150
    enable = 0;
    rst = 1;
    #20
    rst = 0;
    #20
    $finish;
end
endmodule
