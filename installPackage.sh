#!/usr/bin/env bash
#
# Ubuntu 26.04 LTS (Resolute) — dev / desktop bootstrap
#
# Usage:
#   chmod +x ~/install.sh
#   ~/install.sh

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# --- toggles (set to 0 to skip a section) ---
ENABLE_PRITUNL_CLIENT=1
ENABLE_PRITUNL_SERVER=0
ENABLE_DOCKER=1
ENABLE_MONGODB=1
ENABLE_NODEJS=1          # NodeSource nodejs includes npm — do NOT apt install npm
ENABLE_RABBITMQ=1
ENABLE_LAMP=1
ENABLE_PHPMYADMIN=0
ENABLE_MINIKUBE=1
ENABLE_DESKTOP_EXTRAS=1
ENABLE_CHROME=1           # google-chrome-stable (not chromium)

VENDOR_SUITE="${VENDOR_SUITE:-noble}"
ARCH="$(dpkg --print-architecture)"
. /etc/os-release

if [[ "${VERSION_CODENAME:-}" != "resolute" ]]; then
  echo "Warning: expected Ubuntu 26.04 (resolute); detected: ${VERSION_CODENAME:-unknown}"
  read -r -p "Continue anyway? [y/N] " ans
  [[ "${ans,,}" == "y" ]] || exit 1
fi

SUDO=(sudo)
if [[ "$(id -u)" -eq 0 ]]; then
  if [[ "${INSTALL_ALLOW_ROOT:-}" != "1" ]]; then
    echo "Run as a normal user with sudo, not as root."
    echo "Or: INSTALL_ALLOW_ROOT=1 ~/install.sh"
    exit 1
  fi
  SUDO=()
  USER="${INSTALL_USER:-${SUDO_USER:-rastanislav}}"
  export USER
  echo "Running as root (INSTALL_ALLOW_ROOT=1); USER=${USER}"
fi

log() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
run() { log "$*"; "${SUDO[@]}" "$@"; }
sudo_if_needed() {
  if [[ ${#SUDO[@]} -gt 0 ]]; then sudo "$@"; else "$@"; fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing command: $1"; exit 1; }
}

write_keyring() {
  local url="$1" keyring="$2"
  curl -fsSL "$url" | gpg --dearmor | "${SUDO[@]}" tee "$keyring" >/dev/null
  "${SUDO[@]}" chmod a+r "$keyring"
}

fix_legacy_docker_apt() {
  if grep -qs 'docker\.asc' /etc/apt/sources.list.d/docker.list 2>/dev/null; then
    log "Removing legacy Docker apt config (docker.asc)"
    sudo_if_needed rm -f /etc/apt/sources.list.d/docker.list
  fi
  sudo_if_needed rm -f /etc/apt/keyrings/docker.asc
}

install_prereqs() {
  log "Base packages"
  run apt-get update
  run apt-get install -y \
    ca-certificates curl wget gnupg apt-transport-https software-properties-common \
    build-essential pkg-config
}

setup_pritunl_client() {
  [[ "$ENABLE_PRITUNL_CLIENT" -eq 1 ]] || return 0
  log "Pritunl client (suite: ${VENDOR_SUITE})"
  write_keyring \
    "https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc" \
    /usr/share/keyrings/pritunl-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/pritunl-archive-keyring.gpg] https://repo.pritunl.com/stable/apt ${VENDOR_SUITE} main" \
    | sudo_if_needed tee /etc/apt/sources.list.d/pritunl.list >/dev/null
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
  sudo_if_needed rm -f /etc/apt/keyrings/docker.asc
  sudo_if_needed install -m 0755 -d /etc/apt/keyrings
  write_keyring \
    "https://download.docker.com/linux/ubuntu/gpg" \
    /etc/apt/keyrings/docker.gpg
  echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${VERSION_CODENAME} stable" \
    | sudo_if_needed tee /etc/apt/sources.list.d/docker.list >/dev/null
  run apt-get update
  run apt-get install -y \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo_if_needed systemctl enable --now docker
  if ! groups "$USER" | grep -q '\bdocker\b'; then
    sudo_if_needed usermod -aG docker "$USER"
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
    | sudo_if_needed tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null
  run apt-get update
  run apt-get install -y mongodb-org
  sudo_if_needed systemctl enable --now mongod
}

setup_nodejs() {
  [[ "$ENABLE_NODEJS" -eq 1 ]] || return 0
  log "Node.js 22 LTS (NodeSource) — includes npm"
  require_cmd curl
  sudo_if_needed apt-get remove -y npm 2>/dev/null || true
  if [[ ${#SUDO[@]} -gt 0 ]]; then
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
  else
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
  fi
  run apt-get install -y nodejs
  if command -v corepack >/dev/null 2>&1; then
    sudo_if_needed corepack enable || true
    corepack prepare yarn@stable --activate || true
  fi
}

setup_rabbitmq() {
  [[ "$ENABLE_RABBITMQ" -eq 1 ]] || return 0
  log "RabbitMQ (deb.rabbitmq.com, suite: ${VENDOR_SUITE})"
  write_keyring \
    "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" \
    /usr/share/keyrings/com.rabbitmq.team.gpg
  sudo_if_needed tee /etc/apt/sources.list.d/rabbitmq.list >/dev/null <<EOF
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb1.rabbitmq.com/rabbitmq-erlang/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb2.rabbitmq.com/rabbitmq-erlang/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb1.rabbitmq.com/rabbitmq-server/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
deb [arch=${ARCH} signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://deb2.rabbitmq.com/rabbitmq-server/ubuntu/${VENDOR_SUITE} ${VENDOR_SUITE} main
EOF
  run apt-get update
  run apt-get install -y \
    erlang-base erlang-asn1 erlang-crypto erlang-eldap erlang-ftp \
    erlang-inets erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
    erlang-runtime-tools erlang-snmp erlang-ssl erlang-syntax-tools erlang-tftp \
    erlang-tools erlang-xmerl
  run apt-get install -y rabbitmq-server
  sudo_if_needed systemctl enable --now rabbitmq-server
}

setup_php_runtime() {
  log "PHP runtime (required for composer)"
  run apt-get install -y \
    php-cli php-common php-xml php-mbstring php-zip php-curl php-json
}

setup_lamp() {
  [[ "$ENABLE_LAMP" -eq 1 ]] || return 0
  log "Apache + PHP 8 + MySQL"
  run apt-get install -y \
    apache2 libapache2-mod-php php php-mysql php-gd php-soap \
    php-xdebug mysql-server apache2-utils
  if [[ "$ENABLE_PHPMYADMIN" -eq 1 ]]; then
    echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo_if_needed debconf-set-selections
    echo "phpmyadmin phpmyadmin/app-password-confirm password phpmyadmin" | sudo_if_needed debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password phpmyadmin" | sudo_if_needed debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/app-pass password phpmyadmin" | sudo_if_needed debconf-set-selections
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo_if_needed debconf-set-selections
    run apt-get install -y phpmyadmin
  fi
}

install_dev_packages() {
  log "Development & CLI tools"
  run apt-get install -y \
    git mercurial cmake libyaml-cpp-dev \
    openjdk-21-jdk \
    python3 python3-pip python3-dev python3-venv python3-setuptools \
    golang-go ruby ruby-dev \
    postgresql postgresql-client \
    libfuse2 libevent-dev libkrb5-dev libssl-dev \
    libx11-dev libxt-dev libncurses-dev \
    automake autoconf autotools-dev libtool yasm \
    vim-gtk3 neovim tmux zsh \
    ripgrep html2text xdotool \
    wireshark-common tshark \
    aircrack-ng lm-sensors acpi
  run apt-get install -y ack || true
  log "Composer"
  run apt-get install -y composer
}

setup_google_chrome() {
  [[ "${ENABLE_CHROME:-0}" -eq 1 ]] || return 0
  if command -v google-chrome-stable >/dev/null 2>&1; then
    log "Google Chrome already installed"
    return 0
  fi
  if [[ "$ARCH" != "amd64" ]]; then
    echo "Google Chrome apt repo is amd64-only; skipping on ${ARCH}"
    return 0
  fi
  log "Google Chrome (stable, not Chromium)"
  sudo_if_needed install -m 0755 -d /etc/apt/keyrings
  write_keyring https://dl.google.com/linux/linux_signing_key.pub \
    /etc/apt/keyrings/google-chrome.gpg
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo_if_needed tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
  run apt-get update
  run apt-get install -y google-chrome-stable
}

install_desktop_packages() {
  [[ "$ENABLE_DESKTOP_EXTRAS" -eq 1 ]] || return 0
  log "Desktop applications"
  echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo_if_needed debconf-set-selections
  run apt-get install -y \
    gnome-tweaks yakuake \
    vlc deluge mplayer gimp \
    keepass2 filezilla pavucontrol \
    gnupg
  log "Telegram (snap)"
  if ! command -v snap >/dev/null 2>&1; then
    run apt-get install -y snapd
    sudo_if_needed systemctl enable --now snapd.socket
  fi
  sudo_if_needed snap install telegram-desktop
  setup_google_chrome
}

install_python_tools() {
  log "Python pip tools (pipx — avoids PEP 668 system pip restrictions)"
  run apt-get install -y pipx
  pipx_install() {
    local pkg="$1"
    if [[ "$(id -u)" -eq 0 ]]; then
      sudo -u "$USER" -H pipx install "$pkg" || true
    else
      pipx install "$pkg" || true
    fi
  }
  pipx_install mps-youtube
  pipx_install sqlitebiter
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
  sudo_if_needed install -m 0755 /tmp/minikube /usr/local/bin/minikube
  rm -f /tmp/minikube

  if groups "$USER" | grep -q '\bdocker\b'; then
    minikube start --driver=docker
    minikube addons enable ingress
    minikube addons enable metrics-server
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
  fix_legacy_docker_apt
  install_prereqs
  setup_pritunl_client
  setup_docker
  setup_mongodb
  setup_nodejs
  setup_rabbitmq
  run apt-get update
  setup_php_runtime
  install_dev_packages
  setup_lamp
  install_desktop_packages
  setup_pritunl_server
  install_python_tools
  setup_minikube
  log "Done. Re-login if you were added to group docker. Use: node -v && npm -v"
}

main "$@"
