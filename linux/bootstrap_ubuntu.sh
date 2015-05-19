#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add Oracle Java repository
sudo apt-add-repository ppa:webupd8team/java

# Do a full upgrade first to get up to date
sudo apt-get update
sudo apt-get dist-upgrade

# Utilities
sudo apt-get install build-essential htop xsel git vim curl wget colordiff screen tmux sysv-rc-conf synaptic

# Firefox
sudo apt-get install firefox

# Compile-time requirements
sudo apt-get install openssl libssl-dev libreadline-dev libsqlite3-dev libbz2-dev zlib1g-dev

# Fonts: Terminus
sudo apt-get install xfonts-terminus xfonts-terminus-oblique xfonts-terminus-dos

# Fonts: Microsoft true type core fonts
sudo apt-get install ttf-mscorefonts-installer

# Install Oracle Java JDK
sudo apt-get install oracle-java8-installer

# XFCE goodies
sudo apt-get install xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

# Restricted extras (Xubuntu only)
sudo apt-get install xubuntu-restricted-extras

