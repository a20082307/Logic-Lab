`timescale 1ns/1ps

module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
    input clk, rst_n;
    input enable;
    output direction;
    output [4-1:0] out;

    reg TemDir;
    reg [3:0] TemOut;

    always @(posedge clk) begin
        if (enable == 1'b1 && rst_n == 1'b1) begin
            if (TemDir == 1'b1) begin
                if (TemOut == 4'b1111) begin
                    TemOut <= TemOut - 4'b1;
                    TemDir = 1'b0;
                end
                else    TemOut <= TemOut + 4'b1;
            end
            else begin
                if (TemOut == 4'b0000) begin
                    TemOut <= TemOut + 4'b1;
                    TemDir = 1'b1; 
                end
                else    TemOut <= TemOut - 4'b1;
            end
        end
    end
    // 同步

    always @(rst_n) begin
        if (rst_n == 1'b0) begin
            TemOut = 4'b0000;
            TemDir = 1'b1;
        end
    end
    // 非同步

    or give1 [3:0] (out, TemOut, TemOut);
    or give2(direction, TemDir, TemDir);

endmodule
