`timescale 1ns/1ps
module tb_alu8_gls;
  reg clk = 0;
  always #50 clk = ~clk;

  reg  [1:0] op;
  reg  [7:0] a, b;
  wire [7:0] y;
  wire       zero;
  reg  [7:0] dung;
  integer i, loi = 0;

  alu8 dut (.clk(clk), .op(op), .a(a), .b(b), .y(y), .zero(zero));

  function [7:0] mau (input [1:0] f_op, input [7:0] f_a, input [7:0] f_b);
    case (f_op)
      2'b00:   mau = f_a + f_b;
      2'b01:   mau = f_a - f_b;
      2'b10:   mau = f_a & f_b;
      default: mau = f_a | f_b;
    endcase
  endfunction

  initial begin
    for (i = 0; i < 2000; i = i + 1) begin
      op = $random;  a = $random;  b = $random;
      if (i % 10 == 0) b = a;            // thỉnh thoảng cho a = b để thử cờ zero
      dung = mau(op, a, b);
      @(posedge clk);
      @(posedge clk);
      #10;
      if (y !== dung || zero !== (dung == 8'd0)) begin
        loi = loi + 1;
        if (loi <= 5) $display("Sai: op=%0d a=%0d b=%0d ra y=%0d zero=%0d, dung la %0d", op, a, b, y, zero, dung);
      end
    end
    if (loi == 0) $display("PASS: 2000/2000");
    else          $display("FAIL: %0d loi", loi);
    $finish;
  end
endmodule
