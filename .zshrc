# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Executes commands at the start of an interactive session

# fix vim not seeing 256-color terminal
[[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color && -z "$TMUX" ]] && TERM=xterm-256color

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Remove completion groups
zstyle -d ':completion:*:matches' group
zstyle -d ':completion:*:options' description
zstyle -d ':completion:*:options' auto-description
zstyle -d ':completion:*:corrections' format
zstyle -d ':completion:*:descriptions' format
zstyle -d ':completion:*:messages' format
zstyle -d ':completion:*:warnings' format
zstyle -d ':completion:*:default' list-prompt
zstyle -d ':completion:*' format
zstyle -d ':completion:*' group-name

unsetopt CORRECT                      # Disable autocorrect guesses.

autoload -U zmv
alias zmv='noglob zmv -W'

## aliases
alias weather='curl wttr.in/Nashville'
alias tree='tree -C'
alias python='python3'
alias pip='pip3'
alias l1='ls -1'
alias ll='ls -alF'
alias la='ls -A'
alias la1='ls -A1'
alias l='ls -CF'
alias gresolve="git diff --name-only | uniq | xargs $EDITOR"
alias gresolvep='gresolve -p'
alias gresolveo='gresolve -O'
alias n='nvim_term'
alias n.='nvim_term .'
alias vim='nvim_term'
alias v='nvim_term'
alias nvim_term='nvim -c ":VTerm | wincmd h"'
# alias m='nvim -c ":terminal matterhorn"'

alias giaa='gia -A'
alias gfp='git fetch --prune'
alias gzb='gco $(gbL | fzf | cut -d " " -f 3)'
alias gbdr='git push origin --delete'
alias gs='git status'
alias gd='git dif'
alias ga='git add .'

alias j=z

neoterm() { \
  nvim +"terminal $*"
}
alias nt='neoterm'

ownnpm() {
  if [[ $(npm config get prefix) == '/usr' ]]; then
    echo 'Cannot autofix: your npm prefix is "/usr"'
    echo 'Add to after file: export NPM_CONFIG_PREFIX=~/.npm-global'
  else
   sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  fi
}

## functions
function = { echo $(($@))  }  # easy math
mkdwn() { pandoc $1 | lynx -stdin -dump }   # print markdown in terminal

# from oh-my-zsh
gpb() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git-branch-current)"
    git push origin "${b:=$1}"
  fi
}
compdef _git gpb=git-checkout

# use nvr to prevent neovim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim=$(echo "No nesting!")
  fi
fi

# needs tweaking for non BSD, probably with brace expansion {1..5}
# maybe cd\^
# cd^ () {
#   if [ $1 -eq 1 ]; then
#     cd ..
#   else
#     cd $(seq -f '../' -s '' $1)
#   fi
# }

# run setups if exist
if [ $commands[autojump] ]; then # check if autojump is installed
  if [ -f $HOME/.autojump/etc/profile.d/autojump.zsh ]; then # manual user-local installation
    . $HOME/.autojump/etc/profile.d/autojump.zsh
  elif [ -f $HOME/.autojump/share/autojump/autojump.zsh ]; then # another manual user-local installation
    . $HOME/.autojump/share/autojump/autojump.zsh
  elif [ -f $HOME/.nix-profile/etc/profile.d/autojump.zsh ]; then # nix installation
    . $HOME/.nix-profile/etc/profile.d/autojump.zsh
  elif [ -f /usr/share/autojump/autojump.zsh ]; then # debian and ubuntu package
    . /usr/share/autojump/autojump.zsh
  elif [ -f /etc/profile.d/autojump.zsh ]; then # manual installation
    . /etc/profile.d/autojump.zsh
  elif [ -f /etc/profile.d/autojump.sh ]; then # gentoo installation
    . /etc/profile.d/autojump.sh
  elif [ -f /usr/local/share/autojump/autojump.zsh ]; then # freebsd installation
    . /usr/local/share/autojump/autojump.zsh
  elif [ -f /opt/local/etc/profile.d/autojump.zsh ]; then # mac os x with ports
    . /opt/local/etc/profile.d/autojump.zsh
  elif [ $commands[brew] -a -f `brew --prefix`/etc/autojump.sh ]; then # mac os x with brew
    . `brew --prefix`/etc/autojump.sh
  fi
fi


# if [[ "$OSTYPE" == "linux-gnu" ]]; then
#   # ...
# elif [[ "$OSTYPE" == "darwin"* ]]; then
#   # Mac OSX
# elif [[ "$OSTYPE" == "cygwin" ]]; then
#   # POSIX compatibility layer and Linux environment emulation for Windows
# elif [[ "$OSTYPE" == "msys" ]]; then
#   # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
# elif [[ "$OSTYPE" == "win32" ]]; then
#   # I'm not sure this can happen.
# elif [[ "$OSTYPE" == "freebsd"* ]]; then
#   # ...
# else
#   # Unknown.
# fi


# case "$OSTYPE" in
#   solaris*) echo "SOLARIS" ;;
#   darwin*)  echo "OSX" ;;
#   linux*)   echo "LINUX" ;;
#   bsd*)     echo "BSD" ;;
#   msys*)    echo "WINDOWS" ;;
#   *)        echo "unknown: $OSTYPE" ;;
# esac



# colorize man pages
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
#man() {
  #LESS_TERMCAP_mb=$'\e[1;31m' \
  #LESS_TERMCAP_md=$'\e[1;31m' \
  #LESS_TERMCAP_me=$'\e[0m' \
  #LESS_TERMCAP_se=$'\e[0m' \
  #LESS_TERMCAP_so=$'\e[1;44;33m' \
  #LESS_TERMCAP_ue=$'\e[0m' \
  #LESS_TERMCAP_us=$'\e[1;32m' \
  #command man "$@"
#}


# start terminal in tmux, reattach if exists
# [[ $TERM != screen* ]] && [ -z $TMUX ] && { tmux attach || tmux new-session -s home; }

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

[ $commands[setxkbmap] ] && setxkbmap -option caps:ctrl_modifier
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## load local zshrc
[ -f $HOME/.zshrc.after ] && source $HOME/.zshrc.after

export VAULT_PROD="s.gxJgPSl82UoG4aKIyCAut7Jo"
export VAULT_STAGING="s.1M0RdegMiUOR19wUOojVzlk9"
export WATERPARK_SRC_DIR="/Users/LEX5591/workspace/hca/waterpark-2018"

export MANPAGER='vim -c MANPAGER -'
export PGAPPNAME=chris_miller_cli

export ELIXIR_EDITOR='nvr -c "sp __FILE__ | normal __LINE__gg zt"'

export http_proxy=http://proxy.nas.medcity.net:80
export https_proxy=http://proxy.nas.medcity.net:80
export HTTP_PROXY=http://proxy.nas.medcity.net:80
export HTTPS_PROXY=http://proxy.nas.medcity.net:80
# export no_proxy=localhost

# opam configuration
test -r /Users/cmiller/.opam/opam-init/init.zsh && . /Users/cmiller/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.secret.zsh ]] || source ~/.secret.zsh

. /usr/local/opt/asdf/asdf.sh
. /Users/LEX5591/workspace/camiller/z/z.sh
. ~/.asdf/plugins/java/set-java-home.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

alias SLACK="ssh -i /Users/LEX5591/workspace/camiller/playground/wee-slack/wee-slack-gcp.pem 34.68.126.201"
