

module mainTB();

    reg [31:0] x1, x2, x3, x4;
    wire [31:0] max;
    wire Done;
    reg clk, rst;

// module neutralNetwork(clk, rst, inp1, inp2, inp3, inp4, max);
        neutralNetwork nn(clk, rst, x1, x2, x3, x4, max, Done);

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test cases
    initial begin
        clk = 0;
        rst = 1;
        #5 rst = 0;
        x1 = 32'h3e4ccccd;
        x2 = 32'h3ecccccd;
        x3 = 32'h3f19999a;
        x4 = 32'h3f4ccccd;
        #100 $stop;
    end

endmodule
