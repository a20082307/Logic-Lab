`timescale 1ns/1ps

module Crossbar_2x2 (in1, in2, control, out1, out2, out11, out22);
input [4-1:0] in1, in2;
input control;
output [4-1:0] out1, out2;
output [4-1:0] out11, out22;

wire Ncontrol;
not not1(Ncontrol, control);

wire [4-1:0] tem1_1, tem1_2;
dmux d1(.in(in1), .control(control), .out1(tem1_1), .out2(tem1_2));

wire [4-1:0] tem2_1, tem2_2;
dmux d2(.in(in2), .control(Ncontrol), .out1(tem2_1), .out2(tem2_2));

mux m1(.in1(tem1_1), .in2(tem2_1), .control(control), .out(out1));
mux m2(.in1(tem1_2), .in2(tem2_2), .control(Ncontrol), .out(out2));

or or1 [4-1:0] (out11, out1, out1), or2 [4-1:0] (out22, out2, out2);
endmodule


module mux(in1, in2, control, out);
input [4-1:0] in1, in2;
input control;
output [4-1:0] out;

wire Ncontrol;
not not1(Ncontrol, control);

wire [4-1:0] tem1, tem2;
and and1 [4-1:0] (tem1, in1, Ncontrol), and2 [4-1:0] (tem2, in2, control);
or or1 [4-1:0] (out, tem1, tem2);
endmodule


module dmux(in, control, out1, out2);
input [4-1:0] in;
input control;
output [4-1:0] out1, out2;

wire Ncontrol;
not not1(Ncontrol, control);

and and1 [4-1:0] (out1, Ncontrol, in), and2 [4-1:0] (out2, control, in);
endmodule
