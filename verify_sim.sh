#!/usr/bin/env bash
# Chạy mọi testbench mẫu của workshop bằng iverilog. Mỗi dòng phải in PASS.
cd "$(dirname "$0")"
SIM=$(mktemp)
run() {
    local ten=$1; shift
    if iverilog -o "$SIM" "$@" 2> /tmp/iverilog_err.txt; then
        printf "%-14s %s\n" "$ten" "$(vvp -n "$SIM" | grep -E 'PASS|FAIL' | tail -1)"
    else
        printf "%-14s LOI BIEN DICH\n" "$ten"; cat /tmp/iverilog_err.txt
    fi
}
run lab00       lab00-setup/fa.v lab00-setup/tb_fa.v
run lab02-rca4  lab02-adder/rca4/src/*.v lab02-adder/rca4/tb/tb_rca4.v
run lab03-rca8  lab03-adder-compare/rca8/src/*.v lab03-adder-compare/tb_add.v
run lab03-add8  -DTOP_ADD lab03-adder-compare/add8/src/*.v lab03-adder-compare/tb_add.v
run lab03-rca16 -Ptb_add.N=16 lab03-adder-compare/rca8/src/*.v lab03-adder-compare/tb_add.v
run lab03-add16 -DTOP_ADD -Ptb_add.N=16 lab03-adder-compare/add8/src/*.v lab03-adder-compare/tb_add.v
run lab04-alu8  lab04-alu/alu8/src/alu8.v lab04-alu/alu8/tb/tb_alu8.v
run lab05-mul16 lab05-floorplan/mul16/src/mul16.v lab05-floorplan/mul16/tb/tb_mul16.v
run lab06-n8    lab06-cts-power/regbank/src/regbank.v lab06-cts-power/regbank/tb/tb_regbank.v
run lab06-n16   -Ptb_regbank.N=16 lab06-cts-power/regbank/src/regbank.v lab06-cts-power/regbank/tb/tb_regbank.v
run lab06-n32   -Ptb_regbank.N=32 lab06-cts-power/regbank/src/regbank.v lab06-cts-power/regbank/tb/tb_regbank.v
run lab08-mac8  lab08-mini-project/mac8/src/mac8.v lab08-mini-project/mac8/tb/tb_mac8.v
rm -f "$SIM" fa.vcd
