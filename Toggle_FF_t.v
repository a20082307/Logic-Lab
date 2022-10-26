`timescale 1ns/1ps

`timescale 1ns/1ps

module TFF_t;
reg t = 1'b0;
reg reset = 1'b1;
reg clk = 1'b0;
wire q;

always #(1) clk = ~clk;

Toggle_Flip_Flop t1(clk, q, t, reset);

reg [3-1:0] times = 3'b000;

initial begin
	repeat (16) begin
		@(negedge clk) t = ~t;
					   times = times + 3'b1;

		if (times == 3'b101) begin
			reset = ~reset;
			times = 3'b000;
		end
		// reset every 5 unit time

	end
	#1 $finish;
end
endmodule
