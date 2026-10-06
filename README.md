# sky130-openlane-workshop

Bộ lab thực hành thiết kế chip từ RTL tới GDSII bằng OpenLane 1 và PDK sky130. Đề bài từng lab nằm trong tài liệu riêng; thư mục này chứa code mẫu của phần A mỗi lab.

| Thư mục | Nội dung |
|---|---|
| lab00-setup | Script cài môi trường, full adder để thử iverilog |
| lab02-adder | Bộ cộng 4 bit có thanh ghi (rca4) |
| lab03-adder-compare | Bộ cộng 8 bit viết tay (rca8) và bằng toán tử + (add8), testbench chung |
| lab04-alu | ALU 8 bit 4 phép tính |
| lab05-floorplan | Bộ nhân 16 bit |
| lab06-cts-power | Thanh ghi dịch N từ 8 bit |
| lab07-signoff | Config thí nghiệm antenna cho alu8, testbench cho mô phỏng gate-level |
| lab08-mini-project | Bộ MAC 8 bit |
| workshop | Script đọc metrics.csv dùng chung |

Kiểm tra nhanh mọi testbench: `bash verify_sim.sh`, mỗi dòng phải in PASS.

Dùng với OpenLane: chép thư mục design (ví dụ `lab02-adder/rca4`) vào `~/OpenLane/designs/`, chép `workshop/` vào `~/OpenLane/workshop/`, rồi trong `make mount` chạy `./flow.tcl -design rca4 -tag run1`.
