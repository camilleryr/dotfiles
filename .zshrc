plugins=(tumx)
ZSH_TMUX_AUTOSTART=false
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
# nvim_term -u ~/workspace/camiller.yr/dotfiles/init.lua

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

# . $(brew --prefix)/etc/profile.d/z.sh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

export GITHUB_USERNAME=camiller.yr

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# mise version manager
eval "$(mise activate zsh)"

# PostgreSQL 18 (keg-only, not symlinked into /opt/homebrew/bin)
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

export PATH="/Users/cmiller/workspace/camiller.yr/executables:$PATH"

compinit
eval "$(zoxide init zsh)"
