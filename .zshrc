# ~/.zshrc — sourced after Prezto (see .zpreztorc)

# Directory jumping: prefer zoxide, fall back to fasd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias j='zoxide query -i'
elif command -v fasd >/dev/null 2>&1; then
  eval "$(fasd --init zsh)"
  alias a='fasd -a'
  alias s='fasd -si'
  alias d='fasd -d'
  alias f='fasd -f'
  alias sd='fasd -sid'
  alias sf='fasd -sif'
  alias z='fasd_cd -d'
  alias zz='fasd_cd -d -i'
fi

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

unsetopt correct
setopt AUTO_CD NO_HUP NO_BEEP NO_CASE_GLOB EXTENDED_GLOB
setopt APPEND_HISTORY INC_APPEND_HISTORY
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

# Keybindings
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word

export GREP_COLORS='mt=01;32'
export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"

# Go (distro package; no /usr/local/go)
if command -v go >/dev/null 2>&1; then
  export GOPATH="${HOME}/Work/Go"
  export PATH="${PATH}:${GOPATH}/bin"
fi

# Node: prefer system/NodeSource; optional nvm
export NVM_DIR="${HOME}/.nvm"
[[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"

# Docker
export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"

# Editor
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='LC_ALL=C fgrep --color=auto'
alias egrep='LC_ALL=C egrep --color=auto'
alias grepi='LC_ALL=C grep -i --color=auto'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias clr='printf "\033c"'
alias vimrc='${EDITOR} ~/.vimrc'
alias zshrc='${EDITOR} ~/.zshrc'
alias soz='source ~/.zshrc'
alias vimp='vim -p'
alias vimo='vim -O'
alias vima='vim -p *'
alias mp='mplayer'
alias o='xdg-open'
alias grepa='grep -irns'

# fasd-style openers (when fasd is available)
if command -v fasd >/dev/null 2>&1; then
  alias v='f -e vim'
  alias m='f -e mplayer'
fi

# Cursor (adjust path if you use .deb / AppImage elsewhere)
if [[ -x "${HOME}/Applications/cursor.AppImage" ]]; then
  alias cursor="${HOME}/Applications/cursor.AppImage --no-sandbox"
elif command -v cursor >/dev/null 2>&1; then
  alias cursor='cursor'
fi

# Touchpad on/off — device IDs vary: xinput list
# Example in ~/.zshrc.local: alias touchoff='xinput set-prop 12 "Device Enabled" 0'

alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# Suffix aliases
alias -s txt=vim h=vim cc=vim pm=vim

# Optional local overrides
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Tools
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Do not auto-start tmux on every shell (use prezto tmux module or run: tmux)
export TERM="${TERM:-xterm-256color}"
