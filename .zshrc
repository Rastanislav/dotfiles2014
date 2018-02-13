eval "$(fasd --init auto)"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
unsetopt correct

# From old .zshrc
#
# # why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD
#
#
setopt NO_HUP
#
#
# # beeps are annoying
setopt NO_BEEP
#
#
# # Case insensitive globbing
setopt NO_CASE_GLOB
#
# # I don't know why I never set this before.
setopt EXTENDED_GLOB
#
#
# # Where it gets saved
HISTFILE=~/.history
#
# # Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000
#
# # Don't overwrite, append!
setopt APPEND_HISTORY
#
# # Write after each command
setopt INC_APPEND_HISTORY
#
# # Path to your oh-my-zsh configuration.
# ZSH=$HOME/.oh-my-zsh
#
# # Set name of the theme to load.
#
# # Look in ~/.oh-my-zsh/themes/
# # Optionally, if you set this to "random", it'll load a random theme each
# # time that oh-my-zsh is loaded.
# ZSH_THEME="my"
#
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
#
# # Set to this to use case-sensitive completion
# # CASE_SENSITIVE="true"
#
# # Uncomment this to disable bi-weekly auto-update checks
# # DISABLE_AUTO_UPDATE="true"
#
# # Uncomment to change how often before auto-updates occur? (in days)
# # export UPDATE_ZSH_DAYS=13
#
# # Uncomment following line if you want to disable colors in ls
# # DISABLE_LS_COLORS="true"
#
# # Uncomment following line if you want to disable autosetting terminal title.
# # DISABLE_AUTO_TITLE="true"
#
# # Uncomment following line if you want to disable command autocorrection
# # DISABLE_CORRECTION="true"
#
# # Uncomment following line if you want red dots to be displayed while waiting for completion
# # COMPLETION_WAITING_DOTS="true"
#
# # Uncomment following line if you want to disable marking untracked files under
# # VCS as dirty. This makes repository status check for large repositories much,
# # much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"
#
# # Uncomment following line if you want to  shown in the command execution time stamp 
# # in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# # yyyy-mm-dd
# # HIST_STAMPS="mm/dd/yyyy"
#
# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(fasd vi-mode)
#
# source $ZSH/oh-my-zsh.sh
#
# # User configuration
#
# export PATH="/home/rastanislav/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
# # export MANPATH="/usr/local/man:$MANPATH"
#
# # # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
#
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
#
# # ssh
# # export SSH_KEY_PATH="~/.ssh/dsa_id"
#
#
#
# # Enable vim mode on command line
# #bindkey -v
# set -o emacs
# # Show vim status
# # http://zshwiki.org/home/examples/zlewidgets
# #function zle-line-init zle-keymap-select {
# # RPS1="${${KEYMAP/vicmd/$RPROMPT-- NORMAL --}/(main|viins)/$RPROMPT-- INSERT --}"
# # RPS2=$RPS1
# # zle reset-prompt
# #}
# #
# #zle -N zle-line-init
# #zle -N zle-keymap-select
#
#
#
#
# #vim_ins_mode="%{$fg[red]%}<INSERT> %{$reset_color%}"
# #vim_cmd_mode="%{$fg[white]%}<%{$fg[red]%}COMMAND%{$fg[white]%}>%{$reset_color%}"
# #vim_mode=$vim_ins_mode
# #
# #function zle-keymap-select {
# #  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
# #    zle reset-prompt
# #}
# #zle -N zle-keymap-select
# #
# #function zle-line-finish {
# #  vim_mode=$vim_ins_mode
# #  }
# #  zle -N zle-line-finish
# #
# ## Right prompt
# RIGHTPROMP='%B%n@%m %T%b% '
# #RPROMPT='${RIGHTPROMP} ${vim_mode}'
# RPROMPT='${RIGHTPROMP}'
#
#
#
#
#
#
# Add missing hotkeys
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

export GREP_COLOR="01;32"

#
function fasd_cd {

 	[ "$2" = '-i' ] && { cd `fasd -id "$1" ` | awk '{print "$2"}'; return; }

 	{ cd `fasd -d "$1" -1` | awk '{print "$2"}'; return; }

}
##
##
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
##
alias grepps='ps aux | grep -i'

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

#export TERM="xterm-256color"

alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'


#bind -x '"\e[24~":"${HOME}/bin/emacs-vi-toggle"'

#alias reload="source ~/.bashrc"
#FIGNORE=".o:.swo:.swp"






#
#         # From my .bashrc
#
#
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='LC_ALL=C fgrep --color=auto'
alias egrep='LC_ALL=C egrep --color=auto'
alias grepi='LC_ALL=C grep -i --color=auto'
alias grepl='ls | LC_ALL=C grep --color=auto'
alias grepil='ls | LC_ALL=C grep -i --color=auto'
alias grepill='ls -lh | LC_ALL=C grep -i --color=auto'
alias psgr='ps aux | LC_ALL=C grep -i --color=auto'

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
#
#         # Random
alias clr='echo -e "\033c"'
alias touchon='xinput set-prop 12 "Device Enabled" 1'
alias touchoff='xinput set-prop 12 "Device Enabled" 0'

alias touchon1='xinput set-prop 13 "Device Enabled" 1'
alias touchoff1='xinput set-prop 13 "Device Enabled" 0'

export PATH="$PATH:$HOME/bin:$PATH"
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/Work/Go


alias grepill='ll -h | grep -i'
alias vtree='xlsvtree'
alias ffidn='ffind'

alias ff='source ~/bin/newf'
alias gg='source ~/bin/newg'
alias lf='source ~/bin/newl'


alias -s txt=vim
alias -s h=vim
alias -s cc=vim
alias -s pm=vim
alias -s diffreport=cat

alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias .7='cd ../../../../../../..'


alias vima='vim -p *'

alias soz='source ~/.zshrc'
alias app='cd /opt/creation/dev/server/app'
alias grepa='grep -irns'
alias trash='cd ~/spider/trash2/'

alias sp='spider -c '
alias lff='source ${HOME}/.tmp/findAliases'
alias lgg='source ${HOME}/.tmp/grepAliases'
alias vimp='vim -p'
alias vimo='vim -O'

alias mp='mplayer'


alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open


bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word
export TERM=xterm-256color
tmux -2

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
