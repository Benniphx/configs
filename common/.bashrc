
# quit immediately if this shell is not interactive
if [ -z "$PS1" ]; then
   return
fi

os_identifier="${OSTYPE//[0-9.]/}"

### Exports ####################################################################

export LANG='en_US'
export LC_ALL='en_US.UTF-8'

export EDITOR='vim'
export VISUAL=$EDITOR
export SVN_EDITOR=$EDITOR

# no clearing of the screen after quitting man
export PAGER='less'
export MANPAGER='less -X'

### Shell behaviour ############################################################

# default file permissions
umask 0077  # (u=rwx,g=,o=)

# have Bash to check if the window size has changed
shopt -s checkwinsize

# append to the history file instead of overwriting it
shopt -s histappend

# case-insensitive globbing (e.g. in pathname expansion)
shopt -s nocaseglob

# autocorrect typos in path names when using `cd`
shopt -s cdspell

# combine multiline commands into one in history
shopt -s cmdhist

# allow exiting with ^D
unset ignoreeof

# disable ^S/^Q flow control
stty -ixon

### History ####################################################################

HISTSIZE=100
HISTFILESIZE=10000
HISTCONTROL=ignoredups:ignorespace

# make some commands not show up in history
HISTIGNORE='ls:cd:cd -:pwd:exit:date'

# search history with arrows
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

### OS X: Homebrew #############################################################

if [ "$os_identifier" == 'darwin' ]; then
    # prefer GNU coreutils and Homebrew installed binaries
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"

    # show man pages for GNU coreutils instead of the BSD variants
    # from: https://gist.github.com/quickshiftin/9130153
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
fi

### Completion #################################################################

# additional bash comletions
if [ "$os_identifier" == 'darwin' ]; then
    # brew install bash-completion
    bash_completion_path="$(brew --prefix)/etc/bash_completion"
else
    bash_completion_path='/etc/bash_completion'
fi
[ -f $bash_completion_path ] && . $bash_completion_path

# add tab completion for hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" \
  -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" \
    | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

### Autojump ###################################################################

if [ "$os_identifier" == 'darwin' ]; then
    [ -s $(brew --prefix)/etc/autojump.sh ] && . $(brew --prefix)/etc/autojump.sh
fi

### SCM prompt #################################################################

# color shortcuts
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

parse_git_branch() {
    git branch --no-color 2> /dev/null | \
    sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] \
    && echo "*"
}

parse_hg_branch() {
    hg branch 2>/dev/null | sed 's#\(.*\)#\1#'
}

get_branch_information() {
    branch=$(parse_hg_branch)
    if [ -n "$branch" ]; then
        scm='hg'
    else
        branch=$(parse_git_branch)
        [ -n "$branch" ] && scm='git'
    fi
    [ -n "$scm" ] && echo "($scm:$branch)"
}

export PS1="$txtblu\u@\h$txtrst:$txtcyn\w$txtgrn\$(get_branch_information)$txtrst\$ "

### Dircolors ##################################################################

if which dircolors > /dev/null; then
  eval $(dircolors -b $HOME/.dir_colors)
fi

### Pyenv ######################################################################

if [ -d "$HOME/.pyenv" ]; then
  pyenv_path="$HOME/.pyenv/bin"
  export PATH="$pyenv_path:$PATH"
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)";
  fi
fi

### Rbenv ######################################################################

if [ -d "$HOME/.rbenv" ]; then
  rbenv_path="$HOME/.rbenv/bin"
  export PATH="$rbenv_path:$PATH"
  eval "$(rbenv init -)"
fi

### OWN JARS TO CLASSPATH ######################################################

jars_path="$HOME/jars"
if [ -d "$jars_path" ]; then
  export CLASSPATH=$(find "$jars_path" -name '*.jar' | xargs echo | tr ' ' ':')
fi

### Prefer home prefixed binaries #############################################

export PATH="$HOME/local/bin:$PATH"

### Load other configs #########################################################

[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
[ -f "$HOME/.bash_local" ] && . "$HOME/.bash_local"
