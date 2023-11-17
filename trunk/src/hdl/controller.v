`define idle 3'd0
`define A 3'd1
`define B 3'd2
`define C 3'd3
`define D 3'd4
`define E 3'd5
`define F 6'd6

module controller(rst, clk, start, ldI, ldInit, ldM, ldRes, ldA, Done);

    input rst, clk, start, Done;
    output reg ldI, ldInit, ldM, ldRes, ldA;

    reg [2:0] ps, ns;

//     parameter [2:0] = 
//     idle = 000,
//     A = 001,
//     B = 010,
//     C = 011,
//     D = 100,
//     E = 101,
//     F = 110;

    always @(*) begin
        // {ldI, ldInit, ldM, ldRes, ldA} = 5'b0;
        case (ps)
            `idle : ns = (start) ? `A : `idle;
            `A : ns = `B;
            `B : ns = `C;
            `C : ns = `D;
            `D : ns = `E;
            `E : ns = (Done) ? `F : `C;
            `F : ns = (rst) ? `A : `F;
            default: ns = `idle;
        endcase
    end
        always @(ps) begin
                {ldI, ldInit, ldM, ldRes, ldA} = 5'b0;
                case(ps)
                        `A: begin
                                ldI = 1'b1;
                        end
                        `B: begin
                                ldInit = 1'b1;
                        end
                        `C: begin 
                                ldM = 1'b1;
                        end
                        `D: begin
                                ldRes = 1'b1;
                        end
                        `E: begin
                                ldA = 1'b1;
                        end

                endcase
        end
    always @(posedge clk, posedge rst)begin
        if(rst)
            ps <= `idle;
        else
            ps <= ns;
    end



endmodule