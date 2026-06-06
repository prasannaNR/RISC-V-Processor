module sltu(out, A, B);
output out;
input  [63:0] A, B;

wire [63:0] B_bar;
wire [63:0] Sum;
wire [64:0] Cout;
wire overflow;

assign B_bar = ~B;          

Port_In FA ( .Sum (Sum), .Cout(Cout), .A(A), .B(B_bar), .Cin(1'b1));

assign out = ~Cout[64]; 

endmodule
