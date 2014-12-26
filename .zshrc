 eval "$(fasd --init auto)"
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

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
#
#
#
#
#
#
#
#
#
#
#
#
#
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
#
#
#
#
 alias wrkcs='cd ~/Desktop/csStudyMaterials/opt/interface'
 alias grepps='ps aux | grep -i'

 alias a='fasd -a'        # any
 alias s='fasd -si'       # show / search / select
 alias d='fasd -d'        # directory
 alias f='fasd -f'        # file
 alias sd='fasd -sid'     # interactive directory selection
 alias sf='fasd -sif'     # interactive file selection
 alias z='fasd_cd -d'     # cd, same functionality as j in autojump
 alias zz='fasd_cd -d -i' # cd with interactive selection
#
#
#
#
#
#
#
#
#
# function echoc()
# {
#     echo -e "\e[1;31m $@ \e[0m"
#     }
#
#
#
#
     function mkdircd()
     {
         mkdir $1 ; cd $1
         }

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

#
#
#         # From .kshrc
#
#         #clearstream envs
#
#         export _AST_FEATURES='UNIVERSE - ucb'
#         export BUILDDDLDIR=/vobs/RTS/DDL
#         export BYPASSAUTOCSPEC=1
#         export cfile_path=/opt/creation/dev_cse/etc
#         export CiPersistMovements=TRUE
#         export CLEARCASE_AVOBS=/opt/creation/dev/server/app:/opt/creation/dev/server/edinfra:/opt/interface:/opt/creation/TechnicalArchitecture:/vobs/TechArch:/vobs/RTS:/vobs/libs:/vobs/DDL:/vobs/ref:/vobs/utilities:/vobs/apps:/vobs/RTS_TI:/vobs/SETHNG:/vobs/SETHWksCopy:/vobs/misc:/opt/creation/tools:/opt/creation/admin:/opt/creation/dev_cse:/vobs/IntTests
#         export CMTOOLS_TEMPDIR=/tmp
#         export configSpecLocation=/net/asgard/local/GlobalProfiles/buildConfigSpecs
#         export CRTI_ARCHIVES=''
#         export CRTI_cc=/usr/bin/gcc
#         export CRTI_CCFLAGS='-Wno-long-long -Wno-variadic-macros -c'
#         export CRTI_CXXFLAGS='-pthread -fPIC -rdynamic'
#         export CRTI_INCPATH=''
#         export CRTI_LDFLAGS=''
#         export CRTI_LIBPATH=''
#         export CRTI_LIBS=''
#         export CRTI_LIVE_OR_REPL=LIVE
#         export CRTI_PROC_CC_FLAGS='-Wno-unused-variable -DSQLCA_NONE -DORACA_NONE'
#         export CRTI_RW_LIBS='-ltls90-m -lmny29-m'
#         export CRTI_VERSION='TI 40.1'
#         export CRTI_WARNFLAGS_DEFAULT='-fdiagnostics-show-option -pedantic-errors -Wall -Wno-reorder -Wno-unused -Wno-sign-compare'
#         export CRTI_WARNFLAGS_PEDANTIC='-fdiagnostics-show-option -pedantic-errors -Wall -Werror'
#         export CRTI_WARNFLAGS_STRICT='-fdiagnostics-show-option -pedantic-errors -Wall -Werror -Wno-reorder -Wno-unused'
#         export DDLROOTDIR=/vobs/DDL
#         export EDITOR=vim
#         export G_BROKEN_FILENAMES=1
#         export LESSOPEN='|/usr/bin/lesspipe.sh %s'
#         export NLS_DATE_FORMAT='DD-MON-YYYY HH24.MI.SS'
#         export SOLOS_DEV_HOME=/opt/interface/Solos
#         export SOLOS_REL_HOME=/opt/interface/Solos
#         export SPIDER_HOME=/opt/creation/dev_cse/spider
#         export TI_DEV=/opt/creation/dev/server/ti
#         export TI_DEVELOPMENT=/dev/server/ti
#         export WINEDITOR=vim
#
#
#         export PATH=$PATH:~/apps/fasd-master/
         export PATH="$HOME/bin:$PATH"
