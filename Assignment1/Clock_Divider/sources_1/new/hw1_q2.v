`timescale 1ns / 1ps

module hw1_q2(
    input clk, rst,
    input [1:0] x,
    output reg clk_out
    
    );
    integer counter=0;

   
always @(posedge clk) begin
    counter <= counter +1;
    if (~rst)begin
        clk_out <= 0;
    end
    else begin
        case (x) 
            2'b00: begin
                if(counter % 2 == 0) 
                    clk_out <= ~clk_out;
            end
            2'b01: begin
                if(counter % 4 == 0) 
                    clk_out <= ~clk_out;
            end
            2'b10: begin
                if(counter % 8 == 0) 
                    clk_out <= ~clk_out;
            end
            2'b11: begin
                if(counter % 16 == 0) 
                    clk_out <= ~clk_out;
            end
        endcase
    end
end

endmodule
