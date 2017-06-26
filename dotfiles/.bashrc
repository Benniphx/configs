### .bashrc

# quit if shell not interactive
[[ -z "$PS1" ]] && return

alias r=". $HOME/.bashrc"

### Bash builtins ##############################################################

# have Bash to check if the window size has changed
shopt -s checkwinsize

# autocorrect typos in path names when using `cd`
shopt -s cdspell

### History ####################################################################

# append to the history file instead of overwriting it
shopt -s histappend

# combine multiline commands into one in history
shopt -s cmdhist

# configure history
HISTFILE="$HOME/.bash_history"
HISTFILESIZE=10000
HISTSIZE=10000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:cd:bg:fg:history:pwd:exit:date:s'
HISTTIMEFORMAT='%d.%m.%Y %H:%M  '

# save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -c; history -r;"

### Additional bash completions ################################################

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

# add tab completion for hostnames based on ~/.ssh/config, ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o 'default' -o 'nospace' \
  -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" \
    | cut -d ' ' -f2 | tr ' ' '\n')" scp sftp ssh

### awless completion ##########################################################

export PATH="$HOME/.local/bin:$PATH"
if which awless >/dev/null; then
  source <(awless completion bash)
fi

### Prompt #####################################################################

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
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

parse_hg_branch() {
  hg branch 2>/dev/null | sed 's#\(.*\)#\1#'
}

get_branch_info() {
  local branch=$(parse_git_branch)
  local scm=''
  if [[ -n "$branch" ]]; then
    scm='git'
  else
    branch=$(parse_git_branch)
    [[ -n "$branch" ]] && scm='hg'
  fi
  [[ -n "$scm" ]] && echo "($scm:$branch)"
}

export PS1="$txtblu\u@\h$txtrst:$txtcyn\w$txtgrn\$(get_branch_info)$txtrst\$ "

### Moving around ##############################################################

alias cd..='cd ..'  # a common typo
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

### disable stop (^S) and continue (^Q) signals ################################

stty -ixon

### Load other configs #########################################################

[[ -f "$HOME/.profile" ]]  && . "$HOME/.profile"
[[ -f "$HOME/.aliases" ]]  && . "$HOME/.aliases"
[[ -f "$HOME/.fzf.bash" ]] && . "$HOME/.fzf.bash"
[[ -f "$HOME/.rclocal" ]]  && . "$HOME/.rclocal" || true
