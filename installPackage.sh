#!/usr/bin/env bash
#
# Ubuntu 26.04 LTS (Resolute) — dev / desktop bootstrap
# Modernized from a focal-era install script.
#
# Usage:
#   chmod +x ubuntu-26-dev-setup.sh
#   ./ubuntu-26-dev-setup.sh
#
# Optional: edit ENABLE_* flags below before running.

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# --- toggles (set to 0 to skip a section) ---
ENABLE_PRITUNL_CLIENT=1
ENABLE_PRITUNL_SERVER=0
ENABLE_DOCKER=1
ENABLE_MONGODB=1
ENABLE_NODEJS=1          # Node.js 22 LTS via NodeSource
ENABLE_RABBITMQ=1
ENABLE_LAMP=1            # Apache + PHP 8 + MySQL
ENABLE_PHPMYADMIN=0      # interactive; enable if you want it
ENABLE_MINIKUBE=1
ENABLE_DESKTOP_EXTRAS=1

# Vendor suites: use noble (24.04) until vendors ship resolute
VENDOR_SUITE="${VENDOR_SUITE:-noble}"
ARCH="$(dpkg --print-architecture)"
. /etc/os-release

if [[ "${VERSION_CODENAME:-}" != "resolute" ]]; then
  echo "Warning: expected Ubuntu 26.04 (resolute); detected: ${VERSION_CODENAME:-unknown}"
  read -r -p "Continue anyway? [y/N] " ans
  [[ "${ans,,}" == "y" ]] || exit 1
fi

if [[ "$(id -u)" -eq 0 ]]; then
  echo "Run as a normal user with sudo, not as root."
  exit 1
fi

log() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
run() { log "$*"; sudo "$@"; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing command: $1"; exit 1; }
}

install_prereqs() {
  log "Base packages"
  run apt-get update
  run apt-get install -y \
    ca-certificates curl wget gnupg apt-transport-https software-properties-common \
    build-essential pkg-config
}

write_keyring() {
  # write_keyring <url> <keyring-path>
  local url="$1" keyring="$2"
  curl -fsSL "$url" | gpg --dearmor | sudo tee "$keyring" >/dev/null
  sudo chmod a+r "$keyring"
}

setup_pritunl_client() {
  [[ "$ENABLE_PRITUNL_CLIENT" -eq 1 ]] || return 0
  log "Pritunl client (suite: ${VENDOR_SUITE})"
  write_keyring \
    "https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc" \
    /usr/share/keyrings/pritunl-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/pritunl-archive-keyring.gpg] https://repo.pritunl.com/stable/apt ${VENDOR_SUITE} main" \
    | sudo tee /etc/apt/sources.list.d/pritunl.list >/dev/null
  run apt-get update
  run apt-get install -y pritunl-client-electron
}

setup_pritunl_server() {
  [[ "$ENABLE_PRITUNL_SERVER" -eq 1 ]] || return 0
  log "Pritunl VPN server"
  run apt-get install -y pritunl
}

setup_docker() {
  [[ "$ENABLE_DOCKER" -eq 1 ]] || return 0
  log "Docker CE"
  sudo install -m 0755 -d /etc/apt/keyrings
  write_keyring \
    "https://download.docker.com/linux/ubuntu/gpg" \
    /etc/apt/keyrings/docker.asc
  echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${VERSION_CODENAME} stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  run apt-get update
  run apt-get install -y \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
  if ! groups "$USER" | grep -q '\bdocker\b'; then
    sudo usermod -aG docker "$USER"
    echo "Added $USER to group docker — log out and back in before using docker without sudo."
  fi
}

setup_mongodb() {
  [[ "$ENABLE_MONGODB" -eq 1 ]] || return 0
  log "MongoDB 8.0 (vendor suite: ${VENDOR_SUITE})"
  write_keyring \
    "https://pgp.mongodb.com/server-8.0.asc" \
    /usr/share/keyrings/mongodb-server-8.0.gpg
  echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu ${VENDOR_SUITE}/mongodb-org/8.0 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null
  run apt-get update
  run apt-get install -y mongodb-org
  sudo systemctl enable --now mongod
}

setup_nodejs() {
  [[ "$ENABLE_NODEJS" -eq 1 ]] || return 0
  log "Node.js 22 LTS (NodeSource)"
  require_cmd curl
  curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
  run apt-get install -y nodejs
  # Yarn via Corepack (ships with Node 16+)
  if command -v corepack >/dev/null 2>&1; then
    sudo corepack enable || true
    corepack prepare yarn@stable --activate || true
  fi
}

