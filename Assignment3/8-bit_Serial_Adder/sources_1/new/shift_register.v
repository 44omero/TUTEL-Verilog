`timescale 1ns / 1ps
module shift_register(
    input clk, enable, rst, load,
    input [7:0] sr_in,
    output reg sr_out
    );
reg [7:0] temp_out;

always @(posedge clk or posedge rst)begin
    if(rst)
        sr_out <= 0;
    else if (load)
        temp_out <= sr_in;
    else if (enable)begin
        sr_out <= temp_out[0];
        temp_out <= temp_out >> 1;    
    end
    else
        sr_out <= sr_out;         
    end    
endmodule
