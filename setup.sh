#!/bin/bash
clear
sleep 1

#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

FLAG_FILE="/tmp/.script_authenticated"

get_url() {
  part8="this_is_fake_part"
  part9="another/fake/dir"
  part10="backup_ftp://trash.net"
  part16="debug_mode=off"
  part17="pass"
  part18="fake"
  part19="dev/null/path"
  part20="end_of_nonsense"
  a12="/fake"
  a1="https"
  a2="://"
  a3="raw"
  a4=".github"
  a8="/zi-vpn.com"
  a5="usercontent"
  a6=".com"
  a7="/hq-mp"
  a9="/refs"
  a10="/heads"
  a11="/main"

  echo "${a1}${a2}${a3}${a4}${a5}${a6}${a7}${a8}${a9}${a10}${a11}${a12}"
}

get_password() {
  curl -s "$(get_url)"
}

if [[ ! -f "$FLAG_FILE" ]]; then
  clear
  echo -e "${YELLOW} 🔐  Secure Access Panel${NC}"
  echo -e "${YELLOW} 🔐  Script is protected by password${NC}"
  echo -e "${YELLOW} 🔐  To get the password, contact here @a_hamza_i ${NC}"

  remote_pass=$(get_password)
  max_tries=10
  attempt=1

  while (( attempt <= max_tries )); do
    read -sp " 🔐  Enter password to access (Attempt $attempt/$max_tries): " pass
    echo ""

    if [[ "$pass" == "$remote_pass" ]]; then
      touch "$FLAG_FILE"
      echo -e "${GREEN} ✅  Password verified successfully.${NC}"
      break
    else
      echo -e "${RED} ❌  Wrong password. Try again.${NC}"
    fi

    ((attempt++))
  done

  if (( attempt > max_tries )); then
    echo -e "${RED} ❌  Maximum attempts reached. Exiting...${NC}"
    exit 1
  fi
else
  echo -e "${GREEN} ✅  Password already verified. Proceeding with script execution.${NC}"
fi  

Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
stty erase ^?

TIMES="10"
NAMES=$(whoami)
IMP="wget -q -O"
LOCAL_DATE="/usr/bin/"
MYIP=$(wget -qO- ipinfo.io/ip)
CITY=$(wget -qO- ipinfo.io/city)
TIME=$(date '+1859745515 100 %Y')
RAMMS=$(free -m | awk 'NR==2 {print $2}')

OS=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
Date_list=$(date +"%Y-No such file or directory-1" -d "$dateFromServer")
source '/etc/os-release'

logo() {
    echo -e ""
    echo -e "    ┌───────────────────────────────────────────────┐"
    echo -e " ───│                                               │───"
    echo -e " ───│    $Green┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┬─┐┬┌─┐┌┬┐  ┬  ┬┌┬┐┌─┐$NC   │───"
    echo -e " ───│    $Green├─┤│ │ │ │ │└─┐│  ├┬┘│├─┘ │   │  │ │ ├┤ $NC   │───"
    echo -e " ───│    $Green┴ ┴└─┘ ┴ └─┘└─┘└─┘┴└─┴┴   ┴   ┴─┘┴ ┴ └─┘$NC   │───"
    echo -e "    │    ${YELLOW}Copyright${FONT} (C)${GRAY}https://t.me/a_hamza_i$NC    ‌ ‌ ‌‌  │"
    echo -e "    └───────────────────────────────────────────────┘"
    echo -e "        "

}

cd "$(
cd "$(dirname "$0")" || exit
pwd
)" || exit

secs_to_human() {
    echo -e "${WB}Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds${NC}"
}

start=$(date +%s)

INS="sudo apt-get install -y"

ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi
}

msg() {
    if [[ 0 -eq $? ]]; then
        print_ok "$1 Complete... ${YELLOW}Rencong Tunnel${FONT}"
        sleep 1
    fi
}

