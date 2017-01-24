#!/usr/bin/env bash

### Set zsh as the default shell ###############################################

if [[ "$OSTYPE" = darwin* ]]; then
  brew_zsh_path="/usr/local/bin/zsh"
  default_shell=$(dscl . -read "$HOME" UserShell | cut -d' ' -f2)
else
  brew_zsh_path="$HOME/.linuxbrew/bin/zsh"
  default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
fi

if [[ -e "$brew_zsh_path" ]]; then
  if [[ "$default_shell" = "$brew_zsh_path" ]]; then
    echo "Brew ZSH already set to the user's default shell."
  else
    echo ""
    read -p "Set brew ZSH as the user's default shell [y\N] > " -r set_zsh
    case "$set_zsh" in
      [yY][eE][sS]|[yY])
        echo "Sudo might be asked..."
        if [[ "$OSTYPE" = darwin* ]]; then
          sudo dscl . -create "$HOME" UserShell "$brew_zsh_path"
        else
          if ! grep "$brew_zsh_path" /etc/shells >/dev/null; then
            echo "$brew_zsh_path" | sudo tee --append /etc/shells
          fi
          chsh -s "$brew_zsh_path"
         fi
        ;;
    esac
  fi
fi
