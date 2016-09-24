#!/usr/bin/env bash

# Ask for the sudo password upfront
sudo -v

# Keep alive the sudo until this script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Do a full upgrade first to get the system up to date
sudo apt update
sudo apt dist-upgrade -y

# The common compile-time requirements
sudo apt install -y libssl-dev libreadline-dev libsqlite3-dev libbz2-dev \
  zlib1g-dev python-dev

# Ruby
sudo apt install -y ruby

# utilities
sudo apt install -y build-essential htop openssl python-setuptools synaptic \
  vim vim-gtk wget xsel

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install -y google-chrome-stable

# Microsoft true type core fonts
sudo apt install -y ttf-mscorefonts-installer

# Oracle Java JDK
sudo sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-ubuntu-java-xenial.list'
sudo apt update
sudo apt install -y oracle-java8-installer

# XFCE goodies
sudo apt install -y xfce4-goodies gtk2-engines-murrine murrine-themes

# xmonad and apps
sudo apt install -y xmonad xmobar gmrun trayer scrot suckless-tools

# Xubuntu restricted extras
sudo apt install -y xubuntu-restricted-extras

# Do the final clean ups
sudo apt -y autoremove
sudo apt autoclean
