#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

dotfiles_path="$script_path/ui/gnu_linux/xfce4"

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

### Install fonts ##############################################################

"$script_path/ui/fonts/install.sh"

### Symlink XFCE for Linux distributions #######################################

if [[ "$OSTYPE" = linux-gnu* ]] ; then
  xfce_configs_path="$HOME/.config/xfce4"
  if [[ ! -L "$xfce_configs_path" ]] ; then
    mv -i "$xfce_configs_path" "${xfce_configs_path}-old"
    ln -snvi"$ln_args" "$dotfiles_path" "$xfce_configs_path"
  fi
fi
