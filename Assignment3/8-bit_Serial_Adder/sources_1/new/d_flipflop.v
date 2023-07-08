`timescale 1ns / 1ps

module d_flipflop(
    input D,
    input clk,
    input rst,
    output reg Q
    );
always @(posedge clk or posedge rst)
    begin
        if(rst == 1)
        Q <= 0;
        else
        Q <= D;
    end
endmodule
