#!/bin/bash

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update

### Homebrew core ##############################################################
brew install colordiff
brew install diffutils
brew install ccat
brew install ctags
brew install curl --ignore-dependencies
brew install fasd
brew install fzf && yes | "$(brew --prefix fzf)/install" --no-update-rc
brew install git --ignore-dependencies
brew install htop
brew install jq
brew install less
brew install p7zip
brew install pstree
brew install ranger
brew install rsync
brew install scmpuff
brew install screen
brew install the_silver_searcher
brew install tig
brew install tree
brew install wdiff
brew install yank

# uncomment when 2.4 fixed
# brew install tmux
tpm_url="https://github.com/tmux-plugins/tpm"
git -C "$tpm_url" pull --rebase 2>/dev/null || \
  git clone --depth 1 "$tpm_url" "$HOME/.tmux/plugins/tpm" 2>/dev/null

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

  # These are on Linuxbrew's tap but at least currently compile on OS X only
  brew install shellcheck
  brew install watch

  # OS X fix for tmux+pbcopy+pbpaste combination
  brew install reattach-to-user-namespace

  # Terminal notifier
  brew install terminal-notifier

  # Mac Apple Store command-line client
  brew install mas

  # Homebrew Cask taps
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap buo/cask-upgrade

  # Homebrew Cask apps
  # brew cask install cakebrew
  brew cask install cheatsheet
  brew cask install coconutbattery
  brew cask install gitup
  brew cask install google-chrome
  brew cask install google-drive
  brew cask install gpgtools
  brew cask install docker
  brew cask install iterm2
  brew cask install keeweb
  brew cask install launchcontrol
  brew cask install macdown
  brew cask install soundcleod
  brew cask install spotify
  brew cask install sublime-text
  brew cask install the-unarchiver
  brew cask install ukelele

  # Finder quick look plugins
  # https://github.com/sindresorhus/quick-look-plugins
  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json \
    qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook \
    suspicious-package quicklookase qlvideo

  brew cask cleanup
fi

brew cleanup
