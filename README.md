Utilities
=========

GNU/Linux
---------

Utilities:

    sudo apt-get install build-essential htop xsel git vim curl wget colordiff sysv-rc-conf

Browsers:

    sudo apt-get install chromium-browser firefox

Compile-time requirements:

    sudo apt-get install openssl libssl-dev libreadline-dev libsqlite3-dev libbz2-dev zlib1g-dev

Fonts (MS + Terminus):

    sudo apt-get install ttf-mscorefonts-installer xfonts-terminus xfonts-terminus-oblique xfonts-terminus-dos

XFCE goodies:

    sudo apt-get install xfce4-goodies gtk2-engines-murrine gtk2-engines-pixbuf

Restricted extras (Xubuntu only):

    sudo apt-get install xubuntu-restricted-extras

OS X
----

Install XCode:

    Check the up-to-date instructions on Google.

Install Homebrew:

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

Install utilities:

    brew install htop git colordiff wget

Install GNU tools _with default names_:

    brew install coreutils
    brew install findutils --default-names
    brew install gnu-indent --default-names
    brew install gnu-sed --default-names
    brew install gnu-tar --default-names
    brew install gnu-which --default-names
    brew install gnutls --default-names
    brew install grep --default-names

Install MacVim:

    brew install macvim --override-system-vim

Install additional Bash completions:

    brew install bash-completion


Configurations
==============

Run in terminal:

    git clone git@github.com:asyrjasalo/configs.git $HOME/configs
    configs/bootstrap.sh -f

WARNING: Using command-line argument -f replaces the files/directories
with same-named symlinks at the user's $HOME.


Oracle Java
===========

Linux
-----

To install Oracle Java:

    sudo add-apt-repository ppa:webupd8team/java -y && sudo apt-get update && sudo apt-get install oracle-java7-installer


Pyenv
=====

Linux
-----

Install pyenv:

    git clone git@github.com:yyuu/pyenv.git ~/.pyenv

Install pyenv virtualenv wrapper:

    git clone git@github.com:yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv


OS X
----

Install pyenv and the virtualenv wrapper using Homebrew:

    brew install pyenv pyenv-virtualenv


Rbenv
=====

Linux
-----

Install rbenv:

    git clone git@github.com:sstephenson/rbenv.git ~/.rbenv

Install ruby-build:

    git clone git@github.com:sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

OS X
----

Install rbenv and ruby-build using Homebrew:

    brew install rbenv ruby-build

