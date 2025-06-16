#!/usr/bin/env bash
#hamza bbbb
set -uo pipefail  # مكاينش set -e باش ما يخرجش فجأة

YELLOW='\033[33m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m'

FLAG_FILE="/tmp/.access_granted"

get_password() {
  # هنا تخدم الطريقة ديالك باش تجيب الباسورد من مكان بعيد، أو حط باسورد ثابت
  echo "your_secret_password"
}

block_ip() {
  local ip="$1"
  echo -e "${RED}❌ Blocking IP $ip permanently due to max password attempts.${NC}"
  iptables -I INPUT -s "$ip" -j DROP
  echo -e "${RED}❌ IP $ip blocked.${NC}"
}

if [[ ! -f "$FLAG_FILE" ]]; then
  clear
  echo -e "${YELLOW}🔐 Secure Access Panel${NC}"
  echo -e "${YELLOW}🔐 Script is protected by password${NC}"
  echo -e "${YELLOW}🔐 To get the password, contact here @a_hamza_i${NC}"

  remote_pass=$(get_password)
  max_tries=10
  attempt=1

  while (( attempt <= max_tries )); do
    read -rsp "🔐 Enter password to access (Attempt $attempt/$max_tries): " pass
    echo ""

    if [[ "$pass" == "$remote_pass" ]]; then
      touch "$FLAG_FILE"
      echo -e "${GREEN}✅ Password verified successfully.${NC}"
      break
    else
      echo -e "${RED}❌ Wrong password. Try again.${NC}"
    fi

    ((attempt++))
  done

  if (( attempt > max_tries )); then
    echo -e "${RED}❌ Maximum attempts reached. Blocking IP and exiting...${NC}"
    MY_IP=$(hostname -I | awk '{print $1}')
    block_ip "$MY_IP"
    exit 1
  fi
else
  echo -e "${GREEN}✅ Password already verified. Proceeding with script execution.${NC}"
fi
