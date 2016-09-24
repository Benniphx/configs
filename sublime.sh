#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
sublime_dotfiles_path="$script_path/sublime"

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

if [[ `uname` = 'Darwin' ]]; then
  sublime_user_path="$HOME/Library/Application Support/Sublime Text $sublime_version/Packages/User"
else
  sublime_user_path="$HOME/.config/sublime-text-$sublime_version/Packages/User"
fi

rm -r"$ln_args" "$sublime_user_path"
ln -snvi"$ln_args" "$sublime_dotfiles_path" "$sublime_user_path"
