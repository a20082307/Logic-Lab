`timescale 1ns/1ps

module Toggle_Flip_Flop(clk, q, t, rst_n);
input clk;
input t;
input rst_n;
output q;

wire tem1;
XOR XOR1(.in1(q), .in2(t), .out(tem1));

wire tem2;
and and1(tem2, tem1, rst_n);

DFF d1(.d(tem2), .clk(clk), .q(q));
endmodule


module DFF(clk, d, q);
input clk;
input d;
output q;

wire Nclk;
not not1(Nclk, clk);

wire tem;
DL latch1(Nclk, d, tem);
DL latch2(clk, tem, q);
endmodule


module DL(clk, d, q);
input clk;
input d;
output q;

wire Nd;
not not1(Nd, d);

wire tem1, tem2;
nand nand1(tem1, d, clk), nand2(tem2, Nd, clk);

wire Nq;
nand nand3(q, tem1, Nq), nand4(Nq, tem2, q);
endmodule


module XOR(in1, in2, out);
input in1, in2;
output out;

wire Nin1, Nin2;
not not1(Nin1, in1), not2(Nin2, in2);

wire tem1, tem2;
and and1(tem1, in1, Nin2), and2(tem2, in2, Nin1);
or or1(out, tem1, tem2);
endmodule