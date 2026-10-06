module tb_fa;
  reg a, b, cin;
  wire s, cout;
  integer i, loi = 0;
  fa dut (.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
  initial begin
    $dumpfile("fa.vcd"); $dumpvars(0, tb_fa);
    for (i = 0; i < 8; i = i + 1) begin
      {a, b, cin} = i; #10;
      if ({cout, s} !== a + b + cin) loi = loi + 1;
    end
    if (loi == 0) $display("PASS"); else $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
