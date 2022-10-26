`timescale 1ns/1ps

module Round_Robin_FIFO_Arbiter(clk, rst_n, wen, a, b, c, d, dout, valid);
    input clk;
    input rst_n;
    input [4-1:0] wen;
    input [8-1:0] a, b, c, d;
    output [8-1:0] dout;
    output valid;

    reg [3:0] ren;
    reg [7:0] ans;
    wire [3:0] err;
    wire [7:0] out [3:0];
    reg IsValid;

    assign valid = IsValid;

    or or1[7:0] (dout, out[0], out[1], out[2], out[3]);

    fifo_8 ff1(clk, rst_n, wen[0], ren[0], a, out[0], err[0]);
    fifo_8 ff2(clk, rst_n, wen[1], ren[1], b, out[1], err[1]);
    fifo_8 ff3(clk, rst_n, wen[2], ren[2], c, out[2], err[2]);
    fifo_8 ff4(clk, rst_n, wen[3], ren[3], d, out[3], err[3]);

    always @(posedge clk) begin
        $display($time, " ren = %b", ren[3:0]);
        case (ren)
            4'b0000: ren <= 4'b0001;
            4'b0001: ren <= 4'b0010;
            4'b0010: ren <= 4'b0100;
            4'b0100: ren <= 4'b1000;
            4'b1000: ren <= 4'b0001;    
        endcase
    end

    always @(*) begin
        if (!rst_n) begin
            ren = 4'b0000;
        end
        if (err[0] || err[1] || err[2] || err[3] || (!out[0] && !out[1] && !out[2] && !out[3]) || !rst_n) begin
            $display($time, " err[0] = %d, err[1] = %d, err[2] = %d, err[3] = %d\n", err[0], err[1], err[2], err[3]);
            IsValid = 1'b0;
        end
        else begin    
            IsValid = 1'b1;
            $display($time, " dout = %d, out1 = %d, out2 = %d, out3 = %d, out4 = %d\n", dout, out[0], out[1], out[2], out[3]);
        end
    end
endmodule

module fifo_8(clk, rst_n, wen, ren, din, dout, error);
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
    reg [3:0] w;

    reg [7:0] memory [7:0];
    always @(posedge clk) begin
        if (rst_n) begin
            if (wen) begin
                if (memory[7] == 8'b0) begin
                    memory[w] <= din;
                    w <= w + 4'b1;
                    out <= 8'b0;

                    if (!ren)    err <= 1'b0;
                    else    err <= 1'b1;
                    $display($time, " din = %d, m[0] = %d, m[1] = %d, m[2] = %d", din, memory[0], memory[1], memory[2]);
                end  // The memory still has space to store

                else begin
                    err <= 1'b1;
                    out <= 8'b0;
                    $display($time, " full");
                end  // The memory doesn't have space to store
            end
            else if (ren) begin
                if (memory[0] != 8'b0) begin
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
                    w = w - 4'b0001;
                    $display($time, " dout = %d, m[0] = %d, m[1] = %d, m[2] = %d", out, memory[0], memory[1], memory[2]);
                    // Move every element in memory forward and update the write index
                end  // The content of memory[r] is not empty

                else begin
                    err <= 1'b1;
                    out <= 8'b0;
                    $display($time, "empty");
                end  // The content of memory[r] is empty
            end
            else begin
                err <= 1'b0;
                out <= 8'b0;
                $display($time, " m[0] = %d, m[1] = %d, m[2] = %d", memory[0], memory[1], memory[2]);
            end
        end
    end
    // synchronized circuit

    
    always @(rst_n) begin
        if (!rst_n) begin
            err = 1'b0;
            out = 8'b0; 
            w = 4'b0;

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