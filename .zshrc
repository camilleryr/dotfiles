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
alias n='nvim'
alias n.='nvim .'
alias vim='nvim'
alias v='nvim'
alias m='nvim -c ":terminal matterhorn"'

alias giaa='gia -A'
alias gfp='git fetch --prune'
alias gzb='gco $(gbL | fzf | cut -d " " -f 3)'
alias gbdr='git push origin --delete'
alias gs='git status'
alias gd='git dif'
alias ga='git add .'

alias bastion='ssh -i ~/.ssh/id_rsa -L 5432:postgres.example.us-east-1.rds.amazonaws.com:5432 cmiller@bastion.prd.carebridgehealth.com'
alias bastion_hs_agp='ssh -i ~/.ssh/id_rsa -L 3307:agp-tn-secure.cluster-ro-chjgbrpcr0vt.us-east-1.rds.amazonaws.com:3306 cmiller@bastion.prd.carebridgehealth.com'
alias bastion_hs_agp_writer='ssh -i ~/.ssh/id_rsa -L 3307:agp-tn-secure.cluster-chjgbrpcr0vt.us-east-1.rds.amazonaws.com:3306 cmiller@bastion.prd.carebridgehealth.com'
alias bastion_hs_uhc='ssh -i ~/.ssh/id_rsa -L 3308:uhc-tn-secure.cluster-ro-chjgbrpcr0vt.us-east-1.rds.amazonaws.com:3306 cmiller@bastion.prd.carebridgehealth.com'
alias bastion_hs_uhc_writter='ssh -i ~/.ssh/id_rsa -L 3308:uhc-tn-secure.cluster-chjgbrpcr0vt.us-east-1.rds.amazonaws.com:3306 cmiller@bastion.prd.carebridgehealth.com'
alias elation='ssh -i ~/.ssh/id_rsa -L 3309:carebridge-dw2.elationemr.com:3306 cmiller@bastion.prd.carebridgehealth.com'
 #     "mysqlx://carebridge-write:ZLPErr3Q0XvYMPt3FfiIK@carebridge-dw2.elationemr.com:3306/carebridge",

# alias bastion_start='ssh -f -N -M -S /temp/bastion -i ~/.ssh/id_rsa -L 5432:postgres.example.us-east-1.rds.amazonaws.com:5432 cmiller@bastion.prd.carebridgehealth.com'
# alias bastion_stop='ssh -S /temp/bastion -0 exit cmiller@bastion.prd.carebridgehealth.com'

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

export MANPAGER='nvim +Man'
export PGAPPNAME=chris_miller_cli

export ELIXIR_EDITOR='nvr -c "sp __FILE__ | normal __LINE__gg zt"'
# export ELIXIR_EDITOR='nvr -c "tabnew __FILE__ | normal __LINE__gg zt"'

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
