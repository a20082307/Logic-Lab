`timescale 1ns/1ps

module Mux_4x1_4bit(a, b, c, d, sel, f);
input [4-1:0] a, b, c, d;
input [2-1:0] sel;
output [4-1:0] f;

wire [4-1:0] tem1, tem2;

Mux_2x1_4bit mux1(a, b, sel[0], tem1);
Mux_2x1_4bit mux2(c, d, sel[0], tem2);
Mux_2x1_4bit mux3(tem1, tem2, sel[1], f);

endmodule

module Mux_2x1_4bit(a, b, sel, f);
input [4-1:0] a, b;
input sel;
output [4-1:0] f;

wire Nsel;
not not1(Nsel, sel);

wire [4-1:0] tem1, tem2;
and and1 [4-1:0] (tem1, a, Nsel), and2 [4-1:0] (tem2, b, sel);
or or1 [4-1:0] (f, tem1, tem2);

endmodule