check_vz() {
    if [ -f /proc/user_beancounters ]; then
        msg "OpenVZ VPS is not supported."
        exit
    fi
}

REPO="https://raw.githubusercontent.com/hq-mp/pp/refs/heads/main/"

function make_folder_xray() {
    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/xray/city
    rm -rf /etc/xray/isp
    mkdir -p /etc/xray
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /usr/bin/xray/
    mkdir -p /var/log/xray/
    mkdir -p /var/www/html
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    echo "& plughin Account" >>/etc/vmess/.vmess.db
    echo "& plughin Account" >>/etc/vless/.vless.db
    echo "& plughin Account" >>/etc/trojan/.trojan.db
    echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
    echo "& plughin Account" >>/etc/ssh/.ssh.db
}

function add_domain() {
    read -p "Input Domain :  " domain
    if [[ ${domain} ]]; then
        echo $domain >/etc/xray/domain
    else
        echo -e " ${RED}Please input your Domain${FONT}"
        echo -e ""
        echo -e " Start again in 5 seconds"
        echo -e ""
        sleep 5
        
        rm -rf setup.sh
        exit 1
    fi
}

function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi
}

check_vz() {
    if [ -f /proc/user_beancounters ]; then
        msg "OpenVZ VPS is not supported."
        exit
    fi
}

packagesDebian() {
    print_ok "update repository python"
    apt install python3 python3-pip -y
    sudo apt-get install build-essential checkinstall -y
    sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
    cd /opt
    sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
    sudo tar xzf Python-3.8.12.tgz
    cd Python-3.8.12
    sudo ./configure --enable-optimizations
    sudo make altinstall
}

updatePackages() {
    apt update -y
    apt install sudo -y
    sudo apt-get clean all
    sudo apt-get autoremove -y
    sudo apt-get install -y debconf-utils
    sudo apt-get remove --purge exim4 -y
    sudo apt-get remove --purge ufw firewalld -y
    sudo apt-get install -y --no-install-recommends software-properties-common
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    /etc/init.d/vnstat restart
    wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
    tar zxvf vnstat-2.6.tar.gz
    cd vnstat-2.6
    ./configure --prefix=/usr --sysconfdir=/etc >/dev/null 2>&1 && make >/dev/null 2>&1 && make install >/dev/null 2>&1
    cd
    vnstat -u -i $NET
    sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
    chown vnstat:vnstat /var/lib/vnstat -R
    systemctl enable vnstat
    /etc/init.d/vnstat restart
    rm -f /root/vnstat-2.6.tar.gz >/dev/null 2>&1
    rm -rf /root/vnstat-2.6 >/dev/null 2>&1
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        msg "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        sudo apt update -y
        apt-get install --no-install-recommends software-properties-common
        add-apt-repository ppa:vbernat/haproxy-2.0 -y
        apt-get -y install haproxy=2.0.\*
        packagesDebian
        elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        msg "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        curl https://haproxy.debian.net/bernat.debian.org.gpg |
        gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
        echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
        http://haproxy.debian.net buster-backports-1.8 main \
        >/etc/apt/sources.list.d/haproxy.list
        sudo apt-get update
        apt-get -y install haproxy=1.8.\*
        packagesDebian
    else
        echo -e "${RED} Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC} )"
        exit 1
    fi
}

function insDepedency() {
    echo ""
    echo "Please wait to install Package..."
    apt-get update
    msg "Update configuration"
    
    msg "Installed openvpn easy-rsa"
    source <(curl -sL ${REPO}openvpn/openvpn)
    source <(curl -sL ${REPO}badvpn/ins-badvpn)
    
    msg "Installed itil vpn"
    wget -O /etc/pam.d/common-password "${REPO}openvpn/common-password" >/dev/null 2>&1
    chmod +x /etc/pam.d/common-password
    
    msg "Installed dropbear"
    apt-get install dropbear -y
    
}

