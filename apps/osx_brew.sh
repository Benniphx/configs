#!/usr/bin/env bash

# Based on:
# https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

# Install Homebrew if not exists
if ! which brew >/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# Might be already installed but homebrew/dupes usually has newer versions
brew tap homebrew/dupes
brew install diffutils
brew install gpatch
brew install gzip
brew install less
brew install nano

# GNU utils are g-prefixed (but can also be installed --with-default-names)
brew install coreutils
brew install findutils
brew install gawk
brew install gnu-indent
brew install gnu-sed
brew install gnu-tar
brew install gnu-which
brew install grep
brew install make

# Commonly used from homebrew-core
brew install bash
brew install htop-osx
brew install p7zip
brew install pstree
brew install macvim --with-override-system-vim
brew install reattach-to-user-namespace
brew install tree
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install zsh

# Set up Homebrew Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

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

# Password managers
brew cask install keepassx

# Do final clean ups
brew cleanup
brew cask cleanup
