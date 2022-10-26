`timescale 1ns/1ps

module Multi_Bank_Memory (clk, ren, wen, waddr, raddr, din, dout);
    input clk;
    input ren, wen;
    input [11-1:0] waddr;
    input [11-1:0] raddr;
    input [8-1:0] din;
    output [8-1:0] dout;
    
    wire wen1, wen2, wen3, wen4;
    wire ren1, ren2, ren3, ren4;
    wire [7:0] out1, out2, out3, out4;

    bank b1(clk, wen1, ren1, waddr[8:0], raddr[8:0], din, out1);
    bank b2(clk, wen2, ren2, waddr[8:0], raddr[8:0], din, out2);
    bank b3(clk, wen3, ren3, waddr[8:0], raddr[8:0], din, out3);
    bank b4(clk, wen4, ren4, waddr[8:0], raddr[8:0], din, out4);

    assign wen1 = waddr[10:9] == 2'b00 && wen;
    assign wen2 = waddr[10:9] == 2'b01 && wen;
    assign wen3 = waddr[10:9] == 2'b10 && wen;
    assign wen4 = waddr[10:9] == 2'b11 && wen;
    assign ren1 = raddr[10:9] == 2'b00 && ren;
    assign ren2 = raddr[10:9] == 2'b01 && ren;
    assign ren3 = raddr[10:9] == 2'b10 && ren;
    assign ren4 = raddr[10:9] == 2'b11 && ren;
    or or1 [7:0] (dout, out1, out2, out3, out4);

endmodule

module bank(clk, wen, ren, waddr, raddr, din, dout);
    input clk;
    input ren, wen;
    input [8:0] waddr, raddr;
    input [7:0] din;
    output [7:0] dout;

    wire wen1, wen2, wen3, wen4;
    wire ren1, ren2, ren3, ren4;
    wire [7:0] out1, out2, out3, out4;

    sub_bank sb1(clk, wen1, ren1, waddr[6:0], raddr[6:0], din, out1);
    sub_bank sb2(clk, wen2, ren2, waddr[6:0], raddr[6:0], din, out2);
    sub_bank sb3(clk, wen3, ren3, waddr[6:0], raddr[6:0], din, out3);
    sub_bank sb4(clk, wen4, ren4, waddr[6:0], raddr[6:0], din, out4);

    assign wen1 = waddr[8:7] == 2'b00 && wen;
    assign wen2 = waddr[8:7] == 2'b01 && wen;
    assign wen3 = waddr[8:7] == 2'b10 && wen;
    assign wen4 = waddr[8:7] == 2'b11 && wen;
    assign ren1 = raddr[8:7] == 2'b00 && ren;
    assign ren2 = raddr[8:7] == 2'b01 && ren;
    assign ren3 = raddr[8:7] == 2'b10 && ren;
    assign ren4 = raddr[8:7] == 2'b11 && ren;
    or or1 [7:0] (dout, out1, out2, out3, out4);
    
    
endmodule

module sub_bank(clk, wen, ren, waddr, raddr, din, dout);
    input clk;
    input ren, wen;
    input [6:0] waddr, raddr;
    input [7:0] din;
    output [7:0] dout;

    reg [7:0] out;
    assign dout = out;

    reg [7:0] memory [127:0]; 

    always @(posedge clk) begin
        if (ren) begin
            out <= memory[raddr];
        end 
        
        else if (wen) begin
            memory[waddr] <= din;
            out <= 8'b0;
        end
        
        else begin
            out <= 8'b0;
        end
    end
endmodule