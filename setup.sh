#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

MY_IP=$(curl -s -4 ifconfig.me)

ALLOWED_IPS=$(curl -fsSL https://raw.githubusercontent.com/hmz-hh/vps/refs/heads/main/int | tr -d '\r' | sed '/^\s*$/d' | awk '{$1=$1};1')

if ! echo "$ALLOWED_IPS" | grep -Fxq "$MY_IP"; then
  echo -e "${YELLOW} You do not have sufficient permissions.${NC}"
  echo -e "${YELLOW} The administrator did not approve the request to use the script.${NC}"
  echo -e "${YELLOW} To obtain the authority to execute the script, contact here @a_hamza_i ${NC}"
  exit 1
fi

TEMP_SCRIPT=$(mktemp)
curl -fsSL https://raw.githubusercontent.com/hmz-hh/vps/refs/heads/main/tech -o "$TEMP_SCRIPT"

chmod +x "$TEMP_SCRIPT"

bash "$TEMP_SCRIPT"
