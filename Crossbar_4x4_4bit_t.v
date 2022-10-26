`timescale 1ns/1ps

`timescale 1ns/1ps

module Crossbar_4x4_t;
reg [4-1:0] in1 = 4'b0000;
reg [4-1:0] in2 = 4'b0001;
reg [4-1:0] in3 = 4'b0010;
reg [4-1:0] in4 = 4'b0011;
reg [5-1:0] control = 5'b00000;
wire [4-1:0] out1, out2, out3, out4;

Crossbar_4x4_4bit c1(in1, in2, in3, in4, out1, out2, out3, out4, control);

initial begin
	repeat (32) begin
		#1 control = control + 5'b1;
	end
	#1 $finish;
end
endmodule
