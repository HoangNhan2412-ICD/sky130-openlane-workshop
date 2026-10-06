module rca_top #(parameter N = 8) (input clk, input [N-1:0] a, input [N-1:0] b, input cin,
                                   output reg [N-1:0] s, output reg cout);
  reg  [N-1:0] a_r, b_r;
  reg          cin_r;
  wire [N-1:0] s_w;
  wire         cout_w;

  rca #(.N(N)) u_add (.a(a_r), .b(b_r), .cin(cin_r), .s(s_w), .cout(cout_w));

  always @(posedge clk) begin
    a_r <= a;  b_r <= b;  cin_r <= cin;
    s   <= s_w; cout <= cout_w;
  end
endmodule
