#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add Oracle Java repository
sudo apt-add-repository -y ppa:webupd8team/java

# Do a full upgrade first to get the system up to date
sudo apt-get update
sudo apt-get dist-upgrade

# utilities
sudo apt-get install -y build-essential htop xsel git vim vim-gtk curl wget \
    colordiff screen tmux synaptic openssl cmake silversearcher-ag

# browsers
sudo apt-get install -y chromium-browser firefox

# usual compile-time requirements
sudo apt-get install -y libssl-dev libreadline-dev libsqlite3-dev \
    libbz2-dev zlib1g-dev python-dev

# Microsoft true type core fonts
sudo apt-get install -y ttf-mscorefonts-installer

# Oracle Java JDK
sudo apt-get install -y oracle-java8-installer

# XFCE goodies
sudo apt-get install -y xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

# xmonad related
sudo apt-get install -y xmonad xmobar dmenu gmrun trayer yeganesh scrot \
    suckless-tools

# rbenv and ruby-build
sudo apt-get install -y rbenv ruby-build

# restricted extras
sudo apt-get install -y xubuntu-restricted-extras
