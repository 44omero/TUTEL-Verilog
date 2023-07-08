`timescale 1ns / 1ps

module hw4_q3
    #(parameter bitcount = 64) 
    (
    input clk,rst,
    input [bitcount-1:0] inA,
    input [bitcount-1:0] inB,
    output reg [bitcount*2-1:0] out
    );
    reg [bitcount-1:0] a_hold, b_hold;
    localparam bitpart = bitcount/2;
    reg [bitpart-1:0] A_L, A_R;
    reg [bitpart-1:0] B_L, B_R;
    reg [bitcount-1:0] mleft;
    reg [bitcount-1:0] mright;
    reg [bitcount:0] sum;
    always @(posedge clk)begin 
        if(rst == 1) begin
            a_hold <= 0;
            b_hold <= 0;
        end
        else begin
            a_hold <= inA;
            b_hold <= inB;
                         
            {A_L, A_R} <= a_hold;
            {B_L, B_R} <= b_hold; 
                       
            mleft <= A_L * B_L;
            mright <= A_R * B_R;
            sum <= (A_L * B_R) + (B_L * A_R);
             
            out <= (mleft*2**bitcount)+(sum * 2**bitpart) + mright; 
        end
    end
endmodule
