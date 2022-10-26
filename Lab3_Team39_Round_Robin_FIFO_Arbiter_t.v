`timescale 1ns/1ps

module rrfa;
    reg clk, rst_n;
    reg [3:0] wen;
    reg [7:0] a, b, c, d;
    wire valid;
    wire [7:0] dout;

    always #1 clk = ~clk;

    Round_Robin_FIFO_Arbiter rrfa(.clk(clk), .rst_n(rst_n), .wen(wen), .a(a), .b(b), .c(c), .d(d), .dout(dout), .valid(valid));

    initial begin
        clk = 1'b1;
        rst_n = 1'b0;

        #1
        a = 8'd1;
        b = 8'd2;
        c = 8'd3;
        d = 8'd4;
        rst_n = 1'b1;
        wen = 4'b1111;

        #2
        a = a + 8'b1;
        b = b + 8'b1;
        c = c + 8'b1;
        d = d + 8'b1;
        wen = 4'b0001;

        #2
        a = a + 8'b1;
        b = b + 8'b1;
        c = c + 8'b1;
        d = d + 8'b1;
        wen = 4'b0010;

        #2
        a = a + 8'b1;
        b = b + 8'b1;
        c = c + 8'b1;
        d = d + 8'b1;
        wen = 4'b0100;
        
        #2
        a = a + 8'b1;
        b = b + 8'b1;
        c = c + 8'b1;
        d = d + 8'b1;
        wen = 4'b1000;

        #2
        a = 8'b0;
        b = 8'b0;
        c = 8'b0;
        d = 8'b0;
        wen = 4'b0;

        #20
        $finish;
    end


endmodule