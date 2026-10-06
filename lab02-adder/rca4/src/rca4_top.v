module rca4_top (input clk, input [3:0] a, input [3:0] b, input cin,
                 output reg [3:0] s, output reg cout);
  reg  [3:0] a_r, b_r;
  reg        cin_r;
  wire [3:0] s_w;
  wire       cout_w;

  rca4 u_add (.a(a_r), .b(b_r), .cin(cin_r), .s(s_w), .cout(cout_w));

  always @(posedge clk) begin
    a_r <= a;  b_r <= b;  cin_r <= cin;   // thanh ghi vào
    s   <= s_w; cout <= cout_w;           // thanh ghi ra
  end
endmodule
