`timescale 1ns/1ps

module Ripple_Carry_Adder(a, b, cin, cout, sum);
input [8-1:0] a, b;
input cin;
output cout;
output [8-1:0] sum;

wire tem1, tem2, tem3, tem4, tem5, tem6, tem7;

Full_Adder fa1(a[0], b[0], cin, tem1, sum[0]);
Full_Adder fa2(a[1], b[1], tem1, tem2, sum[1]);
Full_Adder fa3(a[2], b[2], tem2, tem3, sum[2]);
Full_Adder fa4(a[3], b[3], tem3, tem4, sum[3]);
Full_Adder fa5(a[4], b[4], tem4, tem5, sum[4]);
Full_Adder fa6(a[5], b[5], tem5, tem6, sum[5]);
Full_Adder fa7(a[6], b[6], tem6, tem7, sum[6]);
Full_Adder fa8(a[7], b[7], tem7, cout, sum[7]);    
endmodule


module Full_Adder (in1, in2, cin, cout, sum);
input in1, in2, cin;
output cout, sum;

wire temS, temC1;
Half_Adder ha1(in1, in2, temC1, temS);

wire temC2;
Half_Adder ha2(cin, temS, temC2, sum);

OR OR1(.out(cout), .in1(temC1), .in2(temC2));
endmodule

module Half_Adder(in1, in2, cout, sum);
input in1, in2;
output cout, sum;

XOR XOR1(.out(sum), .in1(in1), .in2(in2));
AND AND1(.out(cout), .in1(in1), .in2(in2));
endmodule


module AND (in1, in2, out);
input in1, in2;
output out;

wire Nans;
nand nand1(Nans, in1, in2);

nand nand2(out, Nans, Nans);
endmodule


module OR (in1, in2, out);
input in1, in2;
output out;

wire Nin1, Nin2;
nand nand1(Nin1, in1, in1), nand2(Nin2, in2, in2);

nand nand3(out, Nin1, Nin2);
endmodule


module XOR (in1, in2, out);
input in1, in2;
output out;

wire Nin1, Nin2;
nand nand1(Nin1, in1, in1), nand2(Nin2, in2, in2);

wire tem1, tem2;
nand nand3(tem1, in1, Nin2), nand4(tem2, Nin1, in2);

nand nand5(out, tem1, tem2);
endmodule