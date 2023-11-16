module isZero(in, out)
        input [31:0] in;
        output out;
        assign out = (in == 32'b0);
endmodule
