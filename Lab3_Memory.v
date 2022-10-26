`timescale 1ns/1ps

module Memory (clk, ren, wen, addr, din, dout);
   input clk;
   input ren, wen;
   input [7-1:0] addr;
   input [8-1:0] din;
   output [8-1:0] dout;
   reg w, r;
   reg [8-1:0] o;
   reg [8-1:0]mem[127:0];
   assign dout = o;
   always @(posedge clk)begin
      w = wen;
      r = ren;
      if(w && !r) begin
         mem[addr] = din;
      end
   end
   
   always @(posedge clk)begin
      w = wen;
      r = ren;
      if( r) begin
         o = mem[addr];
      end else begin
         o = 8'b0;
         end
   end
 endmodule
 
 
