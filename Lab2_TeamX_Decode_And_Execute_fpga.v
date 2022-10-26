`timescale 1ns/1ps

`include "Universal_Gate.v"

module Decode_And_Execute(SW, signal, reset);
    input [11-1:0] SW;
    output [7-1:0] signal;
    output [3:0] reset;
    wire [4-1:0] rd;

    set s(reset);
    Mux_8to1 m1(.out(rd), .in1(SW[6:3]), .in2(SW[10:7]), .sel(SW[2:0]), .signal(signal));
endmodule

//============================== Question
module AddSub(in1, in2, mode, out);
    input [3:0] in1, in2;
    input mode;
    output [3:0] out;

    
    wire [3:0] tem;
    XOR XOR1(.out(tem[0]), .in1(in2[0]), .in2(mode));
    XOR XOR2(.out(tem[1]), .in1(in2[1]), .in2(mode));
    XOR XOR3(.out(tem[2]), .in1(in2[2]), .in2(mode));
    XOR XOR4(.out(tem[3]), .in1(in2[3]), .in2(mode));
    
    wire [3:0] temC;
    FullAdder fa1(.sum(out[0]), .in1(in1[0]), .in2(tem[0]), .cin(mode), .cout(temC[0]));
    FullAdder fa2(.sum(out[1]), .in1(in1[1]), .in2(tem[1]), .cin(temC[0]), .cout(temC[1]));
    FullAdder fa3(.sum(out[2]), .in1(in1[2]), .in2(tem[2]), .cin(temC[1]), .cout(temC[2]));
    FullAdder fa4(.sum(out[3]), .in1(in1[3]), .in2(tem[3]), .cin(temC[2]), .cout(temC[3]));
endmodule


module BitOr(in1, in2, out);
    input [3:0] in1, in2;
    output [3:0] out;
    
    OR OR1(.out(out[0]), .in1(in1[0]), .in2(in2[0]));
    OR OR2(.out(out[1]), .in1(in1[1]), .in2(in2[1]));
    OR OR3(.out(out[2]), .in1(in1[2]), .in2(in2[2]));
    OR OR4(.out(out[3]), .in1(in1[3]), .in2(in2[3]));
endmodule


module BitAnd(in1, in2, out);
    input [3:0] in1, in2;
    output [3:0] out;
    
    AND AND1(.out(out[0]), .in1(in1[0]), .in2(in2[0]));
    AND AND2(.out(out[1]), .in1(in1[1]), .in2(in2[1]));
    AND AND3(.out(out[2]), .in1(in1[2]), .in2(in2[2]));
    AND AND4(.out(out[3]), .in1(in1[3]), .in2(in2[3]));
endmodule


module RS(in, out);
    input [3:0] in;
    output [3:0] out;
    
    OR OR1(.out(out[3]), .in1(in[3]), .in2(in[3]));
    OR OR2(.out(out[0]), .in1(in[1]), .in2(in[1]));
    OR OR3(.out(out[1]), .in1(in[2]), .in2(in[2]));
    OR OR4(.out(out[2]), .in1(in[3]), .in2(in[3]));
endmodule


module LS(in, out);
    input [3:0] in;
    output [3:0] out;
    
    AND AND1(.out(out[1]), .in1(in[0]), .in2(in[0]));
    AND AND2(.out(out[2]), .in1(in[1]), .in2(in[1]));
    AND AND3(.out(out[3]), .in1(in[2]), .in2(in[2]));
    AND AND4(.out(out[0]), .in1(in[3]), .in2(in[3]));
endmodule


module LT(in1, in2, out);
    input [3:0] in1, in2;
    output [3:0] out;
    
    wire [3:0] Nin1, Nin2;
    NOT_4bits n1(.out(Nin1), .in(in1));
    NOT_4bits n2(.out(Nin2), .in(in2));
    
    wire [3:0] buffer1, buffer2;
    BitAnd ba1(.out(buffer1), .in1(Nin1), .in2(in2));
    BitAnd ba2(.out(buffer2), .in1(in1), .in2(Nin2));

    wire [3:0] x;
    NOR_4bits r1(.out(x), .in1(buffer1), .in2(buffer2));

    wire [2:0] tem;
    AND AND1(.out(tem[0]), .in1(x[3]), .in2(buffer1[2]));
    AND_3in a1(.out(tem[1]), .in1(x[3]), .in2(x[2]), .in3(buffer1[1]));
    AND_4in a2(.out(tem[2]), .in1(x[3]), .in2(x[2]), .in3(x[1]), .in4(buffer1[0]));

    wire ans;
    OR_4in o1(.out(ans), .in1(buffer1[3]), .in2(tem[0]), .in3(tem[1]), .in4(tem[2]));

    OR OR1(.out(out[0]), .in1(ans), .in2(ans));
    OR OR2(.out(out[1]), .in1(1'b1), .in2(1'b1));
    OR OR3(.out(out[2]), .in1(1'b0), .in2(1'b0));
    OR OR4(.out(out[3]), .in1(1'b1), .in2(1'b1));
