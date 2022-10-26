`timescale 1ns/1ps

module NAND_Implement (a, b, sel, out);
input a, b;
input [3-1:0] sel;
output out;

Mux_8to1 m1(.out(out), .in1(a), .in2(b), .sel(sel));
endmodule


module AND (in1, in2, out);
input in1, in2;
output out;

wire N_ans;
nand nand1(N_ans, in1, in2);
// N_ans is the opposite of right ans

nand nand2(out, N_ans, N_ans);
// Turn the N_ans to the right ans
endmodule


module OR (in1, in2, out);
input in1, in2;
output out;

wire N_in1, N_in2;
nand nand1(N_in1, in1, in1), nand2(N_in2, in2, in2);

nand nand3(out, N_in1, N_in2);
endmodule


module NOR (in1, in2, out);
input in1, in2;
output out;

wire N_in1, N_in2;
nand nand1(N_in1, in1, in1), nand2(N_in2, in2, in2);

wire N_ans;
nand nand3(N_ans, N_in1, N_in2);

nand nand4(out, N_ans, N_ans);
endmodule


module XOR (in1, in2, out);
input in1, in2;
output out;

wire N_in1, N_in2;
nand nand1(N_in1, in1, in1), nand2(N_in2, in2, in2);

wire tem1, tem2;
nand nand3(tem1, in1, N_in2), nand4(tem2, N_in1, in2);

nand nand5(out, tem1, tem2);
endmodule


module XNOR (in1, in2, out);
input in1, in2;
output out;

wire N_in1, N_in2;
nand nand1(N_in1, in1, in1), nand2(N_in2, in2, in2);

wire tme1, tem2;
nand nand3(tem1, in1, N_in2), nand4(tem2, N_in1, in2);

wire N_ans;
nand nand5(N_ans, tem1, tem2);

nand nand6(out, N_ans, N_ans);
endmodule


module NOT (in, out);
input in;
output out;

nand nand1(out, in, in);
endmodule


module Mux_8to1 (in1, in2, sel, out);
input [2:0] sel;
input in1, in2;
output out;

wire ans1, ans2, ans3, ans4, ans5, ans6, ans7, ans8;
nand nand1(ans1, in1, in2);
AND AND1(.out(ans2), .in1(in1), .in2(in2));
OR OR1(.out(ans3), .in1(in1), .in2(in2));
NOR NOR1(.out(ans4), .in1(in1), .in2(in2));
XOR XOR1(.out(ans5), .in1(in1), .in2(in2));
XNOR XNOR1(.out(ans6), .in1(in1), .in2(in2));
NOT NOT1(.out(ans7), .in(in1)), NOT2(.out(ans8), .in(in1));

wire tem1, tem2;
Mux_4to1 m1(.out(tem1), .in1(ans1), .in2(ans2), .in3(ans3), .in4(ans4), .sel(sel[1:0]));
Mux_4to1 m2(.out(tem2), .in1(ans5), .in2(ans6), .in3(ans7), .in4(ans8), .sel(sel[1:0]));
Mux_2to1 m3(.out(out), .in1(tem1), .in2(tem2), .sel(sel[2]));
endmodule


module Mux_4to1 (in1, in2, in3, in4, sel, out);
input [1:0] sel;
input in1, in2, in3, in4;
output out;

wire tem1, tem2;
Mux_2to1 m1(.out(tem1), .in1(in1), .in2(in2), .sel(sel[0]));
Mux_2to1 m2(.out(tem2), .in1(in3), .in2(in4), .sel(sel[0]));
Mux_2to1 m3(.out(out), .in1(tem1), .in2(tem2), .sel(sel[1]));
endmodule


module Mux_2to1 (in1, in2, sel, out);
input in1, in2, sel;
output out;

wire N_sel;
NOT NOT1(.out(N_sel), .in(sel));

wire tem1, tem2;
AND AND1(.out(tem1), .in1(in1), .in2(N_sel));
AND AND2(.out(tem2), .in1(in2), .in2(sel));

OR OR1(.out(out), .in1(tem1), .in2(tem2));
endmodule