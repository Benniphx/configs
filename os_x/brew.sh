#!/usr/bin/env bash

# See: https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

# Homebrew first
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
brew install watch
brew install wdiff --with-gettext
brew install wget

# Already exist on OS X, but homebrew/dupes usually has a newer version
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
brew install autojump
brew install bash-completion
brew install htop-osx
brew install colordiff
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build
brew install file-formula
brew install git
brew install less
brew install openssh
brew install rsync
brew install unzip
brew install p7zip
brew install vim --override-system-vi
brew install macvim --override-system-vim --custom-system-icons
brew install zsh

# Binary distributed
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew cask install sublime-text3
brew cask install iterm2
brew cask install google-chrome
brew cask install google-drive
brew cask install evernote
brew cask install firefox
brew cask install bettertouchtool
brew cask install libreoffice
brew cask install spotify
brew cask install sublime-text
brew cask install virtualbox
brew cask install ukelele

# Final clean up
brew cleanup
brew cask cleanup
