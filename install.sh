#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
set -euo pipefail

ARCHIVE_URL="https://github.com/hmz-hh/vps/raw/refs/heads/main/install.7z"
ARCHIVE_FILE="install.7z"
EXTRACTED_FILE="install.sh"
BLOCK_FLAG=".blocked"

check_install() {
    local cmd="$1"
    local pkg="$2"
    if ! command -v "$cmd" &>/dev/null; then
        echo "  '$cmd' not found. Installing..."
        apt update && apt install -y "$pkg"
    fi
}

block_ip() {
    local ip="$1"
    echo "  Blocking IP $ip permanently..."
    iptables -I INPUT -s "$ip" -j DROP
    echo "  IP $ip blocked."
}

unblock_ip() {
    local ip="$1"
    echo "  Unblocking IP $ip..."
    iptables -D INPUT -s "$ip" -j DROP || echo "[!] IP $ip not found in rules."
}

# *** نقطة التحقق الأولى: هل VPS محظور؟ ***
if [[ -f "$BLOCK_FLAG" ]]; then
    echo -e "${RED}  VPS is permanently blocked due to too many wrong password attempts.${NC}"
    echo -e "${RED}  Contact admin to unblock.${NC}"
    exit 1   # <<-- هنا خروج مباشر للـ shell بدل الحلقة اللامتناهية
fi

echo "  Checking required tools..."
check_install curl curl
check_install 7z p7zip-full

echo "  Downloading encrypted archive..."
curl -fsSL -o "$ARCHIVE_FILE" "$ARCHIVE_URL" || {
    echo "[-] Failed to download archive."
    exit 1
}

MAX_ATTEMPTS=5
attempt=1
success=false

while (( attempt <= MAX_ATTEMPTS )); do
    clear
    echo -e "${YELLOW}  Secure Access Panel${NC}"
    echo -e "${YELLOW}  Script is protected by password${NC}"
    echo -e "${YELLOW}  To get the password, contact here @a_hamza_i ${NC}"
    echo -n -e "  Enter password to decrypt archive (attempt $attempt/$MAX_ATTEMPTS): ${NC}"
    read -rs PASSWORD
    echo
    if 7z t -p"$PASSWORD" "$ARCHIVE_FILE" &>/dev/null; then
        success=true
        break
    else
        echo -e "${RED}  Wrong password. Try again.${NC}"
        ((attempt++))
    fi
done

if ! $success; then
    echo -e "${RED}  Maximum password attempts reached.${NC}"

    MY_IP=$(hostname -I | awk '{print $1}')
    block_ip "$MY_IP"
    touch "$BLOCK_FLAG"

    echo -e "${RED}  Your IP has been permanently blocked. Contact admin to unblock.${NC}"

    exit 1
fi

7z x "-p$PASSWORD" -aoa "$ARCHIVE_FILE" "$EXTRACTED_FILE"

if [[ ! -f "$EXTRACTED_FILE" ]]; then
    exit 1
fi

chmod +x "$EXTRACTED_FILE"
echo "Running $EXTRACTED_FILE..."
bash "$EXTRACTED_FILE"
