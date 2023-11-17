

module mainTB();

        reg [31:0] x1, x2, x3, x4;
        wire [31:0] max;
        wire Done;
        reg clk, rst, start;

// module neutralNetwork(clk, rst, inp1, inp2, inp3, inp4, max);
        neuralNetwork nn(clk, rst, start, x1, x2, x3, x4, max, Done);

    // Clock generation
        always begin
                #5 clk = ~clk;
        end

        initial begin
                clk = 0;
                rst = 1;
                #5 rst = 0; start = 1;
                // #5 start = 0;
                x1 = 32'h40133333; // 2.30
                x2 = 32'h41151eb8; // 9.32
                x3 = 32'h40466666; // 3.1
                x4 = 32'h3f4ccccd; // 0.8
                #500 rst = 1; start = 0;
                #5 rst = 0; start = 1;
                x1 = 32'h447a0000; // 1000
                x2 = 32'h4070a3d7; // 3.76
                x3 = 32'h42466666; // 49.6
                x4 = 32'h3f4ccccd; // 0.8
                #1000 $stop;
        end

endmodule
