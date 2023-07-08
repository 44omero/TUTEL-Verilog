`timescale 1ns / 1ps

module full_adder(
    input A, B, Cin,
    output Sum, Cout
    );
    wire w1,w2,w3;
    xor G1(w1, A, B);
    and G3(w2, w1, Cin);
    and G4(w3, A, B);
    xor G2(Sum, w1, Cin);
    or G5(Cout, w2, w3);
endmodule
