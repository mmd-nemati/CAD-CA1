module floatMulTB();

    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] product;
    reg clk;

        floatMultiplier u2(a, b, product);

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        // Test case 1: 1.0 * 2.0 = 2.0
        a = 32'hc0600000; // 1.0 in IEEE 754
        b = 32'h40000000; // 2.0 in IEEE 754
        #10;
        if(product !== 32'h40000000) $display("Test case 1 failed");

        // Test case 2: -1.0 * 1.5 = -1.5
        a = 32'h40000000; // -1.0 in IEEE 754
        b = 32'hc0600000; // 1.5 in IEEE 754
        #10;
        if(product !== 32'hBFC00000) $display("Test case 2 failed");

        // Test case 3: 0.0 * 0.0 = 0.0
        a = 32'h40600000; // 0.0 in IEEE 754
        b = 32'hc0600000; // 0.0 in IEEE 754
        #10;
        if(product !== 32'h00000000) $display("Test case 3 failed");
                                        // test case 7 -0.2 + 2.5 = 2.3
        a = 32'h3e4ccccd;
        b = 32'h40533333;
        #10;
        if(product !== 32'b01000000000100110011001100110011) $display("Test case 7 failed");

        // test case 8 -0.5 + 2.5 = 2
        a = 32'hbf000000;
        b = 32'h40200000;
        #10;
        if(product !== 32'b01000000000000000000000000000000) $display("Test case 8 failed");

                // test case 9 -1.5 * 2 = 0.7
        a = 32'hbfc00000;
        b = 32'h40000000;
        #10;
        if(product !== 32'b00111111001100110011001100110011) $display("Test case 9 failed");
                        // test case 10 -1.5 * 2 = 0.7
        a = 32'h00000000;
        b = 32'h40000000;
        #10;
        if(product !== 32'b00111111001100110011001100110011) $display("Test case 9 failed");
        
                        // test case 10 -1.5 * 2 = 0.7
        a = 32'hbe4ccccd;
        b = 32'h41b8cccd;
        #10;
        if(product !== 32'b00111111001100110011001100110011) $display("Test case 9 failed");
                        // test case 10 -1.5 * 2 = 0.7
        a = 32'h3f800000;
        b = 32'hbf800000;
        #10;
        if(product !== 32'b00111111001100110011001100110011) $display("Test case 9 failed");
        //0x3f800000
        #100 $stop;
    end

endmodule
