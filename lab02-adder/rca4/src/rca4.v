module rca4 (input [3:0] a, input [3:0] b, input cin,
             output [3:0] s, output cout);
  wire [4:0] c;                       // c[i] là số nhớ vào bit i
  assign c[0] = cin;
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : g_bit
      fa u_fa (.a(a[i]), .b(b[i]), .cin(c[i]), .s(s[i]), .cout(c[i+1]));
    end
  endgenerate
  assign cout = c[4];
endmodule
