`timescale 1ns/1ps

module RCA_t;
reg [7:0] a = 8'b0;
reg [7:0] b = 8'b0;
reg cin = 1'b0;

wire [7:0] sum;
wire cout = 1'b0;

Ripple_Carry_Adder rca1(a, b, cin, cout, sum);

initial begin
    $monitor($time, " a = %d, b = %d, cin = %d, cout = %d, sum = %d", a, b, cin, cout, sum);

    #1 
    
    a = 8'b1;
    repeat (8) begin
        #1
        a = a <<< 1;
        a = a + 8'b1;
    end

    a = 8'b1;
    b = 8'b1;

    repeat (8) begin
        #1 
        a = a <<< 1;
        a = a + 8'b1;
    end

    a = 8'b1;
    
    repeat (8) begin
        #1 
        a = a <<< 1;
        a = a + 8'b1;
        
        b = b <<< 1;
        b = b + 8'b1;
    end

    a = 8'b1;
    b = 8'b0;
    cin = ~cin;

    repeat (8) begin
        #1
        a = a <<< 1;
        a = a + 8'b1;
    end

    a = 8'b1;
    b = 8'b1;

    repeat (8) begin
        #1 
        a = a <<< 1;
        a = a + 8'b1;
    end

    a = 8'b1;
    
    repeat (8) begin
        #1 
        a = a <<< 1;
        a = a + 8'b1;
        
        b = b <<< 1;
        b = b + 8'b1;
    end

    #1 $finish;
end
endmodule 