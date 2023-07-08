`timescale 1ns / 1ps

module hw3_q1_tb;

reg [7:0] A;
reg [7:0] B;
reg clk=0, rstn=0, start;

wire [8:0] sum;
wire Cout, enable, load;

hw3_q1 dut(.clk(clk), .A(A), .B(B), .rstn(rstn), .Cout(Cout), .load(load), .start(start), .enable(enable), .sum(sum)) ;

always begin
#10
clk <= ~clk;
end

initial begin
rstn=1;
#10
rstn=0;
start=1;
A = 8'd255;
B = 8'd255;
#300
$finish;

end

endmodule
