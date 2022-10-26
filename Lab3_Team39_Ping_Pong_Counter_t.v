`timescale 1ns/1ps

module test;
    reg clk, rst_n, enable;
    wire direction;
    wire [3:0] out;

    always #1 clk = ~clk;

    Ping_Pong_Counter ppc1(.clk(clk), .rst_n(rst_n), .enable(enable), .direction(direction), .out(out));

    initial begin
        clk = 1'b1;
        rst_n = 1'b1;
        enable = 1'b0;

        #0.5 
        rst_n = 1'b0;

        #0.5
        rst_n = 1'b1;
        enable = 1'b1;

        #10 rst_n = 1'b0;
        #5 rst_n = 1'b1;
        #10 enable = 1'b0;
        #5 enable = 1'b1;

        #35 enable = 1'b0;
        #5 enable = 1'b1;
        #10 rst_n = 1'b0;
        #5 rst_n = 1'b1;

        #100;
        #1 $finish;
    end

endmodule