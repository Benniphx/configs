#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

dotfiles_path="$script_path/dotfiles"

# Do not symlink these paths. Paths are relative to $dotfiles_path.
do_not_symlink=(
  ".irssi"
  ".config"
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

### Symlink bin ###########################################################

local_bin_path="$HOME/.local/bin"
if [[ ! -L "$local_bin_path" ]]; then
  mv -i "$local_bin_path" "${local_bin_path}-old"
  ln -snvi"$ln_args" "$script_path/bin" "$local_bin_path"
fi

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

if [[ "$OSTYPE" = linux-gnu* ]]; then
  mkdir -p "$HOME/.config/htop"
  ln -snvi"$ln_args" "$dotfiles_path/.htoprc" "$HOME/.config/htop/htoprc"
fi

### Symlink XFCE for Linux distributions #####################################

if [[ "$OSTYPE" = linux-gnu* ]]; then
  xfce_configs_path="$HOME/.config/xfce4"
  if [[ ! -L "$xfce_configs_path" ]]; then
    mv -i "$xfce_configs_path" "${xfce_configs_path}-old"
    ln -snvi"$ln_args" "$dotfiles_path/.config/xfce4" "$xfce_configs_path"
  fi
fi

### Install submodules if any ##################################################

pushd "$dotfiles_path" > /dev/null
git submodule update --init --depth 1 --recursive
popd > /dev/null

### Install fonts ##############################################################

"$script_path/fonts/install.sh"

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

if [[ "$OSTYPE" = darwin* ]]; then
  brew_zsh_path="/usr/local/bin/zsh"
  default_shell=$(dscl . -read "$HOME" UserShell | cut -d' ' -f2)
else
  brew_zsh_path="$HOME/.linuxbrew/bin/zsh"
  default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
fi

if [[ -e "$brew_zsh_path" ]]; then
  if [[ "$default_shell" = "$brew_zsh_path" ]]; then
    echo "Brew ZSH already set to the user's default shell."
  else
    echo ""
    read -p "Set brew ZSH as the user's default shell [y\N] > " -r set_zsh
    case "$set_zsh" in
      [yY][eE][sS]|[yY])
        echo "Sudo might be asked..."
        if [[ "$OSTYPE" = darwin* ]]; then
          sudo dscl . -create "$HOME" UserShell "$brew_zsh_path"
        else
          if ! grep "$brew_zsh_path" /etc/shells >/dev/null; then
            echo "$brew_zsh_path" | sudo tee --append /etc/shells
          fi
          chsh -s "$brew_zsh_path"
         fi
        ;;
    esac
  fi
fi
