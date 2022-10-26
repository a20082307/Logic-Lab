`timescale 1ns/1ps

module FIFO_8(clk, rst_n, wen, ren, din, dout, error);
    input clk;
    input rst_n;
    input wen, ren;
    input [8-1:0] din;
    output [8-1:0] dout;
    output error;

    reg err;
    reg [7:0] out;
    assign dout = out;
    assign error = err;

    integer i;  // for the for loop
    reg full, empty;
    reg [3:0] idx;

    reg [7:0] memory [7:0];
    always @(posedge clk) begin
        if (rst_n) begin
            if (ren) begin
                if (!empty) begin
                    out <= memory[0];
                    err <= 1'b0;

                    memory[0] <= memory[1];
                    memory[1] <= memory[2];
                    memory[2] <= memory[3];
                    memory[3] <= memory[4];
                    memory[4] <= memory[5];
                    memory[5] <= memory[6];
                    memory[6] <= memory[7];
                    memory[7] <= 8'b0;
                    idx <= idx - 4'b0001;

                    if (idx == 4'b0)    
                        empty <= 1'b1;
                    full <= 1'b0;

                    $display("rm input = %d, m[0] = %d, m[1] = %d, m[2] = %d, m[3] = %d, m[4] = %d, w = %d", din, memory[0], memory[1], memory[2], memory[3], memory[4], idx);
                    // Move every element in memory forward and update the write index
                end  // The content of memory[r] is not empty

                else begin
                    err <= 1'b1;
                    out <= 8'b0;
                end  // The content of memory[r] is empty
            end  // Read mode

            else begin
                if (wen) begin
                    if (!full) begin
                        memory[idx] <= din;
                        idx <= idx + 4'b1;
                        err <= 1'b0;

                        if (idx == 4'd7)
                            full <= 1'b1;
                        empty <= 1'b0;
                    end  // The memory still has space to store

                    else begin
                        err <= 1'b1;
                        out <= 8'b0;
                    end  // The memory doesn't have space to store
                    $display("wm input = %d, m[0] = %d, m[1] = %d, m[2] = %d, m[3] = %d, m[4] = %d, w = %d", din, memory[0], memory[1], memory[2], memory[3], memory[4], idx);
                end  // Write mode

                else begin
                    err <= 1'b0;
                    out <= 8'b0;
                end  // When wen == ren == 0
            end  
        end
    end
    // synchronized circuit

    
    always @(rst_n) begin
        if (!rst_n) begin
            err = 1'b0;
            out = 8'b0; 
            idx = 4'b0;
            full = 1'b0;
            empty = 1'b0;

            memory[0] <= 8'b0;
            memory[1] <= 8'b0;
            memory[2] <= 8'b0;
            memory[3] <= 8'b0;
            memory[4] <= 8'b0;
            memory[5] <= 8'b0;
            memory[6] <= 8'b0;
            memory[7] <= 8'b0;
        end
    end
    // combinational circuit

endmodule
