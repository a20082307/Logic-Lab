`timescale 1ns/1ps

module Crossbar_4x4_4bit(in1, in2, in3, in4, out1, out2, out3, out4, control);
input [4-1:0] in1, in2, in3, in4;
input [5-1:0] control;
output [4-1:0] out1, out2, out3, out4;

wire [4-1:0] tem1, tem2_1;
Crossbar_2x2 c1(.in1(in1), .in2(in2), .out1(tem1), .out2(tem2_1), .control(control[0]));

wire [4-1:0] tem3_1, tem4;
Crossbar_2x2 c2(.in1(in3), .in2(in4), .out1(tem3_1), .out2(tem4), .control(control[3]));

wire [4-1:0] tem2_2, tem3_2;
Crossbar_2x2 c3(.in1(tem2_1), .in2(tem3_1), .out1(tem2_2), .out2(tem3_2), .control(control[2]));

Crossbar_2x2 c4(.in1(tem1), .in2(tem2_2), .out1(out1), .out2(out2), .control(control[1]));
Crossbar_2x2 c5(.in1(tem3_2), .in2(tem4), .out1(out3), .out2(out4), .control(control[4]));
endmodule


module Crossbar_2x2(in1, in2, control, out1, out2);
input [4-1:0] in1, in2;
input control;
output [4-1:0] out1, out2;

wire Ncontrol;
not not1(Ncontrol, control);

wire [4-1:0] tem1_1, tem1_2;
Dmux_1x2 d1(.a(tem1_1), .b(tem1_2), .sel(control), .in(in1));

wire [4-1:0] tem2_1, tem2_2;
Dmux_1x2 d2(.a(tem2_1), .b(tem2_2), .sel(Ncontrol), .in(in2));

Mux_2x1 m1(.a(tem1_1), .b(tem2_1), .sel(control), .out(out1));
Mux_2x1 m2(.a(tem1_2), .b(tem2_2), .sel(Ncontrol), .out(out2));
endmodule


module Mux_2x1(a, b, sel, out);
input [4-1:0] a, b;
input sel;
output [4-1:0] out;

wire Nsel;
not not1(Nsel, sel);

wire [4-1:0] tem1, tem2;
and and1 [4-1:0] (tem1, a, Nsel), and2 [4-1:0] (tem2, b, sel);
or or1 [4-1:0] (out, tem1, tem2);
endmodule


module Dmux_1x2(a, b, sel, in);
input [4-1:0] in;
input sel;
output [4-1:0] a, b;

wire Nsel;
not not1(Nsel, sel);

and and1 [3:0] (a, Nsel, in);
and and2 [3:0] (b, sel, in);
endmodule