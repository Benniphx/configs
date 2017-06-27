#!/bin/bash

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update

### Pyenv ######################################################################

brew install pyenv pyenv-virtualenv
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"

# Python 2.7
python2_version="2.7.12"
pyenv install --skip-existing "$python2_version"
pyenv shell "$python2_version"
pip install --upgrade pip virtualenv
pip install awscli
pip install awscfncli
pip install awsebcli
pip install awslogs
pip install aws-shell
pip install httpie
pip install s4cmd

# Python 3.5
python3_version="3.5.2"
pyenv install --skip-existing "$python3_version"
pyenv shell "$python3_version"
pip install --upgrade pip virtualenv
pip install awscli
pip install awscfncli
pip install awsebcli
pip install awslogs
pip install aws-shell
pip install httpie
# s4cmd is Python 2 only

pyenv global "$python2_version"

### Rbenv ######################################################################

brew install rbenv ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Ruby 2.4
ruby_version="2.4.1"
rbenv install --skip-existing "$ruby_version"
rbenv shell "$ruby_version"
gem install bundler

rbenv global "$ruby_version"

### nvm ########################################################################

brew install nvm
export NVM_DIR="$HOME/.nvm"
[[ ! -d "$NVM_DIR" ]] && mkdir -p "$NVM_DIR"
. "$(brew --prefix nvm)/nvm.sh"

# Node LTS
nvm install v7.7.1

### utils ######################################################################

brew install terraform
brew install git-secrets

if [[ "$OSTYPE" = darwin* ]] ; then
  brew cask install aws-vault
fi

brew cleanup
