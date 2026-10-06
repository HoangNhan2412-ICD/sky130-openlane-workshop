module tb_rca4;
  reg clk = 0;
  always #5 clk = ~clk;

  reg  [3:0] a, b;
  reg        cin;
  wire [3:0] s;
  wire       cout;
  reg  [4:0] dung;
  integer i, loi = 0;

  rca4_top dut (.clk(clk), .a(a), .b(b), .cin(cin), .s(s), .cout(cout));

  initial begin
    for (i = 0; i < 512; i = i + 1) begin
      {cin, a, b} = i;
      dung = a + b + cin;
      @(posedge clk);          // cạnh 1: đầu vào vào thanh ghi
      @(posedge clk);          // cạnh 2: kết quả vào thanh ghi ra
      #1;
      if ({cout, s} !== dung) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai: a=%0d b=%0d cin=%0d ra %0d, dung la %0d", a, b, cin, {cout, s}, dung);
      end
    end
    if (loi == 0) $display("PASS: 512/512");
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
