module tb_regbank;
  parameter N = 8;
  reg clk = 0;
  always #5 clk = ~clk;

  reg        en;
  reg  [7:0] d;
  wire [7:0] q;
  reg  [7:0] lich_su [0:4095];
  integer k = 0, i, loi = 0;

  regbank #(.N(N)) dut (.clk(clk), .en(en), .d(d), .q(q));

  initial begin
    for (i = 0; i < 3000; i = i + 1) begin
      en = ($random % 4) != 0;          // khoảng 3/4 số chu kỳ có en = 1
      d  = $random;
      @(posedge clk);
      #1;
      if (en) begin lich_su[k] = d; k = k + 1; end
      if (k >= N && q !== lich_su[k-N]) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai o chu ky %0d: q=%0d, dung la %0d", i, q, lich_su[k-N]);
      end
    end
    if (loi == 0) $display("PASS: N=%0d", N);
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
