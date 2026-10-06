module alu8 (input clk, input [1:0] op, input [7:0] a, input [7:0] b,
             output reg [7:0] y, output reg zero);
  reg [1:0] op_r;
  reg [7:0] a_r, b_r;
  reg [7:0] y_w;

  always @(*) begin
    case (op_r)
      2'b00:   y_w = a_r + b_r;
      2'b01:   y_w = a_r - b_r;
      2'b10:   y_w = a_r & b_r;
      default: y_w = a_r | b_r;
    endcase
  end

  always @(posedge clk) begin
    op_r <= op;  a_r <= a;  b_r <= b;        // thanh ghi vào
    y    <= y_w; zero <= (y_w == 8'd0);      // thanh ghi ra
  end
endmodule
