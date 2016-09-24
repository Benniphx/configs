#!/usr/bin/env bash

# Based on:
# https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

# Install Homebrew if not exists
if ! which brew >/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# GNU utilities
brew tap homebrew/dupes
brew install coreutils  # GNU Coreutils are g-prefixed
brew install binutils
brew install diffutils
brew install ed
brew install findutils
brew install gawk
brew install gnu-indent
brew install gnu-sed
brew install gnu-tar
brew install gnu-which
brew install gnutls
brew install grep
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget

# Likely already installed but homebrew/dupes usually has a newer version
brew install bash
brew install emacs
brew install gdb  # gdb requires some further actions, see `brew info gdb`.
brew install gpatch
brew install m4
brew install make
brew install nano

# Commonly used
brew install bash-completion
brew install git
brew install htop-osx
brew install less
brew install openssh
brew install p7zip
brew install macvim --with-override-system-vim --custom-system-icons
brew install reattach-to-user-namespace
brew install rsync
brew install shellcheck
brew install tree
brew install unzip
brew install zsh

# Set up Homebrew Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Terminals
brew cask install iterm2

# Editors
brew cask install sublime-text

# Browsers
brew cask install google-chrome

# Sync utilities
brew cask install google-drive

# Players
brew cask install spotify

# Window managers
brew cask install amethyst

# Keyboard remapping tools
brew cask install ukelele

# Do final clean ups
brew cleanup
brew cask cleanup
