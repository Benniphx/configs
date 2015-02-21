#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &



# Utilities
sudo apt-get install build-essential htop xsel git vim curl wget colordiff sysv-rc-conf

# Browsers
sudo apt-get install chromium-browser firefox

# Compile-time requirements
sudo apt-get install openssl libssl-dev libreadline-dev libsqlite3-dev libbz2-dev zlib1g-dev

# Fonts (MS + Terminus)
sudo apt-get install ttf-mscorefonts-installer xfonts-terminus xfonts-terminus-oblique xfonts-terminus-dos

# XFCE goodies
sudo apt-get install xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

# Restricted extras (Xubuntu only)
sudo apt-get install xubuntu-restricted-extras
