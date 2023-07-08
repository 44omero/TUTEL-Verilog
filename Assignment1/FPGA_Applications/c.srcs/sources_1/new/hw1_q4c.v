`timescale 1ns / 1ps

module hw1_q4c(
    input clk,rst,
    input speedo, fbbutton,
    output reg [3:0] counter = 0,
    output reg forwardbackward
    );
    integer divider=0;
    integer bignumber = 0;
always @(posedge clk) begin
    divider <= divider +1;
    if (speedo==1) bignumber <= 500000;
    else if (speedo==0) bignumber <= 50000000;
    
    if (rst)begin
        counter <= 0;
    end
    else if (divider % bignumber == 0)begin
        case(forwardbackward)
            1'b1: begin
                counter <= counter+1;
            end
            1'b0: begin
                counter <= counter-1;
            end
        endcase
        
    end        
end

always @(posedge fbbutton)begin
	forwardbackward <= ~forwardbackward;
end
endmodule
