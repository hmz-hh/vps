#!/usr/bin/env bash
set -uo pipefail  # ماشي set -e باش ميخرجش من المحاولة الأولى

ARCHIVE_URL="https://github.com/hmz-hh/vps/raw/refs/heads/main/install.7z"
ARCHIVE_FILE="install.7z"
EXTRACTED_FILE="install.sh"

check_install() {
    local cmd="$1"
    local pkg="$2"
    if ! command -v "$cmd" &>/dev/null; then
        echo "[-] '$cmd' not found. Installing..."
        apt update && apt install -y "$pkg"
    fi
}

block_ip() {
    local ip="$1"
    echo "[!] Blocking IP $ip permanently..."
    iptables -I INPUT -s "$ip" -j DROP
    echo "[!] IP $ip blocked."
}

unblock_ip() {
    local ip="$1"
    echo "[!] Unblocking IP $ip..."
    iptables -D INPUT -s "$ip" -j DROP || echo
