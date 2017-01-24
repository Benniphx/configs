#!/usr/bin/env bash

if ! which brew >/dev/null; then
  if [[ "$OSTYPE" = darwin* ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update

# homebrew-dupes
#brew install homebrew/dupes/diffutils
#brew install homebrew/dupes/gpatch
brew install homebrew/dupes/gzip
#brew install homebrew/dupes/file-formula
brew install homebrew/dupes/less
brew install homebrew/dupes/nano
brew install homebrew/dupes/rsync
brew install homebrew/dupes/screen

# homebrew-core
brew install autojump
brew install bash
brew install bash-completion
brew install colordiff
brew install ctags
brew install curl
brew install git
brew install htop
brew install httpie
brew install jq
brew install neovim/neovim/neovim
brew install p7zip
brew install peco
brew install pstree
brew install ranger
brew install scmpuff
brew install thefuck
brew install the_silver_searcher
brew install tig
brew install tmux
brew install tree
brew install wdiff --with-gettext
brew install wget

# OS X only brews
if [[ "$OSTYPE" == darwin* ]]; then
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

  # Homebrew Casks
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap buo/cask-upgrade

  brew cask install iterm2
  brew cask install sublime-text
  brew cask install google-chrome
  brew cask install google-drive
  brew cask install spotify
  brew cask install amethyst
  brew cask install ukelele
  brew cask install keepassx
  brew cask install gpgtools

  brew cask cleanup
fi

brew cleanup
