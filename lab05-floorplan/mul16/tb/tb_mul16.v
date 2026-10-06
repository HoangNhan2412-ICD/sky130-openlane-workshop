module tb_mul16;
  reg clk = 0;
  always #5 clk = ~clk;

  reg  [15:0] a, b;
  wire [31:0] p;
  reg  [31:0] dung;
  integer i, loi = 0;

  mul16 dut (.clk(clk), .a(a), .b(b), .p(p));

  initial begin
    for (i = 0; i < 2000; i = i + 1) begin
      a = $random;  b = $random;
      if (i == 0) begin a = 16'hFFFF; b = 16'hFFFF; end   // thử giá trị lớn nhất
      dung = a * b;
      @(posedge clk);
      @(posedge clk);
      #1;
      if (p !== dung) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai: %0d x %0d ra %0d, dung la %0d", a, b, p, dung);
      end
    end
    if (loi == 0) $display("PASS: 2000/2000");
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
