`timescale 1ns / 1ps

module hw1_q3(
    input clk, rst, 
    input speedupdown, 
    output reg [7:0] counter
    );
    integer divcounter = 0;
    
always @(posedge clk)begin
    divcounter = divcounter+1;
    if (rst)
        counter <= 8'b0;
    else begin
        case (speedupdown)
            1'b1:begin
                counter <= counter + 8'b1;
            end
            1'b0:begin
                if(divcounter % 4 == 0)
                    counter <= counter + 8'b1;
            end
        endcase   
    end       
end

endmodule
