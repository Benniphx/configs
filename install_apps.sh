#!/usr/bin/env bash

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update

### Homebrew core ##############################################################
brew install bash
brew install bash-completion
brew install colordiff

brew install diffutils
brew install ctags
brew install fasd
brew install fzf && yes | "$(brew --prefix fzf)/install" --no-update-rc
brew install git
brew install htop
brew install httpie
brew install jq
brew install less
brew install neovim/neovim/neovim
brew install p7zip
brew install pssh
brew install pstree
brew install ranger
brew install rsync
brew install scmpuff
brew install screen
brew install thefuck
brew install the_silver_searcher
brew install tig
# uncomment when 2.4 fixed
# brew install tmux
brew install tree
brew install wdiff --with-gettext
brew install yank

### OS X only brews ############################################################

if [[ "$OSTYPE" = darwin* ]] ; then
  # Additional taps
  brew tap homebrew/command-not-found
  brew tap homebrew/services

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

  # These are on Linuxbrew's tap but at least currently compile on OS X only
  brew install shellcheck
  brew install watch

  # OS X fix for tmux+pbcopy+pbpaste combination
  brew install reattach-to-user-namespace

  # Terminal notifier
  brew install terminal-notifier

  # Mac Apple Store command-line client
  brew install mas

  # Docker-compose
  brew install docker-compose --without-docker --without-docker-machine

  # Homebrew Cask taps
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap buo/cask-upgrade

  # Homebrew Cask apps
  # brew cask install cakebrew
  brew cask install cheatsheet
  brew cask install cocoarestclient
  brew cask install coconutbattery
  brew cask install gitup
  brew cask install google-chrome
  brew cask install google-drive
  brew cask install gpgtools
  brew cask install docker
  brew cask install iterm2
  brew cask install keepassx
  brew cask install launchcontrol
  brew cask install macdown
  # brew cask install psequel
  # brew cask install sequel-pro
  # brew cask install soundcleod
  brew cask install spotify
  brew cask install sublime-text
  brew cask install the-unarchiver
  brew cask install ukelele
  # brew cask install vimr

  # Finder quick look plugins
  # https://github.com/sindresorhus/quick-look-plugins
  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json \
    qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook \
    suspicious-package quicklookase qlvideo

  brew cask cleanup
fi

brew cleanup
