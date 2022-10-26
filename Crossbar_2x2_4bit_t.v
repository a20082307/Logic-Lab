`timescale 1ns/1ps

`timescale 1ns/1ps

module Crossbar_2x2_t;
reg [4-1:0] in1 = 4'b0000;
reg [4-1:0] in2 = 4'b0001;
reg control = 1'b0;
wire [4-1:0] out1, out2;

reg [3-1:0] times = 3'b000;
reg change = 1'b0;

Crossbar_2x2 c1(.in1(in1), .in2(in2), .out1(out1), .out2(out2), .control(control));

initial begin
	repeat (16) begin
		#1
		if (times == 3'b100) begin 
			if (change == 1'b1)
				control = control + 1'b1;

			change = ~change;
		end
		else begin
			control = control + 1'b1;
			times = times + 3'b1;
		end
		in1 = in1 + 4'b1;
		in2 = in2 + 4'b1;
		
	end
	#1 $finish;
end

endmodule
