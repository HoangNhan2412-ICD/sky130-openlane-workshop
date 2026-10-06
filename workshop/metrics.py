#!/usr/bin/env python3
# In các cột trong metrics.csv của OpenLane có tên chứa từ khóa.
# Cách dùng: python3 workshop/metrics.py <đường dẫn metrics.csv> [từ khóa ...]
import csv, sys

duong_dan = sys.argv[1]
tu_khoa = [t.lower() for t in sys.argv[2:]]
with open(duong_dan) as f:
    dong = next(csv.DictReader(f))
for ten, gia_tri in dong.items():
    if not tu_khoa or any(t in ten.lower() for t in tu_khoa):
        print(f"{ten:45s} {gia_tri}")