function acme() {
    #    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    msg "installed successfully SSL certificate generation script"
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop haproxy
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/yha.pem
    chown www-data.www-data /etc/xray/xray.key
    chown www-data.www-data /etc/xray/xray.crt
    msg "Installed slowdns"
    wget -q -O /etc/nameserver "${REPO}slowdns/nameserver" && bash /etc/nameserver >/dev/null 2>&1
    
}

function insNginx() {
    apt clean all && apt update
    ntpdate pool.ntp.org
    apt -y install chrony
    apt install curl pwgen chrony socat openssl netcat cron -y
    
    source <(curl -sL ${REPO}utility/bbr)
    # // Checking System
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        msg "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        rm -f /etc/apt/sources.list.d/nginx.list
        sudo apt-get install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |
        tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
        http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" |
        tee /etc/apt/sources.list.d/nginx.list
        echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" |
        tee /etc/apt/preferences.d/99nginx
        
        apt update -y
        sudo apt-get install -y nginx
        elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        msg "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        rm -f /etc/apt/sources.list.d/nginx.list
        sudo apt-get install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |
        tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
        http://nginx.org/packages/debian $(lsb_release -cs) nginx" |
        tee /etc/apt/sources.list.d/nginx.list
        echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" |
        tee /etc/apt/preferences.d/99nginx
        
        apt update -y
        sudo apt-get install -y nginx
    else
        echo -e "${RED} Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC} )"
        exit 1
    fi
    
    apt-get purge apache2 -y
    apt-get autoremove -y
}

function confNginx() {
    cd
    rm /etc/nginx/conf.d/default.conf
    wget -O /etc/nginx/nginx.conf "${REPO}nginx/nginx.conf" >/dev/null 2>&1
    
    msg "Configurasi Nginx Berhasil !"
}


function insHaproxy() {
    wget -O /usr/sbin/haproxy "${REPO}haproxy/haproxy" >/dev/null 2>&1
    chmod +x /usr/sbin/haproxy
cat >/lib/systemd/system/haproxy.service <<EOF
[Unit]
Description=Rencong Tunnel Load Balancer
Documentation=https://github.com/firdaus-rx
After=network-online.target rsyslog.service

[Service]
ExecStart=/usr/sbin/haproxy -Ws -f /etc/haproxy/haproxy.cfg -p 18173
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF
    
    curl "${REPO}utility/download.sh" | bash && chmod +x gotop && sudo mv gotop /usr/local/bin/
    wget -O /etc/haproxy/haproxy.cfg "${REPO}haproxy/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${REPO}nginx/xray" >/dev/null 2>&1
}

function insConfig() {
    cd
    rm -rf *
    wget ${REPO}utility/menu.zip
    unzip menu.zip
    rm -f menu.zip
    chmod +x *
    mv * /usr/bin/
    
	cat >/root/.profile <<END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
menu
END
    
    # remove expired
	cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/bin/xp
	END
    
    # clean log
	cat >/etc/cron.d/logclean <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/59 * * * * root /usr/bin/logclean
	END
    chmod 644 /root/.profile
    
    # auto reboot
	cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 5 * * * root /sbin/reboot
	END
    
    service cron restart
	cat >/home/daily_reboot <<-END
		5
	END
    
    # limit ip xray
	cat >/etc/cron.d/x_limp <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/10 * * * * root /usr/bin/xraylimit
	END
    
	cat >/etc/systemd/system/rc-local.service <<-END
		[Unit]
		Description=/etc/rc.local
		ConditionPathExists=/etc/rc.local
		[Service]
		Type=forking
		ExecStart=/etc/rc.local start
		TimeoutSec=0
		StandardOutput=tty
		RemainAfterExit=yes
		SysVStartPriority=99
		[Install]
		WantedBy=multi-user.target
	END
    
    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    
	cat >/etc/rc.local <<-END
		#!/bin/sh -e
		# rc.local
		# By default this script does nothing.
		#iptables -I INPUT -p udp --dport 5300 -j ACCEPT
		#iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
		netfilter-persistent reload
		#exit 0
	END
    chmod +x /etc/rc.local
    
    AUTOREB=$(cat /home/daily_reboot)
    
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
}

