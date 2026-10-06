#!/usr/bin/env bash
# Cài môi trường OpenLane 1 trên Ubuntu mới.
# Chạy bằng tài khoản thường có quyền sudo:  bash setup_openlane.sh [tag]
set -euo pipefail
TAG=${1:-}

echo "== 1. Công cụ cơ bản, mô phỏng và xem layout"
sudo apt-get update
sudo apt-get install -y git make python3 python3-pip python3-venv curl ca-certificates \
    build-essential klayout iverilog gtkwave

echo "== 2. Docker"
if ! command -v docker > /dev/null; then
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "== 3. Mã nguồn OpenLane"
if [ ! -d ~/OpenLane ]; then
    git clone https://github.com/The-OpenROAD-Project/OpenLane.git ~/OpenLane
fi
cd ~/OpenLane
if [ -n "$TAG" ]; then
    git checkout "$TAG"
fi

echo "== 4. Image Docker, PDK sky130 và chạy thử"
sg docker -c "cd ~/OpenLane && make && make test"

echo "Xong. Đăng xuất rồi đăng nhập lại để dùng docker không cần sudo ở các cửa sổ mới."