setup_rabbitmq() {
  [[ "$ENABLE_RABBITMQ" -eq 1 ]] || return 0
  log "RabbitMQ (deb.rabbitmq.com, suite: ${VENDOR_SUITE})"
  write_keyring \
    "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" \
    /usr/share/keyrings/com.rabbitmq.team.gpg
  sudo tee /etc/apt/sources.list.d/rabbitmq.list >/dev/null <<EOF
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb1.rabbitmq.com/rabbitmq-erlang/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb2.rabbitmq.com/rabbitmq-erlang/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb1.rabbitmq.com/rabbitmq-server/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb2.rabbitmq.com/rabbitmq-server/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
EOF
  run apt-get update
  run apt-get install -y erlang-base erlang-asn1 erlang-crypto erlang-eldap erlang-ftp \
    erlang-inets erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
    erlang-runtime-tools erlang-snmp erlang-ssl erlang-syntax-tools erlang-tftp \
    erlang-tools erlang-xmerl
  run apt-get install -y rabbitmq-server
  sudo systemctl enable --now rabbitmq-server
}

setup_lamp() {
  [[ "$ENABLE_LAMP" -eq 1 ]] || return 0
  log "Apache + PHP 8 + MySQL"
  run apt-get install -y \
    apache2 libapache2-mod-php php php-cli php-common \
    php-mysql php-xml php-curl php-gd php-soap php-mbstring php-zip \
    php-xdebug mysql-server apache2-utils
  if [[ "$ENABLE_PHPMYADMIN" -eq 1 ]]; then
    echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
    echo "phpmyadmin phpmyadmin/app-password-confirm password phpmyadmin" | sudo debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password phpmyadmin" | sudo debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/app-pass password phpmyadmin" | sudo debconf-set-selections
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
    run apt-get install -y phpmyadmin
  fi
}

install_dev_packages() {
  log "Development & CLI tools"
  run apt-get install -y \
    git mercurial cmake libyaml-cpp-dev composer \
    openjdk-21-jdk \
    python3 python3-pip python3-dev python3-venv python3-setuptools \
    golang-go ruby ruby-dev \
    postgresql postgresql-client \
    libfuse2 libevent-dev libkrb5-dev libssl-dev \
    libx11-dev libxt-dev libncurses-dev \
    automake libtool yasm \
    vim-gtk3 tmux zsh \
    ack ripgrep html2text xdotool \
    wireshark-common tshark \
    aircrack-ng lm-sensors sensors-applet acpi \
    npm
}

install_desktop_packages() {
  [[ "$ENABLE_DESKTOP_EXTRAS" -eq 1 ]] || return 0
  log "Desktop applications"
  # Allow wireshark capture without manual group setup (optional)
  echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
  run apt-get install -y \
    gnome-tweaks yakuake \
    vlc deluge mplayer gimp \
    keepass2 filezilla telegram-desktop pavucontrol \
    gnupg
}

install_python_tools() {
  log "Python pip tools"
  pip3 install --user --upgrade pip
  pip3 install --user mps-youtube sqlitebiter || true
}

setup_minikube() {
  [[ "$ENABLE_MINIKUBE" -eq 1 ]] || return 0
  if [[ "$ENABLE_DOCKER" -ne 1 ]]; then
    echo "Minikube needs Docker (ENABLE_DOCKER=1)."
    return 1
  fi
  log "Minikube"
  if command -v minikube >/dev/null 2>&1; then
    minikube delete || true
  fi
  curl -fsSL https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    -o /tmp/minikube
  chmod +x /tmp/minikube
  sudo install -m 0755 /tmp/minikube /usr/local/bin/minikube
  rm -f /tmp/minikube

  # Use docker driver; may fail until user re-logins for docker group
  if groups "$USER" | grep -q '\bdocker\b'; then
    minikube start --driver=docker
    minikube addons enable ingress
    minikube addons enable metrics-server
    # dashboard is optional and has security implications
    # minikube addons enable dashboard
    printf '\n\033[4;33mEnabled addons\033[0m\n'
    minikube addons list | grep -E 'STATUS|enabled' || true
    printf '\n\033[4;33mMinikube status\033[0m\n'
    minikube status
  else
    echo "Skip minikube start: re-login after docker group membership, then run:"
    echo "  minikube start --driver=docker"
  fi
}

main() {
  install_prereqs
  setup_pritunl_client
  setup_docker
  setup_mongodb
  setup_nodejs
  setup_rabbitmq
  run apt-get update
  install_dev_packages
  setup_lamp
  install_desktop_packages
  setup_pritunl_server
  install_python_tools
  setup_minikube
  log "Done. Review any warnings above; reboot or re-login if added to group docker."
}

main "$@"