function inSquid() {
    apt install squid -y
    
    wget -q -O /etc/squid/squid.conf "${REPO}squid/squid.conf" >/dev/null 2>&1
    wget -q -O /etc/ssh/sshd_config "${REPO}squid/sshd" >/dev/null 2>&1
    wget -q -O /etc/default/dropbear "${REPO}dropbear/dropbear" >/dev/null 2>&1
    wget -q -O /etc/banner "${REPO}dropbear/banner" >/dev/null 2>&1
    
}

function insWs() {
    # wget -O /usr/bin/ws "${REPO}websocket/ws" >/dev/null 2>&1
    # chmod +x /usr/bin/ws

    wget -O /usr/bin/tun.conf "${REPO}websocket/tun.conf" >/dev/null 2>&1
    chmod 644 /usr/bin/tun.conf

    wget -O /usr/bin/ws.py "${REPO}websocket/ws.py" >/dev/null 2>&1
    chmod +x /usr/bin/ws.py

    # wget -O /etc/systemd/system/ws.service "${REPO}websocket/ws.service" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${REPO}websocket/socks.service" >/dev/null 2>&1
    chmod +x /etc/systemd/system/ws.service
}


function insXray() {
    msg "Core Xray 1.7.5 Version installed successfully"
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.7.5
    
    wget -O /etc/xray/config.json "${REPO}xray/config.json" >/dev/null 2>&1
    
    wget -q -O /etc/ipserver "${REPO}utility/ipserver" && bash /etc/ipserver >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
    
    rm -rf /etc/systemd/system/xray.service.d
cat >/etc/systemd/system/xray.service <<EOF
[Unit]
Description=Rencong Tunnel Server Xray
Documentation=https://t.me/firdaus_rx
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=yes
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
    
}

insUdp() {
    echo "جاري تثبيت UDP المخصص..."
    if ! wget -O /usr/bin/udp "${REPO}utility/udp-custom-linux-amd64" >/dev/null 2>&1; then
        echo "خطأ: فشل تحميل UDP المخصص"
        return 1
    fi

    chmod +x /usr/bin/udp

    # إنشاء ملف الإعدادات
    cat >/usr/bin/config.json <<-END
{
    "listen": ":2100",
    "stream_buffer": 33554432,
    "receive_buffer": 83886080,
    "auth": {
        "mode": "passwords"
    }
}
END

    # إنشاء خدمة النظام
    cat >/etc/systemd/system/udp.service <<EOF
[Unit]
Description=UDP Custom VPN Server
After=network.target

[Service]
User=root
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/udp server --config /usr/bin/config.json
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true
LimitNPROC=10000
LimitNOFILE=1000000
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable udp
    systemctl start udp
}

