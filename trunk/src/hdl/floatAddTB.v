

module floatAddTB();

    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] sum;
    reg clk;

        floatAdder u2(a, b, sum);

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        // Test case 1: 1.0 + 2.0 = 3.0
        a = 32'h3F800000; // 1.0 in IEEE 754
        b = 32'h40000000; // 2.0 in IEEE 754
        #10;
        if(sum !== 32'b01000000010000000000000000000000) $display("Test case 1 failed");

        // Test case 3: 0.0 + 0.0 = 0.0
        a = 32'h00000000; // 0.0 in IEEE 754
        b = 32'h00000000; // 0.0 in IEEE 754
        #10;
        if(sum !== 32'h00000000) $display("Test case 3 failed");
        // Test case 2: -1.0 + 1.5 = 0.5
        a = 32'hBF800000; // -1.0 in IEEE 754
        b = 32'h3FC00000; // 1.5 in IEEE 754
        #10;
        if(sum !== 32'b00111111000000000000000000000000) $display("Test case 2 failed");
        // Test case 2: -1.0 + 1.5 = 0.5
        b = 32'hBF800000; // -1.0 in IEEE 754
        a = 32'hBF800000; // -1.0 in IEEE 754
        #10;
        if(sum !== 32'b00111111000000000000000000000000) $display("Test case 3 failed");

        // test case 4 -0.2 + 1 = 0.8
        a = 32'hBE4CCCCD;
        b = 32'h3F800000;
        #10;
        if(sum !== 32'b00111111010011001100110011001101) $display("Test case 4 failed");

                // test case 5 0.2 + 1 = 1.2
        a = 32'h3e4ccccd;
        b = 32'h3F800000;
        #10;
        if(sum !== 32'b00111111100110011001100110011010) $display("Test case 5 failed");
                        // test case 5 0.2 + 1 = 1.2
        a = 32'h3e4ccccd;
        b = 32'h3e4ccccd;
        #10;
        if(sum !== 32'b00111111100110011001100110011010) $display("Test case 5 failed");
                        // test case 6 -0.2 - 1 = -1.2
        a = 32'hbe4ccccd;
        b = 32'hbf800000;
        #10;
        if(sum !== 32'b10111111100110011001100110011010) $display("Test case 6 failed");

                                // test case 7 -0.2 + 2.5 = 2.3
        a = 32'hbe4ccccd;
        b = 32'h40200000;
        #10;
        if(sum !== 32'b01000000000100110011001100110011) $display("Test case 7 failed");

        // test case 8 -0.5 + 2.5 = 2
        a = 32'hbf000000;
        b = 32'h40200000;
        #10;
        if(sum !== 32'b01000000000000000000000000000000) $display("Test case 8 failed");

                // test case 9 -1.5 + 2.2 = 0.7
        a = 32'hbfc00000;
        b = 32'h400ccccd;
        #10;
        if(sum !== 32'b00111111001100110011001100110011) $display("Test case 9 failed");
        #100 $stop;
    end

endmodule
