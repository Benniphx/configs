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

### Homebrew/Linuxbrew #########################################################

if [[ `uname` = 'Darwin' ]]; then
  # prepend homebrew installed binaries to path
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

  coreutils_bin_path="$(brew --prefix coreutils)/libexec/gnubin"
  [[ -d "$coreutils_bin_path" ]] && export PATH="$coreutils_bin_path:$PATH"

  findutils_bin_path="$(brew --prefix findutils)/libexec/gnubin"
  [[ -d "$findutils_bin_path" ]] && export PATH="$findutils_bin_path:$PATH"
else
  if [[ -d "$HOME/.linuxbrew" ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  fi
fi

### Nvm ########################################################################

nvm_dir="$HOME/.nvm"
if [[ -d "$nvm_dir" ]]; then
  [[ -s "$nvm_dir/nvm.sh" ]] && export NVM_DIR="$nvm_dir" && . "$nvm_dir/nvm.sh"
fi

### Pyenv ######################################################################

if [[ -d "$HOME/.pyenv" ]]; then
  pyenv_path="$HOME/.pyenv/bin"
  export PATH="$pyenv_path:$PATH"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

### Rbenv ######################################################################

if [[ -d "$HOME/.rbenv" ]]; then
  rbenv_path="$HOME/.rbenv/bin"
  export PATH="$rbenv_path:$PATH"
  eval "$(rbenv init -)"
fi

### Jython #####################################################################

jython_path=$(find "$HOME" -maxdepth 1 -name 'jython*' -type d | head -1)
if [[ -d "$jython_path" ]]; then
  export JYTHON_HOME="$jython_path"
  export PATH="$JYTHON_HOME/bin:$PATH"
fi

### Go #########################################################################

go_path="$HOME/go"
if [[ -d "$go_path" ]]; then
  export PATH="$go_path/bin:$PATH"
fi

### Own jars to CLASSPATH ######################################################

jars_path="$HOME/jars"
if [[ -d "$jars_path" ]]; then
  export CLASSPATH=$(find "$jars_path" -name '*.jar' | xargs echo | tr ' ' ':')
fi

### Autojump ###################################################################

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && \
  . $(brew --prefix)/etc/profile.d/autojump.sh

### SCM puff #################################################################

which scmpuff >/dev/null && eval "$(scmpuff init -s)"

### Prefer user binaries #######################################################

export PATH="$HOME/.local/bin:$PATH"

### Dircolors ##################################################################

which dircolors >/dev/null && eval "$(dircolors -b "$HOME"/.dir_colors)"

### Thefuck ####################################################################

which thefuck >/dev/null && eval "$(thefuck --alias)"

### Aliases ####################################################################

# Upgrade Homebrew/Linuxbrew formulas
alias br='brew update && brew upgrade && brew cleanup'

if [[ `uname` = 'Darwin' ]]; then
  # Brew cask upgrade
  alias brc='brew update && brew cu && brew cask cleanup'

  # Install OS X software updates
  alias update='sudo softwareupdate --install --all'

  # Recursively delete .DS_Store files from the current path
  alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'

  # Flushes the OS X DNS cache
  alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

  # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'

  # Mute or unmute sounds
  alias mute='osascript -e "set volume output muted true"'
  alias blast='osascript -e "set volume output muted false"'

  # Lock the screen
  alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

  # Show or hide hidden files in Finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

  # Disable or enable Spotlight
  alias spotoff='sudo mdutil -a -i off'
  alias spoton='sudo mdutil -a -i on'

  # Empty the Trash on all mounted volumes and the main HDD
  # Also, clear Apple’s System Logs to improve shell startup speed
  # Finally, clear download history from quarantine. See: https://mths.be/bum
  alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* "delete from LSQuarantineEvent"'

  # Canonical hex dump; some systems have this symlinked
  command -v hd > /dev/null || alias hd='hexdump -C'

  # OS X has no `md5sum`, use `md5` as a fallback
  command -v md5sum > /dev/null || alias md5sum='md5'

  # OS X has no `sha1sum`, use `shasum` as a fallback
  command -v sha1sum > /dev/null || alias sha1sum='shasum'
else
  alias update='sudo apt-get update && sudo apt-get upgrade -y && \
    sudo apt-get autoremove -y && sudo apt-get autoclean'

  alias dupdate='sudo apt-get update && sudo apt-get dist-upgrade -y && \
    sudo apt-get autoremove -y && sudo apt-get autoclean'

  # Alternatives to the OS X's `pbcopy` and `pbpaste`
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'

  # Open anything, similar to `open` in OS X
  alias open='xdg-open'
fi

### More sensible defaults #####################################################

alias ls='ls --color=auto -hlF --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ping='ping -c 5'
alias mount='mount | column -t'

### Safer defaults #############################################################

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

### Enhanced ls ################################################################

alias lx='ls -lXB && echo Sorted by extension'
alias lk='ls -lSr && echo Sorted by size, biggest last'
alias lt='ls -ltr && echo Sorted by date, most recent last'
alias lc='ls -ltcr && echo Sorted by change time, most recent last'
alias lu='ls -ltur && echo Sorted by access time, most recent last'

### Shortcuts ##################################################################

alias e="$EDITOR"
alias h='history'
alias k='pkill -i -l'
alias o='open'
alias p='pgrep -i -l'
alias u='du -h -c -d 1'
alias dl='cd ~/Downloads'
alias path="echo -e '${PATH//:/\\n}'"
alias reload="exec $SHELL -l"
alias cpu='htop --sort-key PERCENT_CPU || top -o cpu'
alias mem='htop --sort-key PERCENT_MEM || top -o rsize'

### Misc #######################################################################

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Copy the current path to clipboard
alias cwd='pwd | tr -d "\n" | pbcopy'

# Get the public IP address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Get the week number
alias week='date +%V'

### Utilities ##################################################################

# Fast calculator
c() {
  echo "${1}" | bc -l
}

# Fast find
f() {
  find ${2:-$PWD} -name $1
}

# Fast password generator
genpasswd() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' | \
    fold -w $1 | head -n1
}

# Stopwatch
timer() {
  echo 'Timer started. Stop with Ctrl-D.'
  date
  time cat
  date
}

# Fast extract
extract() {
 if [[ -f $1 ]]; then
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