# وظيفة إعادة تشغيل النظام
function restart_system() {
    echo "جاري إعداد إعادة تشغيل الخدمات..."
    TIMEZONE=$(date +'%H:%M:%S')
    
    # تحميل إعدادات Xray
    if ! source <(curl -sL ${REPO}xray/tunlp); then
        echo "تحذير: فشل تحميل إعدادات Xray"
    fi

    # إعادة تحميل systemd
    systemctl daemon-reload

    # تمكين الخدمات الأساسية
    systemctl enable client
    systemctl enable server
    systemctl enable netfilter-persistent
    systemctl enable ws
    systemctl enable haproxy
    systemctl enable udp

    # بدء تشغيل الخدمات الأساسية
    echo "جاري بدء تشغيل الخدمات الأساسية..."
    systemctl start client
    systemctl start server
    systemctl start haproxy
    systemctl start netfilter-persistent

    # جميع أوامر إعادة التشغيل كما طلبت في الأسفل
    echo "جاري إعادة تشغيل جميع الخدمات..."
    systemctl restart nginx
    systemctl restart xray
    systemctl restart sshd
    systemctl restart rc-local
    systemctl restart client
    systemctl restart server
    systemctl restart dropbear
    systemctl restart ws
    systemctl restart openvpn
    systemctl restart cron
    systemctl restart haproxy
    systemctl restart netfilter-persistent
    systemctl restart ws
    systemctl restart udp

    # التحقق من حالة الخدمات
    echo "جاري التحقق من حالة الخدمات..."
    check_service_status() {
        local service=$1
        if systemctl is-active --quiet $service; then
            echo "[✓] الخدمة $service تعمل بنجاح"
        else
            echo "[✗] فشل تشغيل الخدمة $service"
            journalctl -u $service -xe --no-pager | tail -n 5
        fi
    }

    # التحقق من الخدمات الهامة
    check_service_status xray
    check_service_status nginx
    check_service_status udp
    check_service_status sshd

    # عرض معلومات الخدمات
    clear
    echo "    ┌─────────────────────────────────────────────────────┐"
    echo "    │       معلومات الخدمات والمنافذ                     │"
    echo "    │   - SSH عادي                 : 22                  │"
    echo "    │   - UDP SSH                  : 1-65535             │"
    echo "    │   - DNS (SLOWDNS)            : 443, 80, 53         │"
    echo "    │   - Dropbear                 : 443, 109, 143       │"
    echo "    │   - OpenVPN                  : 443, 1194, 2200     │"
    echo "    │   - Nginx                    : 443, 80, 81         │"
    echo "    │   - Xray                     : 443, 80             │"
    echo "    │   - UDP Custom               : 2100                │"
    echo "    └─────────────────────────────────────────────────────┘"
    echo "    │   - المنطقة الزمنية          : Asia/Jakarta (GMT+7)│"
    echo "    │   - إعادة التشغيل التلقائي   : ${AUTOREB}:00        │"
    echo "    └─────────────────────────────────────────────────────┘"

    # طلب إعادة تشغيل النظام
    read -p "هل تريد إعادة تشغيل الخادم الآن؟ [y/n] " reboot_choice
    if [[ "$reboot_choice" == "y" || "$reboot_choice" == "Y" ]]; then
        echo "جاري إعادة تشغيل الخادم..."
        reboot
    else
        echo "يمكنك إعادة التشغيل يدوياً لاحقاً باستخدام الأمر: reboot"
    fi
}

# وظيفة التثبيت الرئيسية
function install_sc() {
    # تثبيت المتطلبات الأساسية
    insDepedency || {
        echo "خطأ: فشل تثبيت المتطلبات الأساسية"
        return 1
    }

    # تثبيت ACME و Nginx
    acme || echo "تحذير: فشل تثبيت ACME"
    insNginx || echo "تحذير: فشل تثبيت Nginx"
    confNginx || echo "تحذير: فشل تكوين Nginx"

    # تثبيت المكونات الأخرى
    insHaproxy
    insConfig
    inSquid
    insWs

    # تثبيت Xray مع محاولة إضافية في حالة الفشل
    if ! insXray; then
        echo "المحاولة الأولى فشلت، جاري المحاولة الثانية لتثبيت Xray..."
        insXray || {
            echo "خطأ: فشل تثبيت Xray بعد محاولتين"
            return 1
        }
    fi

    # تثبيت UDP المخصص
    insUdp || echo "تحذير: فشل تثبيت UDP المخصص"

    # إعادة تشغيل النظام
    restart_system
}

# بدء التثبيت
{
    # إنشاء مجلد Xray
    make_folder_xray

    # إضافة النطاق
    add_domain

    # التحقق من صلاحيات root
    is_root

    # التحقق من بيئة التشغيل
    check_vz

    # تحديث الحزم
    updatePackages

    # بدء التثبيت
    install_sc
}
