`timescale 1ns / 1ps

module hw4_q2
    #(parameter bitcount = 64) 
    (
    input clk,rst,
    input [bitcount-1:0] inA,
    input [bitcount-1:0] inB,
    output reg [bitcount*2-1:0] out
    );
    reg [bitcount-1:0] a_hold, b_hold;
    wire [bitcount*2-1:0] out_next;
    
    localparam bitpart = bitcount/2;
    wire [bitpart-1:0] A_L, A_R;
    wire [bitpart-1:0] B_L, B_R;
        
    assign {A_L, A_R} = a_hold;
    assign {B_L, B_R} = b_hold;
    
    wire [bitcount-1:0] mleft;
    wire [bitcount-1:0] mright;
    wire [bitcount:0] sum;
    
    assign mleft = A_L * B_L;
    assign mright = A_R * B_R;
    assign sum = (A_L * B_R) + (B_L * A_R);
    
    assign out_next = (mleft*2**bitcount)+(sum * 2**bitpart) + mright;
    always @(posedge clk)begin 
        if(rst == 1) begin
            a_hold <= 0;
            b_hold <= 0;
        end
        
        else begin
            a_hold <= inA;
            b_hold <= inB;
            out <= out_next;
        end
    end
endmodule
