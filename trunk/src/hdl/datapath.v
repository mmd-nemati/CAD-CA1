module datapath(clk, rst, inp1, inp2, inp3, inp4, ldI, ldA, ldInit, ldM, ldRes, max, Done);
        input clk, rst, ldI, ldA, ldInit, ldM, ldRes;
        input [31:0] inp1, inp2, inp3, inp4;

        wire [31:0] initX1, initX2, initX3, initX4;

        // read the weight from file which is in IEEE 754 float format
        reg [31:0] weights [3:0][3:0];
        initial begin
                $readmemh("./file/weights.dat", weights);
                // $readmemh("trunk/sim/file/weights.dat", weights);
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

        
        // pu ha
        // module pu(clk, rst, ldM, ldRes, a1, a2, a3, a4, w1, w1, w3, w4, aOut)
        pu pu1(clk, rst, ldM, ldRes, aOut1, aOut2, aOut3, aOut4, 
                weights[0][0], weights[0][1], weights[0][2], weights[0][3], aIn1);
        
        pu pu2(clk, rst, ldM, ldRes, aOut1, aOut2, aOut3, aOut4, 
                weights[1][0], weights[1][1], weights[1][2], weights[1][3], aIn2);

        pu pu3(clk, rst, ldM, ldRes, aOut1, aOut2, aOut3, aOut4, 
                weights[2][0], weights[2][1], weights[2][2], weights[2][3], aIn3);

        pu pu4(clk, rst, ldM, ldRes, aOut1, aOut2, aOut3, aOut4, 
                weights[3][0], weights[3][1], weights[3][2], weights[3][3], aIn4);

        // detecting zero activations
        wire zero1, zero2, zero3, zero4;
        isZero iszr1(aOut1, zero1);
        isZero iszr2(aOut2, zero2);
        isZero iszr3(aOut3, zero3);
        isZero iszr4(aOut4, zero4);

        // issue Done
        output Done;
        assign Done = ({2'b0, zero1} + {2'b0, zero2} + {2'b0, zero3} + {2'b0, zero4}) == 3'b011;

        // encoding
        wire [1:0] sig;
        encoder encdr({zero1, zero2, zero3, zero4}, sig);

        // maximum multiplexer
        output [31:0] max;
        mux4 mux(initX1, initX2, initX3, initX4, sig, max);
endmodule