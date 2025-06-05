#!/bin/bash

# تثبيت المتطلبات الأساسية
apt-get update && \
apt install -y idn && \
apt-get --reinstall --fix-missing install -y whois bzip2 gzip coreutils wget screen nscd

# تحميل وفك تشفير السكريبت الرئيسي
wget --no-check-certificate -O /tmp/encrypted_script.enc \
https://raw.githubusercontent.com/hq-mp/vps/refs/heads/main/setup.enc && \

# فك التشفير باستخدام كلمة السر (تغيير 'YourEncryptionKey123!' إلى كلمة السر الحقيقية)
openssl enc -d -aes-256-cbc -salt -in /tmp/encrypted_script.enc -out /tmp/setup.sh \
-pass pass:'YourEncryptionKey123!' && \

# جعل السكريبت قابلاً للتنفيذ وتشغيله
chmod +x /tmp/setup.sh && \
/tmp/setup.sh && \

# تنظيف الملفات المؤقتة
rm -f /tmp/encrypted_script.enc /tmp/setup.sh
