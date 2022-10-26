`timescale 1ns/1ps

module D_Flip_Flop(clk, d, q);
input clk;
input d;
output q;

wire Nclk;
not not1(Nclk, clk);

wire tem;
D_Latch latch1(Nclk, d, tem);
D_Latch latch2(clk, tem, q);

endmodule

module D_Latch(e, d, q);
input e;
input d;
output q;

wire Nd;
not not1(Nd, d);

wire tem1, tem2;
nand nand1(tem1, d, e), nand2(tem2, Nd, e);

wire Nq;
nand nand3(q, tem1, Nq), nand4(Nq, tem2, q);

endmodule