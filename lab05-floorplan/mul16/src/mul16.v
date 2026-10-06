module mul16 (input clk, input [15:0] a, input [15:0] b, output reg [31:0] p);
  reg [15:0] a_r, b_r;
  always @(posedge clk) begin
    a_r <= a;
    b_r <= b;
    p   <= a_r * b_r;
  end
endmodule
