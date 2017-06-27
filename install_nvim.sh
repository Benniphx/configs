#!/bin/bash

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update
brew install neovim/neovim/neovim

### Symlink Neovim configs #####################################################

mkdir -p "$HOME/.config"
ln -sf "$HOME/.vim" "$HOME/.config/nvim"
ln -sf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"

### Install Vundle #############################################################

vundle_dir="$HOME/.vim/bundle/Vundle.vim"
git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_dir" || \
  git -C "$vundle_dir" pull --rebase origin master

echo -ne '\n' | nvim +PluginInstall +qall 2>/dev/null
