#!/bin/bash

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
  for e in "${@:2}" ; do
    [[ "$e" == "$1" ]] && return 0
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

while getopts 'f' arg ; do
  case "$arg" in
    f)
      ln_args='f'
      ;;
    *)
      exit 1
      ;;
  esac
done

### Symlink bin ################################################################

local_bin_path="$HOME/.local/bin"
if [[ ! -L "$local_bin_path" ]] ; then
  mv -i "$local_bin_path" "${local_bin_path}-old"
  ln -snvi"$ln_args" "$script_path/bin" "$local_bin_path"
fi

### Symlink dotfiles ###########################################################

for source_file_name in $(ls -A $dotfiles_path) ; do
  if (in_array "$source_file_name" "${do_not_symlink[@]}") ; then
    echo "Ignoring: $source_file_name"
  else
    ln -snvi"$ln_args" "$dotfiles_path/$source_file_name" \
      "$HOME/$source_file_name"
  fi
done

### Symlink htoprc for Linux distributions #####################################

if [[ "$OSTYPE" = linux-gnu* ]] ; then
  mkdir -p "$HOME/.config/htop"
  ln -snvi"$ln_args" "$dotfiles_path/.htoprc" "$HOME/.config/htop/htoprc"
fi

### Install Tmux plugin manager ################################################

git_clone_or_pull https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

### Symlink Neovim configs #####################################################

mkdir -p "$HOME/.config"
ln -s"$ln_args" "$HOME/.vim" "$HOME/.config/nvim"
ln -s"$ln_args" "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"

### Install Vundle #############################################################

git_clone_or_pull https://github.com/VundleVim/Vundle.vim.git \
  "$HOME/.vim/bundle/Vundle.vim"
echo -ne '\n' | nvim +PluginInstall +qall 2>/dev/null
