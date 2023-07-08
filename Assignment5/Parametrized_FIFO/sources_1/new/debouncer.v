`timescale 1ns / 1ps

module debouncer(
                input clk, in,
                output out
                );
    reg [1:0] mid;
always @(posedge clk)begin  
        mid <= {mid[0], in};
end
    
    assign out = (~mid[1]) & mid[0];
endmodule
