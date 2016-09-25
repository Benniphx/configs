#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
dotfiles_path="$script_path/sublime"

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

### Symlink Sublime User configuration #########################################

if [[ $(uname) = 'Darwin' ]]; then
  user_path="$HOME/Library/Application Support/Sublime Text $sublime_version/Packages/User"
else
  user_path="$HOME/.config/sublime-text-$sublime_version/Packages/User"
fi


[[ "$ln_args" == 'f' ]] && [[ ! -h "$user_path" ]] && rm -rf "$user_path"
ln -snvi"$ln_args" "$dotfiles_path" "$user_path"
