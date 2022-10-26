`timescale 1ns/1ps

module Universal_Gate(a, b, out);
input a, b;
output out;

wire Nb;
not not1 (Nb, b);

and and1(out, a, Nb);
endmodule


