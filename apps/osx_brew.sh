#!/usr/bin/env bash

# Based on:
# https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

# Install Homebrew if not exists
if ! which brew >/dev/null ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# GNU coreutils
brew install coreutils

# System duplicate formulae, without the 'g' prefix.
brew tap homebrew/dupes
brew install binutils
brew install diffutils
brew install ed --default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install tmux
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
brew install ack
brew install tree
brew install thefuck
brew install bash-completion
brew install htop-osx
brew install colordiff
brew install file-formula
brew install git
brew install tig
brew install less
brew install openssh
brew install rsync
brew install unzip
brew install p7zip
brew install vim --override-system-vi
brew install macvim --override-system-vim --custom-system-icons
brew install zsh

# Version managers
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build
brew install nvm

# Set up Homebrew Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Terminals
brew cask install iterm2

# Editors
brew cask install sublime-text3
brew cask install libreoffice

# Browsers
brew cask install google-chrome
brew cask install firefox

# Misc
brew cask install google-drive
brew cask install spotify

# Keyboard tools
brew cask install amethyst
brew cask install ukelele

# Do final clean ups
brew cleanup
brew cask cleanup
