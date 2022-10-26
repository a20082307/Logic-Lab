`timescale 1ns/1ps

module fifo;
    reg clk, rst_n;
    reg wen, ren;
    reg [7:0] din;
    wire error;
    wire [7:0] dout;

    always #1 clk = ~clk;

    FIFO_8 f1(.clk(clk), .rst_n(rst_n), .wen(wen), .ren(ren), .error(error), .dout(dout), .din(din));

    initial begin
        wen = 1'b0;
        ren = 1'b0;
        clk = 1'b0;
        rst_n = 1'b0;
        din = 8'b0;
        // Initialize

        
        repeat(4) begin
            #2 
            rst_n = 1'b1;
            din = din + 8'b1;
            wen = 1'b1;
        end
        repeat(4) begin
            #2 ren = 1'b1;
        end
        // Test basic function -- push() and pop()

        #2 
        rst_n = 1'b0;
        wen = 1'b0;
        #2 
        wen = 1'b1;
        ren = 1'b0;
        #2 ren = 1'b1;
        #2 rst_n = 1'b1;
        // Test reset

        ren = 1'b0;
        din = 8'b00001010;  // 10
        repeat(10) begin
            #2 
            din = din + 8'b1;
        end
        repeat(10) begin
            #2 
            ren = 1'b1;
            wen = 1'b0;
        end
        // Test if push() when memory is full and if pop() when memory is empty

        ren = 1'b0;
        wen = 1'b0;
        din = 8'b00101000;  // 40
        repeat(4) begin
            #2 din = din + 8'b1;
        end
        // Test if both ren and wen equal to 0

        #1 $finish;
    end
endmodule