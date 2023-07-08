`timescale 1ns / 1ps

module hw2_q2
    (
    input [31:0] A, 
    input [31:0] B,
    output [31:0] Ans,
    output wire overflow
    );
    
    wire [32:0] Cout;
    wire [31:0] Sum;
    
    assign Cout[0] = 1'b0;
    
    genvar step;
    generate    
        for (step = 0 ; step < 32; step = step+1) begin
            full_adder u(.A(A[step]), 
                        .B(B[step]), 
                        .Cin(Cout[step]), 
                        .Sum(Sum[step]), 
                        .Cout(Cout[step+1])
                        );
            
        end
    endgenerate
    assign overflow = Cout[32]; 
    assign Ans = Sum;   
endmodule
