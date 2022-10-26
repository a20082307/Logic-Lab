`timescale 1ns/1ps


module Full_Adder (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;

    wire temS;
    XOR XOR1(a, b, temS);
    XOR XOR2(temS, cin, sum);
    Majority m1(a, b, cin, cout);
endmodule


module Half_Adder(a, b, cout, sum);
    input a, b;
    output cout, sum;

    XOR XOR1(.out(sum), .in1(a), .in2(b));
    AND AND1(.out(cout), .in1(a), .in2(b));
endmodule


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


module XOR (in1, in2, out);
    input in1, in2;
    output out;

    wire Nin1, Nin2;
    nand nand1(Nin1, in1, in1), nand2(Nin2, in2, in2);

    wire tem1, tem2;
    nand nand3(tem1, in1, Nin2), nand4(tem2, Nin1, in2);

    nand nand5(out, tem1, tem2);
endmodule