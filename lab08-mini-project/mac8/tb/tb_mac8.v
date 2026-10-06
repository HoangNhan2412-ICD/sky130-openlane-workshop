module tb_mac8;
  reg clk = 0;
  always #5 clk = ~clk;

  reg         clr, en;
  reg  [7:0]  a, b;
  wire [19:0] acc;
  reg  [19:0] tong;
  integer i, loi = 0;

  mac8 dut (.clk(clk), .clr(clr), .en(en), .a(a), .b(b), .acc(acc));

  initial begin
    tong = 0;
    for (i = 0; i < 3000; i = i + 1) begin
      clr = (i == 0) || ($random % 50 == 0);   // xóa lúc đầu và thỉnh thoảng
      en  = $random;
      a   = $random;
      b   = $random;
      if (clr)     tong = 0;
      else if (en) tong = tong + a * b;
      @(posedge clk);            // đầu vào vào thanh ghi
      #1;
      en = 0;  clr = 0;          // trạng thái nghỉ
      @(posedge clk);            // acc cập nhật
      #1;
      if (acc !== tong) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai o giao dich %0d: acc=%0d, dung la %0d", i, acc, tong);
      end
    end
    if (loi == 0) $display("PASS: 3000/3000");
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
