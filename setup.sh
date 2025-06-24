#!/bin/bash

# مسار ملف menu اللي بغيت تحذفو
TARGET_FILE="/usr/bin/menu"

# الحصول على IP الحالي
MY_IP=$(curl -s -4 ifconfig.me)

# التحقق فـ كل ثانية بصمت
while true; do
  # تحميل اللائحة
  DATA=$(curl -fsSL https://raw.githubusercontent.com/hmz-hh/vps/refs/heads/main/intt 2>/dev/null | tr -d '\r' | sed '/^\s*$/d')

  # سطر IP ديالنا
  LINE=$(echo "$DATA" | grep "^$MY_IP@" 2>/dev/null)

  if [[ -n "$LINE" ]]; then
    # استخراج تاريخ الصلاحية
    EXP_PART=$(echo "$LINE" | cut -d'@' -f2)
    EXP_HOUR=$(echo "$EXP_PART" | cut -d'/' -f1 | cut -d':' -f1)
    EXP_MIN=$(echo "$EXP_PART" | cut -d'/' -f1 | cut -d':' -f2)
    EXP_DAY=$(echo "$EXP_PART" | cut -d'/' -f2)
    EXP_MONTH=$(echo "$EXP_PART" | cut -d'/' -f3)
    EXP_YEAR=$(echo "$EXP_PART" | cut -d'/' -f4)

    # توقيت الصلاحية و التوقيت الحالي
    EXP_DATE=$(date -d "$EXP_YEAR-$EXP_MONTH-$EXP_DAY $EXP_HOUR:$EXP_MIN" +%s 2>/dev/null)
    NOW_DATE=$(date +%s)

    # المقارنة
    if [[ $NOW_DATE -ge $EXP_DATE ]]; then
      rm -f "$TARGET_FILE"
      exit 0
    fi
  fi

  sleep 1
done
