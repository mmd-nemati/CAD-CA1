module pu(clk, rst, ldM, ldRes, a1, a2, a3, a4, w1, w2, w3, w4, aOut);
        input clk, rst, ldM, ldRes;
        input [31:0] a1, a2, a3, a4, w1, w2, w3, w4;
        output [31:0] aOut;

        wire [31:0] mul1, mul2, mul3, mul4;
        wire [31:0] mulRegOut1, mulRegOut2, mulRegOut3, mulRegOut4;

        ///////////////////////// zarb ha bayad dorost beshan
        floatMultiplier flmul1(a1, w1, mul1);
        floatMultiplier flmul2(a2, w2, mul2);
        floatMultiplier flmul3(a3, w3, mul3);
        floatMultiplier flmul4(a4, w4, mul4);

        // multiplication result registers
        reg32B mulReg1(clk, rst, ldM, mul1, mulRegOut1);
        reg32B mulReg2(clk, rst, ldM, mul2, mulRegOut2);
        reg32B mulReg3(clk, rst, ldM, mul3, mulRegOut3);
        reg32B mulReg4(clk, rst, ldM, mul4, mulRegOut4);
        
        // first layer of adders
        wire [31:0] firstAddersOut1, firstAddersOut2; // khroogi avalin laye adder ha
        floatAdder fira1(mulRegOut1, mulRegOut2, firstAddersOut1);
        floatAdder fira2(mulRegOut3, mulRegOut4, firstAddersOut2);

        // second layer of adder
        wire [31:0] secondAddersOut; // khroogi dovomin laye adder
        floatAdder seca2(firstAddersOut1, firstAddersOut2, secondAddersOut);

        // last register of the pu
        wire [31:0] finalRegOut;
        reg32B finalReg(clk, rst, ldRes, secondAddersOut, finalRegOut);

        // output ----> is logic correct?
        assign aOut = (finalRegOut[31] == 1'b1) ? 32'b0 : finalRegOut;
endmodule