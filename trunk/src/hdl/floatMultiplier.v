
module floatMultiplier(a, b, product);
        input [31:0] a, b;
        output reg [31:0] product;

        reg [47:0] tmpMant;
        reg [23:0] aMant,bMant;
        reg [22:0] resMant;
        reg [7:0] aExp, bExp, tmpExp, resExp;
        reg aSign,bSign, resSign;

        always @(a, b) begin
                // check for NaN
                if ((a[30:23] == 8'hFF && a[22:0] != 0) || (b[30:23] == 8'hFF && b[22:0] != 0)) begin
                        product = 32'b0;
                        $display("ERROR: NaN detected");
                end
                // check for Infinity
                else if ((a[30:23] == 8'hFF && a[22:0] == 0) || (b[30:23] == 8'hFF && b[22:0] == 0)) begin
                        product = 32'b0;
                        $display("ERROR: Infinity detected");
                end
                // check zero
                else if (a == 32'b0 || b == 32'b0) begin
                        product = 32'b0;
                end
                else begin
                        aSign = a[31];
                        aExp = a[30:23];
                        aMant = {1'b1, a[22:0]};

                        bSign = b[31];
                        bExp = b[30:23];
                        bMant = {1'b1, b[22:0]};

                        tmpMant = aMant * bMant;
                        resMant = tmpMant[47] ? tmpMant[46:24] : tmpMant[45:23];
                        tmpExp = aExp + bExp - 127;
                        resExp = tmpExp + tmpMant[47];
                        product = {aSign ^ bSign, resExp, resMant};
                end
        end
endmodule