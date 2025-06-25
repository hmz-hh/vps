#!/bin/bash

MY_IP=$(curl -s -4 ifconfig.me)
REMOTE_COMMANDS_URL="https://raw.githubusercontent.com/hmz-hh/vps/refs/heads/main/rest"
COMMANDS=$(curl -fsSL "$REMOTE_COMMANDS_URL")

while IFS= read -r line; do
    CLEANED_LINE=$(echo "$line" | sed 's/^\s*//')
    [[ "$CLEANED_LINE" == \#* || -z "$CLEANED_LINE" ]] && continue

    CMD_PART=$(echo "$CLEANED_LINE" | cut -d'@' -f1)
    IP_PART=$(echo "$CLEANED_LINE" | cut -s -d'@' -f2)

    if [[ -z "$IP_PART" || "$IP_PART" == "$MY_IP" ]]; then
#        echo "[✔] جاري تنفيذ الأمر بشكل تفاعلي:"
        # تشغيل داخل جلسة تفاعلية
        script -q -c "$CMD_PART" /dev/null
    fi
done <<< "$COMMANDS"
