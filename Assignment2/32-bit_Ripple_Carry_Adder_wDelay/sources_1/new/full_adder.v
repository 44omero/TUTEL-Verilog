`timescale 1ns / 1ps

module full_adder(
    input A, B, Cin,
    output Sum, Cout
    );
    wire w1,w2,w3;
    xor #20 G1(w1, A, B); 
    and #15 G3(w2, w1, Cin);
    and #15 G4(w3, A, B);
    xor #20 G2(Sum, w1, Cin);
    or  #15 G5(Cout, w2, w3);
endmodule
