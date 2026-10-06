module tb_add;
  parameter N = 8;
  reg clk = 0;
  always #5 clk = ~clk;

  reg  [N-1:0] a, b;
  reg          cin;
  wire [N-1:0] s;
  wire         cout;
  reg  [N:0]   dung;
  integer i, loi = 0;

`ifdef TOP_ADD
  add_top #(.N(N)) dut (.clk(clk), .a(a), .b(b), .cin(cin), .s(s), .cout(cout));
`else
  rca_top #(.N(N)) dut (.clk(clk), .a(a), .b(b), .cin(cin), .s(s), .cout(cout));
`endif

  initial begin
    for (i = 0; i < 2000; i = i + 1) begin
      a = $random;  b = $random;  cin = $random;
      dung = a + b + cin;
      @(posedge clk);
      @(posedge clk);
      #1;
      if ({cout, s} !== dung) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai: a=%0d b=%0d cin=%0d ra %0d, dung la %0d", a, b, cin, {cout, s}, dung);
      end
    end
    if (loi == 0) $display("PASS: N=%0d, 2000/2000", N);
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
