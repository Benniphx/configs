#!/usr/bin/env bash

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update

# Version managers
brew install pyenv pyenv-virtualenv
brew install rbenv ruby-build
brew install nvm

# Install Pythons from brew though
brew install python
brew install python3

# AWS CLI tools
brew install awscli
brew install aws-shell
brew install aws-elasticbeanstalk

# Utilities
brew install terraform
brew install git-secrets

brew cleanup
