module neuralNetwork(clk, rst, start, inp1, inp2, inp3, inp4, max, Done);

        input clk, rst, start;
        input [31:0] inp1, inp2, inp3, inp4;

        output [31:0] max;
        output Done;
        wire ldI, ldInit, ldM, ldRes, ldA;
    
        datapath myDp(.rst(rst), .clk(clk), .inp1(inp1), .inp2(inp2), .inp3(inp3), .inp4(inp4), .ldI(ldI), .ldA(ldA), .ldInit(ldInit), .ldM(ldM), .ldRes(ldRes), .max(max), .Done(Done));
        controller myCtrl(.rst(rst), .clk(clk), .start(start), .ldI(ldI), .ldInit(ldInit), .ldM(ldM), .ldRes(ldRes), .ldA(ldA), .Done(Done));

endmodule