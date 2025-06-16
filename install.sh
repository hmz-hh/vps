#!/bin/bash

apt-get update -y
apt-get install -y p7zip-full wget openssl

wget -O install.zip https://script.ha-vps.store/install.zip

read -sp "🔐 أدخل كلمة المرور: " PASSWORD
echo

7z x install.zip -p"$PASSWORD" >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ كلمة السر خاطئة أو الملف تالف."
    rm -f install.zip
    exit 1
fi

echo "✅ تم فك الضغط."

rm -f install.zip

SCRIPT_FILE=$(find . -type f -name "*.sh" | head -n 1)

if [ ! -f "$SCRIPT_FILE" ]; then
    echo "⚠️ لم يتم العثور على سكريبت للتنفيذ داخل الأرشيف."
    exit 1
fi

echo "🚀 تنفيذ $SCRIPT_FILE..."
chmod +x "$SCRIPT_FILE"
./"$SCRIPT_FILE"
