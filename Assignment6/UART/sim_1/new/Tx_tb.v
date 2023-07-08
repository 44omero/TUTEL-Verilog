`timescale 1ns / 1ps


module Tx_tb#(
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate
    );

reg clk = 0;
reg send = 0;
reg [7:0] data_in;
wire data_out;
wire busy, done;
Tx dut (.clk(clk), .send(send), .data_in(data_in), .data_out(data_out), .busy(busy), .done(done));

always begin
    #2
    clk = ~clk;
end

initial begin

data_in = 8'b01010101;
#1000
send =1;

if (done)begin
#100
$finish;
end


end
endmodule
