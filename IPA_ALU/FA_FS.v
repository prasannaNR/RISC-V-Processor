module FA(Sum,Cout,A,B,Cin);
input A,B,Cin;
output Cout,Sum;
wire Hsum,Hcarry,Bcout;

HA h1(Hsum,Hcarry,A,B);
HA h2(Sum,Bcout,Hsum,Cin);
or o1(Cout,Bcout,Hcarry);
endmodule

module HA(Sum,Cout,A,B);
input A,B;
output Sum,Cout;

xor x1(Sum,A,B);
and a1(Cout,A,B);
endmodule

module Port_In(Sum,Cout,A,B,Cin);
output [64:0] Cout;
output [63:0] Sum;
input [63:0]A,B;
input Cin;

assign Cout[0] = Cin;
genvar i;

generate
    for (i = 0;i < 64; i = i + 1) begin
        FA fa(.Sum(Sum[i]),.Cout(Cout[i+1]),.A(A[i]),.B(B[i]),.Cin(Cout[i]));
    end
endgenerate
endmodule