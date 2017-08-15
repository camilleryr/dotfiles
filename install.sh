#! /bin/sh

# get script's directory
this_dir=$(cd $(dirname $0); pwd -P)

# try to create a symlink to $1 at $2
function try_link() {
  src_path=$1
  dst_path=$2

  if [[ -e $dst_path || -L $dst_path ]]; then
    if [ $all_yes ]; then
      choice='y'
    elif [ ! -z $all_no ]; then
      choice='n'
    else
      read -p $'\n\033[36m'"$dst_path"$'\033[0m already exists. \033[31;1mRemove?\033[0m [y/\033[31;1mN\033[0m]:  ' choice
    fi

    if [[ $choice =~ ^[Yy] ]]; then
      [ $verbose ] && echo "Removing \033[36m$dst_path\033[0m"
      rm $dst_path
    else
      [ $verbose ] && echo "Not removing \033[36m$dst_path\033[0m"
    fi
  fi

  if [ ! -e $dst_path ] && ln -s $src_path $dst_path; then
    [ $verbose ] && echo "Link created for \033[36m$dst_path\033[0m"
  else
    [ $verbose ] && echo "Could not create link for \033[36m$dst_path\033[0m"
  fi
}

# print help and exit
function print_help_abort() {
  echo '
Usage: install options...
-h  help      This output

Script settings:
-A  All       Install all options
-Y  yes       Accept all confirmation prompts
-N  no        Deny all confirmation prompts
-V  verbose   Enable extra logging

Installable options:
-b  bash      Link bashrc
-e  eslint    Link eslintrc
-f  fzf       Setup fzf
-k  konsole   Link Konsole profile and colorscheme
-n  neovim    Setup neovim and link init.vim
-p  prezto    Clone prezto and link configuration files
-t  tmux      Link tmux configuration
-z  zsh       Set zsh as shell
'
  exit 1
}


# display help if no arguments
if (($# == 0)); then
  print_help_abort
fi

while getopts 'hAYNVbefknptz' flag; do
  case "${flag}" in
    h) print_help_abort ;;

    A) all='true' ;;
    Y) all_yes='true' ;;
    N) all_no='true' ;;
    V) verbose='true' ;;

    b) setup_bash='true' ;;
    e) setup_eslint='true' ;;
    f) setup_fzf='true' ;;
    k) konsole_files='true' ;;
    n) setup_neovim='true' ;;
    p) setup_prezto='true' ;;
    t) setup_tmux='true' ;;
    z) set_zsh='true' ;;

    \?) print_help_abort ;;

    # 'f:'
    # f) files="${OPTARG}" ;;
  esac
done


# simple files in home folder
files=()

# TODO(adam): need to figure out solution for terminal colors
# .Xresources

[ $setup_bash ] && files+=(.bashrc)
[ $setup_eslint ] && files+=(.eslintrc.json)
[ $setup_tmux ] && files+=(.tmux.conf)

[ $setup_prezto ] && files+=(
  .zlogin
  .zlogout
  .zpreztorc
  .zprofile
  .zshenv
  .zshrc
)

for filename in ${files[*]}; do
  try_link $this_dir/$filename $HOME/$filename
done

if [ $setup_neovim ]; then
  nvim_dir=$HOME/.config/nvim
  mkdir -p ${nvim_dir}
  try_link $this_dir/init.vim $nvim_dir/init.vim
fi

if [ $setup_fzf ]; then
  if [ -x "$(command -v konsole)" ]; then
    [ $verbose ] && echo "Cloning fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    [ $verbose ] && echo "Running fzf install"
    $HOME/.fzf/install
  else
    [ $verbose ] && echo "fzf found - not cloning"
  fi
fi

if [ -x "$(command -v konsole)" ] && [ $konsole_files ]; then
  konsole_profile_dir=$HOME/.local/share/konsole
  mkdir -p $konsole_profile_dir
  try_link $this_dir/konsole/Mine.profile $konsole_profile_dir/Mine.profile
  try_link $this_dir/konsole/Mine.colorscheme $konsole_profile_dir/Mine.colorscheme
fi

# prezto setup
if [ $setup_prezto ]; then
  if [[ ! -e "${ZDOTDIR:-$HOME}/.zprezto"  ]]; then
    [ $verbose ] && echo "Cloning Prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  else
    [ $verbose ] && echo "Prezto already exists - not cloning"
  fi
fi

if [ $set_zsh ]; then
  # TODO(adam): grep in /etc/shells for zsh
  chsh -s $(which zsh)

  # run zsh in current shell
  [ ! -z $ZSH_NAME ] && exec zsh
fi
