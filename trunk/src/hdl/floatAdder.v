module floatAdder(a, b,sum);
        input [31:0] a,
        input [31:0] b,
        output [31:0] sum
        
        reg [7:0] a_exp, b_exp, sum_exp;
        reg [22:0] a_mant, b_mant, sum_mant;
        reg a_sign, b_sign, sum_sign;
        reg [23:0] aligned_mant_a, aligned_mant_b;
        reg [8:0] exp_diff;
        reg [24:0] add_result;
        reg overflow;

        always (a, b) begin
                a_sign = a[31];
                a_exp = a[30:23];
                a_mant = a[22:0];

                b_sign = b[31];
                b_exp = b[30:23];
                b_mant = b[22:0];

                if(a_exp > b_exp) begin
                        exp_diff = a_exp - b_exp;
                        aligned_mant_a = {1'b1, a_mant};
                        aligned_mant_b = {1'b1, b_mant} >> exp_diff;
                        sum_exp = a_exp;
                end
                else begin
                        exp_diff = b_exp - a_exp;
                        aligned_mant_a = {1'b1, a_mant} >> exp_diff;
                        aligned_mant_b = {1'b1, b_mant};
                        sum_exp = b_exp;
                end

                if(a_sign == b_sign) begin
                        add_result = aligned_mant_a + aligned_mant_b;
                        sum_sign = a_sign;
                        overflow = add_result[24];
                end 
                else if(aligned_mant_a > aligned_mant_b) begin
                        add_result = aligned_mant_a - aligned_mant_b;
                        sum_sign = a_sign;
                        overflow = 0;
                end
                else begin
                        add_result = aligned_mant_b - aligned_mant_a;
                        sum_sign = b_sign;
                        overflow = 0;
                end

                if(overflow) begin
                        sum_mant = add_result[23:1];
                        sum_exp = sum_exp + 1;
                end
                else begin
                        sum_mant = add_result[22:0];
                end
    end

//     always @(posedge clk) begin
        assign sum <= {sum_sign, sum_exp, sum_mant};
//     end
endmodule
