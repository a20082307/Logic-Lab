`timescale 1ns/1ps

module Clock_Divider (clk, rst_n, sel, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
    input clk, rst_n;
    input [2-1:0] sel;
    output clk1_2;
    output clk1_4;
    output clk1_8;
    output clk1_3;
    output dclk;

    reg [1:0] time3;
    reg [2:0] time2;
    reg clk2, clk3, clk4, clk8, ans;

    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            time3 <= 2'b00;
            time2 <= 3'b000;
            clk2 <= 1'b1;
            clk3 <= 1'b1;
            clk4 <= 1'b1;
            clk8 <= 1'b1;
        end

        else begin
            case (time2)
                3'b001: begin
                    clk2 <= 1'b1;
                    clk4 <= 1'b0;
                    clk8 <= 1'b0;
                end
                3'b011: begin
                    clk2 <= 1'b1;
                    clk4 <= 1'b1;
                    clk8 <= 1'b0;
                end
                3'b101: begin
                    clk2 <= 1'b1;
                    clk4 <= 1'b0;
                    clk8 <= 1'b0;
                end
                3'b111: begin
                    clk2 <= 1'b1;
                    clk4 <= 1'b1;
                    clk8 <= 1'b1;
                end
                default: begin
                    clk2 <= 1'b0;
                    clk4 <= 1'b0;
                    clk8 <= 1'b0;
                end
            endcase

            case (time3) 
                2'b10: begin
                    clk3 <= 1'b1;
                    time3 <= 2'b0;
                end
                default: clk3 <= 1'b0;
            endcase

            time2 = time2 + 3'b1;
            time3 = time3 + 2'b1;
        end
    end
    // 同步

    always @(*) begin
        case (sel)
            2'b00: ans = clk2;
            2'b01: ans = clk3;
            2'b10: ans = clk4;
            2'b11: ans = clk8;
        endcase
    end
    // 非同步

    or or1(clk1_2, clk2, clk2);
    or or2(clk1_3, clk3, clk3);
    or or3(clk1_4, clk4, clk4);
    or or4(clk1_8, clk8, clk8);
    or or5(dclk, ans, ans);
endmodule
