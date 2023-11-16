module reg32Activation(clk, rst, ldInit, ldA, initDataIn, newDataIn, dataOut);
        input clk, rst, ldInit, ldA;
        input [31:0] initDataIn, newDataIn;
        output [31:0] dataOut;
        reg [31:0] savedData;
        
        always @(posedge clk, posedge rst) begin 
                if (rst) 
                        savedData = 32'b0;

                else if (ldInit)
                        savedData = initDataIn;
                
                else if (ldA)
                        savedData = newDataIn;
        end

        assign dataOut = savedData;
endmodule