#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

dotfiles_path="$script_path/dotfiles"

# Do not symlink these paths. Paths are relative to $dotfiles_path.
do_not_symlink=(
  ".irssi"
)

### Helpers ####################################################################

in_array() {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0;
  done
  return 1
}

git_clone_or_pull() {
  local url="$1"
  local target="$2"
  git -C "$target" pull --rebase 2>/dev/null || git clone --depth 1 "$url" \
    "$target"
}

### Parse arguments ############################################################

while getopts 'f' arg; do
  case "$arg" in
    f)
      ln_args='f'
      ;;
    *)
      exit 1
      ;;
  esac
done

### Symlink dotfiles ###########################################################

for source_file_name in `ls -A $dotfiles_path`; do
  if (in_array "$source_file_name" "${do_not_symlink[@]}"); then
    echo "Ignoring: $source_file_name"
  else
    ln -snvi"$ln_args" "$dotfiles_path/$source_file_name" \
      "$HOME/$source_file_name"
  fi
done

### Symlink htoprc for Linux distributions #####################################

if [[ `uname` != 'Darwin' ]]; then
  mkdir -p "$HOME/.config/htop"
  ln -snvi"$ln_args" "$dotfiles_path/.htoprc" "$HOME/.config/htop/htoprc"
fi

### Install submodules if any ##################################################

pushd "$dotfiles_path" > /dev/null
git submodule update --init --depth 1 --recursive
popd > /dev/null

### Install fonts ##############################################################

"$script_path/fonts/install.sh"

### Install Oh-My-Zsh ##########################################################

git_clone_or_pull https://github.com/robbyrussell/oh-my-zsh.git \
  "$HOME/.oh-my-zsh"

git_clone_or_pull \
  https://github.com/caiogondim/bullet-train-oh-my-zsh-theme.git \
  "$HOME/.oh-my-zsh/custom/themes"

### Install Tmux plugin manager ################################################

git_clone_or_pull https://github.com/tmux-plugins/tpm \
  "$HOME/.tmux/plugins/tpm"

### Install Vundle #############################################################

git_clone_or_pull https://github.com/VundleVim/Vundle.vim.git \
  "$HOME/.vim/bundle/Vundle.vim"
echo -ne '\n' | vim +PluginInstall +qall 2>/dev/null

### Symlink Neovim configs #####################################################

ln -s"$ln_args" "$HOME/.vim" "$HOME/.config/nvim"
ln -s"$ln_args" "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"

### Set zsh as the default shell ###############################################

if which zsh >/dev/null; then
  if [[ `uname` = 'Darwin' ]]; then
    default_shell=$(dscl . -read "$HOME" UserShell)
  else
    default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
  fi

  case $(echo "$default_shell") in
    */zsh)
      echo "ZSH already set to the user's default shell."
      ;;
    *)
      echo ""
      read -p "Set ZSH as the user's default shell [y\N] > " -r set_zsh
      case "$set_zsh" in
        [yY][eE][sS]|[yY])
            echo "Sudo password might be asked."
            chsh -s /bin/zsh
            ;;
      esac
      ;;
  esac
fi