#
#
#         alias terminator='python ~/terminator-0.97/terminator &'
#         alias mangareva='ssh -X mangareva'
#         alias ctags='~/ctags-5.8/ctags'
         alias grepill='ll -h | grep -i'
#         alias vim='/net/nexus/local/vim/bin/vim'
#         alias ct='cleartool'
#
#         eval $(dircolors -b $HOME/.dircolors)
#
#
#         alias isdan='debugon;spider -c ISDAN_01'
#         alias bsdan='debugon;spider -c BSDAN_01'
#         alias isdfn='debugon;spider -c ISDFN_01'
#         alias bsdar='debugon;spider -c BSDAR_01'
#         alias bsdfn='debugon;spider -c BSDFN_01'
#         alias bsrfn='debugon;spider -c BSRFN_01'
#         alias bstfn='debugon;spider -c BSTFN_01'
#
#
#         alias debugon='export CRTI_EES_ARCH_TRACE_LEVEL=ARCH_DEBUG; export CRTI_EES_APP_TRACE_LEVEL=APP_DEBUG2'
#         alias tests='cd /opt/creation/dev_cse/regression/testdata/'
#         set -o emacs
#         alias testdiff='cd /opt/creation/dev_cse/regression/testdata/IMM/ISDAN01/'
#         alias probes='cd /opt/creation/dev_cse/tiger/probes/'
#         alias rel='cd /opt/creation/rel/server/app/' 
#
#
#
#         export PATH=/home/kr445/bin:.:/opt/creation/dev/server/app/bin:/opt/creation/rel/server/app/bin:/opt/creation/dev/server/edinfra/bin:/opt/creation/rel/server/edinfra/bin:/opt/creation/dev/server/ti/bin:/opt/creation/rel/server/ti/bin:/vobs/ServInf/servicebroker/bin:/opt/creation/rel/server/servinf/servicebroker/bin:/vobs/Tipex/bin:/vobs/Tipex/scripts:/opt/creation/rel/server/tipex/bin:/opt/creation/rel/server/tipex/scripts:/opt/creation/dev/server/oxi/scripts:/opt/creation/rel/server/oxi/scripts:/opt/creation/dev/server/app/SCRIPTS/cse:/opt/creation/dev/server/app/SCRIPTS/cse/Tipex:/opt/creation/admin/cm/tools/admin:/opt/creation/admin/cm/tools/user:/opt/creation/admin/cm/buildtools//creation/bin:/vobs/SETHNG/bin:/opt/creation/dev/server/app/SCRIPTS/domino:/opt/creation/rel/server/interface/Integration/bin:/opt/creation/dev/server/app/build/build_tools:/opt/creation/tools/regression/scripts:/opt/creation/tools/app/scripts:/opt/creation/tools/ti/bin:/opt/creation/tools/app/bin:/opt/creation/admin/dba/cod/src:/opt/creation/tools/app/critter:/usr/atria/bin:/opt/creation/admin/cm/tools//clearmake:/bin:/opt/tools/perl5.10.0_oracle11//bin:/opt/tools/j2se_160_20/bin:/opt/tools/rv_8.2.1/tibrv/8.2/bin:/opt/oracle/product/CLT_1110/bin:/opt/creation/dev/server/app/cmenv/tools:/usr/bin:/etc:/usr/sbin:/usr/local/bin:/opt/creation/TechnicalArchitecture/CLW/ClwQueryMgr/bin:/opt/creation/TechnicalArchitecture/CLW/ClwBackend/bin:/opt/creation/TechnicalArchitecture/CLW/ClwWorkflow/bin:/opt/creation/rel/server/clw/ClwQueryMgr/bin:/opt/creation/rel/server/clw/ClwBackend/bin:/opt/creation/rel/server/clw/ClwWorkflow/bin:/opt/creation/dev_cse/UnitTestGenerator:/net/asgard/local/GlobalProfiles/bin:/opt/creation/dev/server/ti/cmenv/prodscripts:/home/kr445/apps/fasd-master/
#
#
#
#         export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/ox957/local2/lib"
#         export TERM=xterm-256color
#         alias tmux='tmux -2'
#         stty erase
#         alias clearmakee='clearmake 2>&1 | tee /dev/stderr | vim -'
#         alias ti='cd /opt/creation/dev/server/ti/ACInfra/ps'
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
         tmux -2
