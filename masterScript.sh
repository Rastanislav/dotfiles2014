#!/usr/bin/env bash
# One-time / new-machine bootstrap (Ubuntu 22.04+). Package install: use ~/install.sh instead.
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/dotfiles2014}"
BIN_DIR="${HOME}/bin"

log() { printf '\n==> %s\n' "$*"; }

log "Clone personal bin repo (optional)"
if [[ ! -d "${BIN_DIR}/.git" ]]; then
  git clone https://github.com/Rastanislav/bin.git "${BIN_DIR}" || true
fi

log "fasd or zoxide (directory jumping)"
if command -v apt-get >/dev/null; then
  sudo apt-get install -y fasd 2>/dev/null || sudo apt-get install -y zoxide 2>/dev/null || true
fi
if [[ -d "${HOME}/fasd" ]]; then
  (cd "${HOME}/fasd" && sudo make install) || true
fi

log "Symlink dotfiles"
if [[ -d "${DOTFILES_DIR}" ]]; then
  "${DOTFILES_DIR}/makesymlinks.sh"
else
  git clone https://github.com/Rastanislav/dotfiles2014.git "${DOTFILES_DIR}"
  "${DOTFILES_DIR}/makesymlinks.sh"
fi

log "vim-plug (plugin manager)"
mkdir -p "${HOME}/.vim/autoload"
curl -fsSL -o "${HOME}/.vim/autoload/plug.vim" \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

log "fzf"
if [[ ! -d "${HOME}/.fzf/.git" ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
fi
"${HOME}/.fzf/install" --all --no-update-rc || true

log "Prezto (zsh framework)"
if [[ ! -d "${ZDOTDIR:-${HOME}}/.zprezto/.git" ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
if [[ "${SHELL:-}" != */zsh ]]; then
  chsh -s "$(command -v zsh)" "$USER" || true
fi

log "Docker group"
if ! getent group docker >/dev/null; then
  sudo groupadd docker
fi
sudo usermod -aG docker "$USER" 2>/dev/null || true

log "Go (use distro golang-go, or install from go.dev)"
if ! command -v go >/dev/null; then
  sudo apt-get install -y golang-go 2>/dev/null || true
fi

log "Apache rewrite (if LAMP installed)"
if command -v a2enmod >/dev/null; then
  sudo a2enmod rewrite 2>/dev/null || true
  sudo systemctl restart apache2 2>/dev/null || true
fi

log "Cursor CLI (optional)"
if command -v curl >/dev/null; then
  curl -fsSL https://cursor.com/install | bash || true
fi

log "Done. Next: open vim/neovim and run :PlugInstall ; log out if added to docker group."
