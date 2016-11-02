#!/usr/bin/env bash

# These can be installed by Homebrew (OS X) or Linuxbrew (Linux distros)
brew update

# From homebrew-dupes
brew install homebrew/dupes/diffutils
brew install homebrew/dupes/gpatch
brew install homebrew/dupes/gzip
brew install homebrew/dupes/file-formula
brew install homebrew/dupes/less
brew install homebrew/dupes/nano
brew install homebrew/dupes/rsync
brew install homebrew/dupes/screen

# From homebrew-core
brew install ack
brew install autojump
brew install bash
brew install bash-completion
brew install colordiff
brew install ctags
brew install curl
brew install diff-so-fancy
brew install git
brew install htop
brew install httpie
brew install neovim/neovim/neovim
brew install p7zip
brew install peco
brew install pstree
brew install ranger
brew install shellcheck
brew install scmpuff
brew install thefuck
brew install the_silver_searcher
brew install tig
brew install tmux
brew install tree
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install zplug
brew install zsh

# Version managers
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build

# Do final clean up
brew cleanup
