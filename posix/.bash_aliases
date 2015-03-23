# For OS specific configuration
OS_IDENTIFIER=${OSTYPE//[0-9.]/}

if [[ "$OS_IDENTIFIER" == 'darwin' ]]; then
    # this requires running: brew install macvim --override-system-vim
    alias vim='mvim -v'

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

### MOVING AROUND ##############################################################

alias cd..='cd ..'  # a common typo
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# copy the working directory path to the clipboard
alias cwd='pwd | tr -d "\n" | pbcopy'

### LISTINGS ###################################################################

alias ls='ls --color=auto -hlF --group-directories-first'
alias lx='ls -lXB && echo Sorted by extension'
alias lk='ls -lSr && echo Sorted by size, biggest last'
alias lt='ls -ltr && echo Sorted by date, most recent last'
alias lc='ls -ltcr && echo Sorted by change time, most recent last'
alias lu='ls -ltur && echo Sorted by access time, most recent last'

### GREP #######################################################################

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### SENSIBLE DEFAULTS ##########################################################

alias df='df -h'
alias du='du -h -c'
alias diff='colordiff'
alias ping='ping -c 5'
alias more='less'
alias mount='mount | column -t'
alias mkdir='mkdir -p -v'
alias wget='wget -c'

### SAFETY #####################################################################

alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

### SYSTEM #####################################################################

alias e='env | sort'
alias g='pgrep -l'
alias h='history | grep'
alias k='pkill'
alias o='open'
alias p="echo -e '${PATH//:/\\n}'"
alias s="source $HOME/.bash_profile"
alias u='du -h -c -d 1'
alias cpu='htop --sort-key PERCENT_CPU || top -o cpu'
alias mem='htop --sort-key PERCENT_MEM || top -o rsize'

### GIT ########################################################################

# add and remove new/deleted files from git index
alias gitar='git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove'

# use my open source author information for this repository
alias gos='git config user.name "Anssi Syrjäsalo" && git config user.email anssi.syrjasalo@gmail.com'

### RUBY ON RAILS ##############################################################

alias be='bundle exec'
alias ber='bundle exec rake'
alias bes='bundle exec rake spec'
alias bec='bundle exec cucumber'
alias bers='bundle exec rails server'
alias berc='bundle exec rails console'
alias rmgems='for i in `gem list --no-versions`; do gem uninstall -aIx $i; done'

### MISC #######################################################################

# copy the output of the last command to clipboard
alias cl='fc -e -|pbcopy'

# return the public IP address
alias ip='curl icanhazip.com'

### UTILITIES ##################################################################

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

# fast calculator
c() {
    echo "${1}" | bc -l
}

# fast find
f() {
    find ${2:-$PWD} -name $1
}
