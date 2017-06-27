#!/bin/bash

set -e
set -u

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

dotfiles_path="$script_path/sublime"

### Parse arguments ############################################################

ln_args=''
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

### Symlink Sublime User configuration #########################################

if [[ "$OSTYPE" = darwin* ]] ; then
  user_path="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
else
  user_path="$HOME/.config/sublime-text-3/Packages/User"
fi

[[ "$ln_args" = f ]] && [[ ! -h "$user_path" ]] && rm -rf "$user_path"
ln -snvi"$ln_args" "$dotfiles_path" "$user_path"
