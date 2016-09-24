#!/usr/bin/env bash

# These can be installed by Homebrew (OS X) or Linuxbrew (Linux distros)

brew update
brew upgrade

# Commonly used
brew install ack
brew install autojump
brew install bash-completion
brew install ctags
brew install colordiff
brew install curl
brew install diff-so-fancy
brew install file-formula
brew install git
brew install neovim/neovim/neovim
brew install ranger
brew install rsync
brew install shellcheck
brew install screen
brew install scmpuff
brew install thefuck
brew install the_silver_searcher
brew install tig
brew install tmux

# Version managers
brew install node nvm
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build

# Do final clean ups
brew cleanup
