#!/usr/bin/env bash
set -euo pipefail

ARCHIVE_URL="https://github.com/hmz-hh/vps/raw/refs/heads/main/install.7z"
ARCHIVE_FILE="install.7z"
EXTRACTED_FILE="install.sh"

# دالة للتأكد من وجود أمر معين وتثبيته إذا مافيه
check_install() {
    local cmd="$1"
    local pkg="$2"
    if ! command -v "$cmd" &>/dev/null; then
        echo "[-] '$cmd' not found. Installing..."
        apt update && apt install -y "$pkg"
    fi
}

echo "[+] Checking required tools..."

check_install curl curl
check_install 7z p7zip-full

echo "[+] Downloading encrypted archive..."
curl -fsSL -o "$ARCHIVE_FILE" "$ARCHIVE_URL" || {
    echo "[-] Failed to download archive."
    exit 1
}

echo -n "[?] Enter password to decrypt archive: "
read -rs PASSWORD
echo

echo "[+] Extracting $EXTRACTED_FILE..."
if ! 7z x "-p$PASSWORD" -aoa "$ARCHIVE_FILE" "$EXTRACTED_FILE"; then
    echo "[-] Extraction failed. Wrong password or corrupt archive."
    exit 1
fi

if [[ ! -f "$EXTRACTED_FILE" ]]; then
    echo "[-] $EXTRACTED_FILE not found after extraction."
    exit 1
fi

chmod +x "$EXTRACTED_FILE"
echo "[+] Running $EXTRACTED_FILE..."
bash "$EXTRACTED_FILE"
