#!/bin/bash

set -e
set -u

if ! which brew >/dev/null ; then
  if [[ "$OSTYPE" = darwin* ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

brew update
brew install bash
brew install bash-completion

### Set bash as the default shell ##############################################

if [[ "$OSTYPE" = darwin* ]] ; then
  brew_bash_path="/usr/local/bin/bash"
  default_shell=$(dscl . -read "$HOME" UserShell | cut -d' ' -f2)
else
  brew_bash_path="$HOME/.linuxbrew/bin/bash"
  default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
fi

if [[ -e "$brew_bash_path" ]] ; then
  if [[ "$default_shell" = "$brew_bash_path" ]] ; then
    echo "Brew Bash is already set to the user's default shell."
  else
    echo ""
    read -p "Set brew Bash as the user's default shell [y\N] > " -r set_bash
    case "$set_bash" in
      [yY][eE][sS]|[yY])
        echo "Sudo password is likely asked..."
        if ! grep -q "$brew_bash_path" /etc/shells >/dev/null ; then
          echo "$brew_bash_path" | sudo tee --append /etc/shells
        fi
        if [[ "$OSTYPE" = darwin* ]] ; then
          sudo dscl . -create "$HOME" UserShell "$brew_bash_path"
        else
          chsh -s "$brew_bash_path"
         fi
        ;;
    esac
  fi
fi
