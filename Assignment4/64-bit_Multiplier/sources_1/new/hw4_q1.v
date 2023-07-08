`timescale 1ns / 1ps

module hw4_q1(
    input clk,rst,
    input [63:0] inA,
    input [63:0] inB,
    output reg[127:0] out
    );
    reg [63:0]a_hold,b_hold;
    wire [127:0] out_next;
    assign out_next = a_hold*b_hold;
    
    always @(posedge clk )begin 
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
