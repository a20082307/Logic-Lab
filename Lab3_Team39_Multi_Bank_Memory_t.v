`timescale 1ns/1ps

module mbm;
    reg clk;
    reg wen, ren;
    reg [10:0] waddr, raddr;
    reg [7:0] din;
    wire [7:0] dout;

    always #1 clk = ~clk;

    Multi_Bank_Memory mbm1(.clk(clk), .wen(wen), .ren(ren), .waddr(waddr), .raddr(raddr), .din(din), .dout(dout));

    initial begin
        clk = 1'b0;
        wen = 1'b0;
        ren = 1'b0;
        waddr = 11'b0;
        raddr = 11'b0;
        din = 8'b0;

        repeat(10) begin
            #2 
            wen = 1'b1;
            din = din + 8'b1;
            waddr = waddr + 11'b1;
        end
        repeat(10) begin
            #2
            ren = 1'b1;
            raddr = raddr + 11'b1;
        end
        // Test one of the sub-bank

        #2
        ren = 1'b0;
        din = 8'd20;
        waddr = 11'b00001111111;
        raddr = 11'b00001111111;
        repeat(15) begin
            #2
            din = din + 8'b1;
            waddr = waddr + 11'b00010000000;
        end
        #2
        ren = 1'b1;
        waddr = raddr;
        repeat(15) begin
            #2
            ren = 1'b1;
            raddr = raddr + 11'b00010000000;
            waddr = raddr;
        end
        // Test (different sub-bank but same memory address) and (wen == 1 and ren == 1 and raddr == waddr)

        #2
        ren = 1'b1;
        wen = 1'b1;
        waddr = 11'b00001111000;
        raddr = 11'b11111111000;
        din = 8'd40;
        repeat(15) begin
            #2
            din = din + 8'b1;
            waddr = waddr + 11'b00010000000;
            raddr = raddr - 11'b00010000000;
        end
        // Test wen == 1 and ren == 1 but raddr != waddr

        #2 $finish;
    end
endmodule