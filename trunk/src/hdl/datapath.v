module datapath(clk, rst, inp1, inp2, inp3, inp4, ldI, ldA, ldInit, max)
        input clk, rst, ldI, ldA, ldInit;
        input [31:0] inp1, inp2, inp3, inp4;

        wire[31:0] initX1, initX2, initX3, initX4;

        // read the weight from file which is in IEEE 754 float format
        reg [31:0] weights [3:0][3:0];
        initial begin
                $readmemh("../../sim/file/weights.dat", weights);
        end
        
        // registers to hold the initial values of x
        reg32B x1(clk, rst, ldI, inp1, initX1); 
        reg32B x2(clk, rst, ldI, inp2, initX2); 
        reg32B x3(clk, rst, ldI, inp3, initX3); 
        reg32B x4(clk, rst, ldI, inp4, initX4);


        // registers to hold activation values
        // aOuts -> miran tooye pu ha
        // aIn -> az pu ha mian
        wire[31:0] aIn1, aIn2, aIn3, aIn4;
        wire[31:0] aOut1, aOut2, aOut3, aOut4;
        reg32Activation a1(clk, rst, ldInit, ldA, initX1, aIn1, aOut1);
        reg32Activation a2(clk, rst, ldInit, ldA, initX2, aIn2, aOut2);
        reg32Activation a3(clk, rst, ldInit, ldA, initX3, aIn3, aOut3);
        reg32Activation a4(clk, rst, ldInit, ldA, initX4, aIn4, aOut4);


        // detecting zero activations
        wire zero1, zero2, zero3, zero4;
        isZero iszr1(aOuts1, zero1);
        isZero iszr2(aOuts2, zero2);
        isZero iszr3(aOuts3, zero3);
        isZero iszr4(aOuts4, zero4);

        // Encoding
        wire[1:0] sig;
        endcoder encdr({zero1, zero2, zero3, zero4}, sig);

        // maximum multiplexer
        output[31:0] max;
        mux4 mux(initX1, initX2, initX3, initX4, sig, max);
endmodule