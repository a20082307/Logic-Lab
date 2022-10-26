`timescale 1ns/1ps

module Majority(a, b, c, out);
input a, b, c;
output out;

wire tem1;
AND AND1(.out(tem1), .in1(a), .in2(b));

wire tem2;
AND AND2(.out(tem2), .in1(a), .in2(c));

wire tem3;
OR OR1(.out(tem3), .in1(tem1), .in2(tem2));

wire tem4;
AND AND3(.out(tem4), .in1(b), .in2(c));

OR OR2(.out(out), .in1(tem3), .in2(tem4));
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