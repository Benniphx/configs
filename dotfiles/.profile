### .profile

### Exports ####################################################################

export LANG='en_US.UTF-8'
export LANGUAGE='en_US-UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='nvim'
export VISUAL="$EDITOR"
export SVN_EDITOR="$EDITOR"

export TERM='xterm-256color'

# no clearing of the screen after quitting man
export PAGER='less'
export MANPAGER='less -X'

### Shell behaviour ############################################################

# default file permissions: u=rwx,g=rx,o=
umask 0027

# allow exiting shell with ^D
unset ignoreeof

# disable stop (^S) and continue (^Q) flow control signals
# stty -ixon

### OS X: Homebrew #############################################################

if [ `uname` = 'Darwin' ]; then
    # prefer GNU coreutils and Homebrew installed binaries
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"

    # show man pages for GNU coreutils instead of the BSD variants
    # from: https://gist.github.com/quickshiftin/9130153
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
fi

### Nvm ########################################################################

nvm_dir="$HOME/.nvm"
if [ -s "$nvm_dir/nvm.sh" ]; then
  export NVM_DIR="$nvm_dir"
  . "$nvm_dir/nvm.sh"
fi

### Pyenv ######################################################################

if [ -d "$HOME/.pyenv" ]; then
  pyenv_path="$HOME/.pyenv/bin"
  export PATH="$pyenv_path:$PATH"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

### Rbenv ######################################################################

if [ -d "$HOME/.rbenv" ]; then
  rbenv_path="$HOME/.rbenv/bin"
  export PATH="$rbenv_path:$PATH"
  eval "$(rbenv init -)"
fi

### Jython #####################################################################

jython_path=$(find "$HOME" -maxdepth 1 -name 'jython*' -type d | head -1)
if [ -d "$jython_path" ]; then
  export JYTHON_HOME="$jython_path"
  export PATH="$JYTHON_HOME/bin:$PATH"
fi

### Own jars to CLASSPATH ######################################################

jars_path="$HOME/jars"
if [ -d "$jars_path" ]; then
  export CLASSPATH=$(find "$jars_path" -name '*.jar' | xargs echo | tr ' ' ':')
fi

### Autojump ###################################################################

autojump_path="$HOME/.autojump/etc/profile.d/autojump.sh"
[ -s "$autojump_path" ] && . "$autojump_path"

### SCM Breeze #################################################################

scm_breeze_path="$HOME/.scm_breeze"
[ -s "$scm_breeze_path/scm_breeze.sh" ] && . "$scm_breeze_path/scm_breeze.sh"

### Prefer user binaries #######################################################

export PATH="$HOME/local/bin:$PATH"

### Dircolors ##################################################################

which dircolors >/dev/null && eval "$(dircolors -b "$HOME"/.dir_colors)"

### Thefuck ####################################################################

which thefuck >/dev/null && eval "$(thefuck --alias)"

### Aliases ####################################################################

if [ `uname` = 'Darwin' ]; then
    # removes annoying .DS_Store files from the given path
    alias rmds='find . -name '.DS_Store' -exec rm -f {} \;'

    # flushes the DNS cache
    alias flush='sudo killall -HUP mDNSResponder'

    alias update='brew update && brew upgrade && brew cleanup && brew cask cleanup'
else
    alias update='sudo apt-get update && sudo apt-get upgrade -y && \
      sudo apt-get autoremove -y && sudo apt-get autoclean'

    alias dupdate='sudo apt-get update && sudo apt-get dist-upgrade -y && \
      sudo apt-get autoremove -y && sudo apt-get autoclean'

    # alternatives to the OS X's pbtools, used by Vim for clipboard
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'

    # open anything, similar to 'open' in OS X
    alias open='xdg-open'
fi

### Copy current path to clipboard #############################################

alias cwd='pwd | tr -d "\n" | pbcopy'

### Sensible defaults ##########################################################

alias ls='ls --color=auto -hlF --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h -c'
alias ping='ping -c 5'
alias mount='mount | column -t'

### Safe defaults ##############################################################

# prompt before override
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# fail upon attempt to recursively change the the root directory
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

### Enhanced ls ################################################################

alias lx='ls -lXB && echo Sorted by extension'
alias lk='ls -lSr && echo Sorted by size, biggest last'
alias lt='ls -ltr && echo Sorted by date, most recent last'
alias lc='ls -ltcr && echo Sorted by change time, most recent last'
alias lu='ls -ltur && echo Sorted by access time, most recent last'

### System #####################################################################

alias r='reset'
alias e='env | sort'
alias g='pgrep -l'
alias h='history'
alias k='pkill'
alias o='open'
alias p="echo -e '${PATH//:/\\n}'"
alias u='du -h -c -d 1'
alias cpu='htop --sort-key PERCENT_CPU || top -o cpu'
alias mem='htop --sort-key PERCENT_MEM || top -o rsize'

### Git ########################################################################

# add and remove new/deleted files from git index
alias gitar='git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove'

# set open source author info for this repository
alias gos='git config user.name "Anssi Syrjäsalo" && git config user.email anssi.syrjasalo@gmail.com'

### Misc #######################################################################

# copy the output of the last command to clipboard
alias cl='fc -e -|pbcopy'

# return the public IP address
alias ip='curl icanhazip.com'

### Utilities ##################################################################

# fast extract
extract() {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# fast password generator
genpasswd() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' | fold -w $1 | head -n1
}

# fast calculator
c() {
    echo "${1}" | bc -l
}

# fast find
f() {
    find ${2:-$PWD} -name $1
}
