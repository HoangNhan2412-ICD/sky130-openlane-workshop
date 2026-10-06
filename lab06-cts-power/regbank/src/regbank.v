module regbank #(parameter N = 8) (input clk, input en, input [7:0] d,
                                   output [7:0] q);
  reg [8*N-1:0] sr;                       // N từ 8 bit nối liền nhau
  always @(posedge clk)
    if (en) sr <= {sr[8*N-9:0], d};       // dịch lên một từ, d vào từ thấp nhất
  assign q = sr[8*N-1 -: 8];              // từ cao nhất
endmodule
