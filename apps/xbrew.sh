#!/usr/bin/env bash

# These can be installed by Homebrew (OS X) or Linuxbrew (Linux distros)
brew update

# From homebrew-dupes
brew tap homebrew/dupes
brew install diffutils
brew install gpatch
brew install gzip
brew install file-formula
brew install less
brew install nano
brew install rsync
brew install screen

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
brew install neovim/neovim/neovim
brew install p7zip
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
brew install zsh

# Version managers
brew install node nvm
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build

# Do final clean up
brew cleanup
