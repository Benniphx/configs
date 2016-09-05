#!/usr/bin/env bash

# Ask for the sudo password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add Oracle Java repository
sudo sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-ubuntu-java-xenial.list'

# Add Neovim repository
sudo sh -c 'echo "deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main" > /etc/apt/sources.list.d/neovim-ppa-ubuntu-unstable-xenial.list'

# Add Google Chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

# Do a full upgrade first to get the system up to date
sudo apt update
sudo apt dist-upgrade -y

# The common compile-time requirements
sudo apt install -y libssl-dev libreadline-dev libsqlite3-dev \
  libbz2-dev zlib1g-dev python-dev

# Ruby
sudo apt install -y ruby

# utilities
sudo apt install -y build-essential cmake colordiff curl git htop openssl \
  python-setuptools ranger screen silversearcher-ag synaptic tmux vim \
  vim-gtk wget xsel zsh

# Neovim
sudo apt install -y neovim

# Firefox
sudo apt install -y firefox

# Google Chrome
sudo apt install -y google-chrome-stable

# Profanity (Irssi style XMPP client)
sudo apt install -y profanity

# Microsoft true type core fonts
sudo apt install -y ttf-mscorefonts-installer

# Oracle Java JDK
sudo apt install -y oracle-java8-installer

# XFCE goodies
sudo apt install -y xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

# xmonad and apps
sudo apt install -y xmonad xmobar gmrun trayer scrot suckless-tools

# Xubuntu restricted extras
sudo apt install -y xubuntu-restricted-extras

# Do the final clean ups
sudo apt -y autoremove
sudo apt autoclean
