`timescale 1ns/1ps

module Decode_t;
    reg [3:0] rs = 4'b1000;
    reg [3:0] rt = 4'b0;
    reg [2:0] sel = 3'b0;
    wire [3:0] out;

    Decode_And_Execute test(rs, rt, sel, out);

    initial begin
        //==============================sub
        repeat (16) begin
            #1 
            rt = rt + 4'b1;
        end
        //==============================


        //==============================add
        sel = sel + 3'b1;
        rt = 4'b0000;

        
        repeat (16) begin
            #1
            rt = rt + 4'b1;
        end
        //==============================


        //==============================bit or
        #1 
        sel = sel + 3'b1;
        rs = 4'b0011;
        rt = 4'b0101;
        //==============================


        //==============================bit and
        #1
        sel = sel + 3'b1;
        //==============================
        

        //==============================right shift
        #1 
        sel = sel + 3'b1;
        rt = 4'b0000;
        rs = 4'b0010;
        repeat (16) begin
            #1
            rt = rt + 4'b1;
            rs = rs + 4'b1;
        end
        //==============================


        //==============================left shift
        #1
        sel = sel + 3'b1;
        rs = 4'b0000;
        rt = 4'b0010;
        repeat (16) begin
            #1
            rt = rt + 4'b1;
            rs = rs + 4'b1;
        end
        //==============================


        //==============================less than
        #1
        sel = sel + 3'b1;
        rs = 4'b0011;
        rt = 4'b0000;
        repeat (16) begin
            #1
            rt = rt + 4'b1;
        end
        //==============================


        //==============================equal
        #1
        sel = sel + 3'b1;
        rt = 4'b0000;

        repeat (16) begin
            #1
            rt = rt + 4'b1;
        end
        //==============================

        #1 $finish;
    end
endmodule