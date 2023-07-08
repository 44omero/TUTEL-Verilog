`timescale 1ns / 1ps

module hw2_q2_tb;
reg [31:0] A = 0;
reg [31:0] B = 0;
wire [31:0] Ans;
wire overflow;

hw2_q2 dut (.A(A), .B(B), .Ans(Ans), .overflow(overflow));

initial begin
    #10;
    A = 32'b11111111111111111111111111111111;
    B = 32'b1;
    #10;

end
endmodule
