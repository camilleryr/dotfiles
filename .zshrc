# BEGIN DEVBAO MANAGED BLOCK FOR zsh shell completion
autoload -Uz compinit
compinit
# END DEVBAO MANAGED BLOCK FOR zsh shell completion
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
alias n='nvim_term'
alias n.='nvim_term .'
alias vim='nvim_term'
alias v='nvim_term'
alias nvim_term='nvim -c ":VTerm | wincmd h"'
# alias m='nvim -c ":terminal matterhorn"'

alias gs='git status'
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


[ $commands[setxkbmap] ] && setxkbmap -option caps:ctrl_modifier
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## load local zshrc
[ -f $HOME/.zshrc.after ] && source $HOME/.zshrc.after

export MANPAGER='vim -c MANPAGER -'
export PGAPPNAME=chris_miller_cli

export ELIXIR_EDITOR='nvr -c "sp __FILE__ | normal __LINE__gg zt"'

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.secret.zsh ]] || source ~/.secret.zsh

. $(brew --prefix)/opt/asdf/libexec/asdf.sh
. $(brew --prefix)/etc/profile.d/z.sh
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH
# BEGIN DEVBAO MANAGED BLOCK FOR user's local bin
export PATH="$HOME/.local/bin:$PATH"
# END DEVBAO MANAGED BLOCK FOR user's local bin
export OKTA_USERNAME=cmiller
# BEGIN DEVBAO MANAGED BLOCK FOR Python user-site path
export PATH="/Users/cmiller/Library/Python/3.11/bin:$PATH"
# END DEVBAO MANAGED BLOCK FOR Python user-site path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export GITHUB_USERNAME=camiller.yr
# BEGIN DEVBAO MANAGED BLOCK FOR KUBECONFIG ENV VAR
export KUBECONFIG=$HOME/.kube/config:$(ls -d $HOME/.kube/config.d/* 2> /dev/null | paste -sd : -)
# END DEVBAO MANAGED BLOCK FOR KUBECONFIG ENV VAR
# BEGIN DEVBAO MANAGED BLOCK for kubectl
# source <(kubectl completion zsh)
# alias k=kubectl
# complete -F __start_kubectl k
# END DEVBAO MANAGED BLOCK for kubectl
# BEGIN DEVBAO MANAGED BLOCK FOR KREW
export PATH="$HOME/.krew/bin:$PATH"
# END DEVBAO MANAGED BLOCK FOR KREW
# BEGIN DEVBAO MANAGED BLOCK for Valet
export VALET_USERNAME=cmiller
# END DEVBAO MANAGED BLOCK for Valet

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
# BEGIN DEVBAO MANAGED BLOCK FOR adrise_infrastructure
export INFRA_REPO_DIR=/Users/cmiller/tubi/infrastructure
# END DEVBAO MANAGED BLOCK FOR adrise_infrastructure
