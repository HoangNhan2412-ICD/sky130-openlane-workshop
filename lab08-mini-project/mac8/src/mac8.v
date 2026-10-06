module mac8 (input clk, input clr, input en, input [7:0] a, input [7:0] b,
             output reg [19:0] acc);
  reg [7:0] a_r, b_r;
  reg       en_r, clr_r;

  always @(posedge clk) begin
    a_r <= a;  b_r <= b;  en_r <= en;  clr_r <= clr;   // thanh ghi vào
    if (clr_r)     acc <= 20'd0;
    else if (en_r) acc <= acc + a_r * b_r;             // acc là thanh ghi ra
  end
endmodule