endmodule


module EQ(in1, in2, out);
    input [3:0] in1, in2;
    output [3:0] out;
    
    wire [3:0] Nin1, Nin2;
    NOT_4bits n1(.out(Nin1), .in(in1));
    NOT_4bits n2(.out(Nin2), .in(in2));
    
    wire [3:0] buffer1, buffer2;
    BitAnd ba1(.out(buffer1), .in1(Nin1), .in2(in2));
    BitAnd ba2(.out(buffer2), .in1(in1), .in2(Nin2));

    wire [3:0] x;
    NOR_4bits r1(.out(x), .in1(buffer1), .in2(buffer2));

    wire ans;
    AND_4in a1(.out(ans), .in1(x[0]), .in2(x[1]), .in3(x[2]), .in4(x[3]));

    OR OR1(.out(out[0]), .in1(ans), .in2(ans));
    OR OR2(.out(out[1]), .in1(1'b1), .in2(1'b1));
    OR OR3(.out(out[2]), .in1(1'b1), .in2(1'b1));
    OR OR4(.out(out[3]), .in1(1'b1), .in2(1'b1));
endmodule
//==============================

module ug(a, b, out);
    input a, b;
    output out;
    Universal_Gate ug1(.a(a), .b(b), .out(out));
endmodule

//==============================Gates
module NOT(in, out);
    input in;
    output out;
    
    ug ug1(.out(out), .a(1'b1), .b(in));
endmodule


module AND(in1, in2, out);
    input in1, in2;
    output out;
    
    wire Nin2;
    ug ug1(.out(Nin2), .a(1'b1), .b(in2));
    
    ug ug2(.out(out), .a(in1), .b(Nin2));
endmodule


module NAND(in1, in2, out);
    input in1, in2;
    output out;
    
    wire Nin2;
    ug ug1(.out(Nin2), .a(1'b1), .b(in2));
    
    wire Nout;
    ug ug2(.out(Nout), .a(in1), .b(Nin2));
    
    ug ug3(.out(out), .a(1'b1), .b(Nout));
endmodule


module OR(in1, in2, out);
    input in1, in2;
    output out;
    
    wire Nin1, Nin2;
    ug ug1(.out(Nin1), .a(1'b1), .b(in1)), ug2(.out(Nin2), .a(1'b1), .b(in2));
    
    NAND NAND1(.out(out), .in1(Nin1), .in2(Nin2));
endmodule


module NOR(in1, in2, out);
    input in1, in2;
    output out;
    
    wire Nin1, Nin2;
    ug ug1(.out(Nin1), .a(1'b1), .b(in1)), ug2(.out(Nin2), .a(1'b1), .b(in2));
    
    wire Nout;
    NAND NAND1(.out(Nout), .in1(Nin1), .in2(Nin2));

    ug ug3(.out(out), .a(1'b1), .b(Nout));
endmodule


module XOR(in1, in2, out);
    input in1, in2;
    output out;
    
    wire tem1, tem2;
    ug ug1(.out(tem1), .a(in1), .b(in2)), ug2(.out(tem2), .a(in2), .b(in1));
    
    OR OR1(.out(out), .in1(tem1), .in2(tem2));
endmodule
//==============================


//==============================Other
module FullAdder(in1, in2, cin, cout, sum);
    input in1, in2, cin;
    output cout, sum;
    
    wire temS, temC1;
    XOR XOR1(.out(temS), .in1(in1), .in2(in2));
    AND AND1(.out(temC1), .in1(in1), .in2(in2));
    
    wire temC2;
    XOR XOR2(.out(sum), .in1(cin), .in2(temS));
    AND AND2(.out(temC2), .in1(cin), .in2(temS));
    
    OR OR1(.out(cout), .in1(temC1), .in2(temC2));
endmodule


module NOT_4bits(in, out);
    input [3:0] in;
    output [3:0] out;

    NOT NOT1(.out(out[0]), .in(in[0]));
    NOT NOT2(.out(out[1]), .in(in[1]));
    NOT NOT3(.out(out[2]), .in(in[2]));
    NOT NOT4(.out(out[3]), .in(in[3]));
endmodule


module NOR_4bits(in1, in2, out);
    input [3:0] in1, in2;
    output [3:0] out;
    
    NOR NOR1(.out(out[0]), .in1(in1[0]), .in2(in2[0]));
    NOR NOR2(.out(out[1]), .in1(in1[1]), .in2(in2[1]));
    NOR NOR3(.out(out[2]), .in1(in1[2]), .in2(in2[2]));
    NOR NOR4(.out(out[3]), .in1(in1[3]), .in2(in2[3]));
endmodule


module AND_3in(in1, in2, in3, out);
    input in1, in2, in3;
    output out;
    
    wire tem;
    AND AND1(.out(tem), .in1(in1), .in2(in2));
    AND AND2(.out(out), .in1(tem), .in2(in3));
endmodule


module AND_4in(in1, in2, in3, in4, out);
    input in1, in2, in3, in4;
    output out;

    wire tem;
    AND_3in a1(.out(tem), .in1(in1), .in2(in2), .in3(in3));

    AND AND1(.out(out), .in1(tem), .in2(in4));    
endmodule


module OR_4in(in1, in2, in3, in4, out);
    input in1, in2, in3, in4;
    output out;

    wire [1:0] tem;
    OR OR1(.out(tem[0]), .in1(in1), .in2(in2));
    OR OR2(.out(tem[1]), .in1(tem[0]), .in2(in3));
    OR OR3(.out(out), .in1(tem[1]), .in2(in4));
endmodule
//==============================


//==============================Mux
module Mux_8to1 (in1, in2, sel, out, signal);
    input [2:0] sel;
    input [3:0] in1, in2;
    output [3:0] out;
    output [6:0] signal;

    wire [3:0] ans1, ans2, ans3, ans4, ans5, ans6, ans7, ans8;
    AddSub as1(.out(ans1), .in1(in1), .in2(in2), .mode(1'b1));
    AddSub as2(.out(ans2), .in1(in1), .in2(in2), .mode(1'b0));
    BitOr bo1(.out(ans3), .in1(in1), .in2(in2));
    BitAnd ba1(.out(ans4), .in1(in1), .in2(in2));
    RS rs1(.out(ans5), .in(in2));
    LS ls1(.out(ans6), .in(in1));
    LT lt1(.out(ans7), .in1(in1), .in2(in2));
    EQ eq1(.out(ans8), .in1(in1), .in2(in2));

    wire [3:0] tem1, tem2;
    Mux_4to1 m1(.out(tem1), .in1(ans1), .in2(ans2), .in3(ans3), .in4(ans4), .sel(sel[1:0]));
    Mux_4to1 m2(.out(tem2), .in1(ans5), .in2(ans6), .in3(ans7), .in4(ans8), .sel(sel[1:0]));
    Mux_2to1 m3(.out(out), .in1(tem1), .in2(tem2), .sel(sel[2]));

    Binary_to_HexNum bth1(out, signal);
endmodule


module Mux_4to1 (in1, in2, in3, in4, sel, out);
    input [1:0] sel;
    input [3:0] in1, in2, in3, in4;
    output [3:0] out;

    wire [3:0] tem1, tem2;
    Mux_2to1 m1(.out(tem1), .in1(in1), .in2(in2), .sel(sel[0]));
    Mux_2to1 m2(.out(tem2), .in1(in3), .in2(in4), .sel(sel[0]));
    Mux_2to1 m3(.out(out), .in1(tem1), .in2(tem2), .sel(sel[1]));
endmodule


module Mux_2to1 (in1, in2, sel, out);
    input sel;
    input [3:0] in1, in2;
    output [3:0] out;

    wire [3:0] Ns, s;
    AND AND1(.out(s[0]), .in1(sel), .in2(sel));
    AND AND2(.out(s[1]), .in1(sel), .in2(sel));
    AND AND3(.out(s[2]), .in1(sel), .in2(sel));
    AND AND4(.out(s[3]), .in1(sel), .in2(sel));
    NOT_4bits n1(.out(Ns), .in(s));

    wire [3:0] tem1, tem2;
    BitAnd b1(.out(tem1), .in1(in1), .in2(Ns));
    BitAnd b2(.out(tem2), .in1(in2), .in2(s));

    BitOr bo1(.out(out), .in1(tem1), .in2(tem2));
endmodule
//==============================


//==============================  signal
module Binary_to_HexNum (in, out);
    input [3:0] in;
    output [6:0] out;

    wire [6:0] Nout;

    wire tem1_1, tem1_2, tem1_3, tem1_4, tem1_5, tem1_6;
    and and_0101(tem1_1, ~in[3], in[2], ~in[1], in[0]);
    and and_1001(tem1_2, in[3], ~in[2], ~in[1], in[0]);
    and and_X11X(tem1_3, in[2], in[1]);
    and and_0X1X(tem1_4, ~in[3], in[1]);
    and and_1XX0(tem1_5, in[3], ~in[0]);
    and and_X0X0(tem1_6, ~in[2], ~in[0]);
    or or1(Nout[0], tem1_1, tem1_2, tem1_3, tem1_4, tem1_5, tem1_6);

    wire tem2_1, tem2_2, tem2_3, tem2_4, tem2_5;
    and and_0100(tem2_1, ~in[3], in[2], ~in[1], ~in[0]);
    and and_1101(tem2_2, in[3], in[2], ~in[1], in[0]);
    and and_0111(tem2_3, ~in[3], in[2], in[1], in[0]);
    and and_00XX(tem2_4, ~in[3], ~in[2]);
    and and_X00X(tem2_5, ~in[2], ~in[1]);
    or or2(Nout[1], tem2_1, tem2_2, tem2_3, tem2_4, tem1_6, tem2_5);

    wire tem3_1, tem3_2, tem3_3, tem3_4, tem3_5;
    and and_10XX(tem3_1, in[3], ~in[2]);
    and and_XX01(tem3_2, ~in[1], in[0]);
    and and_01XX(tem3_3, ~in[3], in[2]);
    and and_0X0X(tem3_4, ~in[3], ~in[1]);
    and and_0XX1(tem3_5, ~in[3], in[0]);
    or or3(Nout[2], tem3_1, tem3_2, tem3_3, tem3_4, tem3_5);

    wire tem4_1, tem4_2, tem4_3, tem4_4, tem4_5, tem4_6, tem4_7;
    and and_0000(tem4_1, ~in[3], ~in[2], ~in[1], ~in[0]);
    and and_0011(tem4_2, ~in[3], ~in[2], in[1], in[0]);
    and and_0010(tem4_3, ~in[3], ~in[2], in[1], ~in[0]);
    and and_0110(tem4_4, ~in[3], in[2], in[1], ~in[0]);
    and and_1110(tem4_5, in[3], in[2], in[1], ~in[0]);
    and and_1011(tem4_6, in[3], ~in[2], in[1], in[0]);
    and and_1X0X(tem4_7, in[3], ~in[1]);
    or or4(Nout[3], tem4_1, tem4_2, tem4_3, tem1_1, tem4_4, tem4_5, tem4_6, tem4_7);

    wire tem5_1, tem5_2, tem5_3;
    and and_1X1X(tem5_1, in[3], in[1]);
    and and_11XX(tem5_2, in[3], in[2]);
    and and_XX10(tem5_3, in[1], ~in[0]);
    or or5(Nout[4], tem1_6, tem1_5, tem5_1, tem5_2, tem5_3);

    wire tem6_1, tem6_2;
    and and_XX00(tem6_1, ~in[1], ~in[0]);
    and and_X1X0(tem6_2, in[2], ~in[0]);
    or or6(Nout[5], tem6_1, tem3_1, tem5_1, tem6_2, tem1_1);

    wire tem7_1, tem7_2;
    and and_1XX1(tem7_1, in[3], in[0]);
    and and_X01X(tem7_2, ~in[2], in[1]);
    or or7(Nout[6], tem2_1, tem1_1, tem3_1, tem7_1 ,tem7_2, tem5_3);
    
    not n1 [6:0] (out, Nout);
endmodule

module set(reset);
    inout [3:0] reset;
    
    and and1(reset[0], 1'b0, 1'b0);
    and and2(reset[1], 1'b1, 1'b1);
    and and3(reset[2], 1'b1, 1'b1);
    and and4(reset[3], 1'b1, 1'b1);
endmodule
//==============================