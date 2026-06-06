module bit_xor(C,A,B);
output [63:0]C;
input [63:0] A,B;

genvar i;

generate
    for (i = 0;i < 64; i = i + 1) begin
        xor x1(C[i],A[i],B[i]);
    end
endgenerate
endmodule

module bit_and(C,A,B);
output [63:0]C;
input [63:0] A,B;

genvar i;

generate
    for (i = 0;i < 64; i = i + 1) begin
        and a1(C[i],A[i],B[i]);
    end
endgenerate
endmodule

module bit_or(C,A,B);
output [63:0]C;
input [63:0] A,B;

genvar i;

generate
    for (i = 0;i < 64; i = i + 1) begin
        or o1(C[i],A[i],B[i]);
    end
endgenerate
endmodule