module rca #(parameter N = 8) (input [N-1:0] a, input [N-1:0] b, input cin,
                               output [N-1:0] s, output cout);
  wire [N:0] c;
  assign c[0] = cin;
  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : g_bit
      fa u_fa (.a(a[i]), .b(b[i]), .cin(c[i]), .s(s[i]), .cout(c[i+1]));
    end
  endgenerate
  assign cout = c[N];
endmodule
