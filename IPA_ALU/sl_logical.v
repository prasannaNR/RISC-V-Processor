module MUX(Y, I0, I1, S);
output Y;
input  I0, I1, S;

assign Y = S ? I1 : I0;
endmodule

module sl_logic(OUT, IN, S);
output [63:0] OUT;
input  [63:0] IN;
input  [5:0]  S;

wire [63:0] S1, S2, S3, S4, S5;

genvar i;

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE1
    if (i == 0) begin
      MUX m (S1[i], IN[i], 1'b0, S[0]);
    end 
    else begin
      MUX m (S1[i], IN[i], IN[i-1], S[0]);
    end
  end
endgenerate

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE2
    if (i < 2) begin
      MUX m (S2[i], S1[i], 1'b0, S[1]);
    end 
    else begin
      MUX m (S2[i], S1[i], S1[i-2], S[1]);
    end
  end
endgenerate

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE3
    if (i < 4) begin
      MUX m (S3[i], S2[i], 1'b0, S[2]);
    end 
    else begin
      MUX m (S3[i], S2[i], S2[i-4], S[2]);
    end
  end
endgenerate

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE4
    if (i < 8) begin
      MUX m (S4[i], S3[i], 1'b0, S[3]);
    end 
    else begin
      MUX m (S4[i], S3[i], S3[i-8], S[3]);
    end
  end
endgenerate

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE5
    if (i < 16) begin
      MUX m (S5[i], S4[i], 1'b0, S[4]);
    end 
    else begin
      MUX m (S5[i], S4[i], S4[i-16], S[4]);
    end
  end
endgenerate

generate
  for (i = 0; i < 64; i = i + 1) begin : STAGE6
    if (i < 32) begin
      MUX m (OUT[i], S5[i], 1'b0, S[5]);
    end
    else begin
      MUX m (OUT[i], S5[i], S5[i-32], S[5]);
    end
  end
endgenerate

endmodule
module PORT;
reg  [63:0] IN;
reg  [5:0]  S;
wire [63:0] OUT;

sl_logic dut(OUT, IN, S);

initial begin
    $monitor($time,
             "  IN = %064b | S = %0d | OUT = %064b",
              IN, S, OUT);
end

initial begin
    
    IN = 64'b1;
    S  = 6'd0;
    #10;

    IN = 64'b1;
    S  = 6'd1;
    #10;

    IN = 64'b1;
    S  = 6'd4;
    #10;

    IN = 64'h0000_0000_0000_00FF;
    S  = 6'd8;
    #10;

    IN = 64'h0000_0000_0000_0001;
    S  = 6'd16;
    #10;

    IN = 64'h0000_0000_0000_0001;
    S  = 6'd31;
    #10;

    IN = 64'h0000_0000_0000_0001;
    S  = 6'd32;
    #10;

    IN = 64'h0000_0000_0000_0001;
    S  = 6'd63;
    #10;

    IN = 64'hA5A5_A5A5_F0F0_F0F0;
    S  = 6'd7;
    #10;

    IN = 64'hFFFF_FFFF_FFFF_FFFF;
    S  = 6'd5;
    #10;

    $finish;
end

endmodule
