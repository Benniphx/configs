#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add Oracle Java repository
sudo apt-add-repository -y ppa:webupd8team/java

# Add Neovim repository
sudo add-apt-repository -y ppa:neovim-ppa/unstable

# Do a full upgrade first to get the system up to date
sudo apt update
sudo apt dist-upgrade -y

# usual compile-time requirements
sudo apt install -y libssl-dev libreadline-dev libsqlite3-dev \
    libbz2-dev zlib1g-dev python-dev

# ruby
sudo apt install ruby

# utilities
sudo apt install -y build-essential cmake colordiff curl git htop openssl \
    python-setuptools ranger screen silversearcher-ag synaptic tmux vim \
    vim-gtk wget xsel zsh

# neovim
sudo apt install -y neovim

# firefox
sudo apt install -y firefox

# chat programs
sudo apt install -y profanity

# Microsoft true type core fonts
sudo apt install -y ttf-mscorefonts-installer

# Oracle Java JDK
sudo apt install -y oracle-java8-installer

# XFCE goodies
sudo apt install -y xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

# xmonad related
sudo apt install -y xmonad xmobar dmenu gmrun trayer yeganesh scrot \
    suckless-tools

# Xubuntu restricted extras
sudo apt install -y xubuntu-restricted-extras

# Do final clean ups
sudo apt -y autoremove
sudo apt autoclean
