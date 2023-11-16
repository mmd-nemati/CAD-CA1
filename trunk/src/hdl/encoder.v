module encoder(in, out);
        input [3:0] in;
        output reg [1:0] out;
        always @(in, out) begin
                case (in)
                        4'b0111: out = 2'b00;
                        4'b1011: out = 2'b01;
                        4'b1101: out = 2'b10;
                        4'b1110: out = 2'b11;
                        default: out = 2'b00; // default case
                endcase
        end
endmodule