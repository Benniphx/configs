#!/usr/bin/env bash

# Targeted both for Homebrew and Linuxbrew

brew update
brew upgrade

# Commonly used
brew install ack
brew install cmake
brew install ctags
brew install colordiff
brew install diff-so-fancy
brew install file-formula
brew install neovim/neovim/neovim
brew install ranger
brew install scmpuff
brew install thefuck
brew install the_silver_searcher
brew install tig
brew install tmux

# Version managers
brew install node
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build

# Do final clean ups
brew cleanup
