`timescale 1ns/1ps

module Dmux_1x4_4bit(in, a, b, c, d, sel);
input [4-1:0] in;
input [2-1:0] sel;
output [4-1:0] a, b, c, d;

wire [4-1:0] tem1, tem2;

Dmux_1x2_4bit dmux1(.a(tem1), .b(tem2), .in(in), .sel(sel[1]));
Dmux_1x2_4bit dmux2(.a(a), .b(b), .in(tem1), .sel(sel[0]));
Dmux_1x2_4bit dmux3(.a(c), .b(d), .in(tem2), .sel(sel[0]));

endmodule

module Dmux_1x2_4bit(in, a, b, sel);
input [4-1:0] in;
input sel;
output [4-1:0] a, b;

wire Nsel;
not not1(Nsel, sel);

and and1 [4-1:0] (a, Nsel, in);
and and2 [4-1:0] (b, sel, in);

endmodule