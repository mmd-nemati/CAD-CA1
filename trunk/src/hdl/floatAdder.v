module floatAdder(a, b, sum);

        input [31:0] a, b;
        output reg [31:0] sum;
        reg [23:0] aMant, bMant, tmpMant;
        reg [22:0] resMant;
        reg [7:0] aExp, bExp, diffExp, resExp;
        reg aSign, bSign, resSign;
        reg carry;
        reg comp;
        reg [7:0] alignExp;
        always @(a, b) begin
                // check for NaN
                if ((a[30:23] == 8'hFF && a[22:0] != 0) || (b[30:23] == 8'hFF && b[22:0] != 0)) begin
                        sum = 32'b0;
                        $display("ERROR: NaN detected");
                end
                // check for Infinity
                else if ((a[30:23] == 8'hFF && a[22:0] == 0) || (b[30:23] == 8'hFF && b[22:0] == 0)) begin
                        sum = 32'b0;
                        $display("ERROR: Infinity detected");
                end
                // check zero
                else if (a == 32'b0) begin
                        sum = b;
                        // break;
                end
                else if (b == 32'b0) begin
                        sum = a;
                end
                else begin
                        if (a[30:23] > b[30:23]) begin
                                comp = 1'b1;
                        end
                        else if (a[30:23] == b[30:23]) begin
                                comp = (a[22:0] > b[22:0])? 1'b1 : 1'b0;
                        end
                        else if (a[30:23] < b[30:23]) begin
                                comp = 1'b0;
                        end
                        aSign = comp ? a[31] : b[31];
                        aExp = comp ? a[30:23] : b[30:23];
                        aMant = comp ? {1'b1, a[22:0]} : {1'b1, b[22:0]};
                        
                        bSign = comp ? b[31] : a[31];
                        bExp = comp ? b[30:23] : a[30:23];
                        bMant = comp ? {1'b1, b[22:0]} : {1'b1, a[22:0]};

                        diffExp = aExp - bExp;
                        bMant = (bMant >> diffExp);
                        {carry, tmpMant} =  (aSign ~^ bSign) ? aMant +  bMant : aMant- bMant ; 
                        alignExp = aExp;

                        if (carry) begin
                                alignExp = alignExp + 1'b1;
                                tmpMant = tmpMant >> 1;
                        end
                        else begin
                                while (!tmpMant[23]) begin
                                        alignExp =  alignExp - 1'b1;
                                        tmpMant = tmpMant << 1;
                                end
                        end
                        resSign = aSign;
                        resMant = tmpMant[22:0];
                        resExp = alignExp;
                        sum = {resSign, resExp, resMant};
                end
        end
endmodule