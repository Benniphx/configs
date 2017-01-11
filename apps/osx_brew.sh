#!/usr/bin/env bash

if [[ "$OSTYPE" != darwin* ]]; then
  echo "These are OS X only brews."
  exit 1
fi

if ! which brew >/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# GNU utils are g-prefixed (but can also be installed --with-default-names)
brew install coreutils
brew install findutils
brew install gawk
brew install gnu-indent
brew install gnu-sed
brew install gnu-tar
brew install gnu-which
brew install homebrew/dupes/grep
brew install homebrew/dupes/make

# These are on Linuxbrew's tap but currently compile on OS X only
brew install shellcheck
brew install watch

# OS X fix for tmux+pbcopy+pbpaste combination
brew install reattach-to-user-namespace

# Set up Homebrew Cask
brew tap caskroom/cask
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

# GPG Suite
brew cask install gpgtools

# Do final clean ups
brew cleanup
brew cask cleanup
