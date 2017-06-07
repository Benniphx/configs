### .zshrc

alias r=". $HOME/.zshrc"

### Zplug ######################################################################

if [[ "$OSTYPE" = darwin* ]]; then
  export ZPLUG_HOME="/usr/local/opt/zplug"
else
  export ZPLUG_HOME="$HOME/.linuxbrew/opt/zplug"
fi

source "$ZPLUG_HOME/init.zsh"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "bobsoppe/zsh-ssh-agent", use:ssh-agent.zsh, from:github
zplug "zsh-users/zsh-syntax-highlighting"
zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:"*.zsh-theme"

zplug check || zplug install
zplug load

### History ####################################################################

# This is unset on some environments
HISTFILE="$HOME/.zsh_history"

# Increase sizes
HISTSIZE=10000
SAVEHIST=10000

# Share history between shells
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# Show timestamps in history
alias history='fc -El 1'

### Bullet-train settings ######################################################

# Make sure the prompt is able to be generated properly
setopt prompt_subst

BULLETTRAIN_PROMPT_ORDER=(
  context
  dir
  git
  hg
  go
  ruby
  virtualenv
  nvm
  custom
  status
  cmd_exec_time
)

# prompt
BULLETTRAIN_PROMPT_SEPARATE_LINE='true'
BULLETTRAIN_PROMPT_ADD_NEWLINE='false'

# status
BULLETTRAIN_STATUS_EXIT_SHOW='true'

# time
BULLETTRAIN_TIME_BG='black'
BULLETTRAIN_TIME_FG='white'

# context
BULLETTRAIN_CONTEXT_SHOW='true'
BULLETTRAIN_CONTEXT_DEFAULT_USER='asyrjasalo'

# rbenv
BULLETTRAIN_RUBY_SHOW='true'
BULLETTRAIN_RUBY_BG='magenta'
BULLETTRAIN_RUBY_FG='black'

# dir
BULLETTRAIN_DIR_BG='black'
BULLETTRAIN_DIR_FG='white'
BULLETTRAIN_DIR_EXTENDED='0'

# git
BULLETTRAIN_GIT_BG='white'
BULLETTRAIN_GIT_FG='black'
BULLETTRAIN_GIT_COLORIZE_DIRTY='true'
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR='white'
BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR='red'

### node.js nvm
BULLETTRAIN_NVM_SHOW='true'
BULLETTRAIN_NVM_BG='green'
BULLETTRAIN_NVM_FG='black'

### pyenv
BULLETTRAIN_VIRTUALENV_SHOW='true'
BULLETTRAIN_VIRTUALENV_BG='yellow'
BULLETTRAIN_VIRTUALENV_FG='black'

### mercurial
BULLETTRAIN_HG_SHOW='true'

### command execution time
BULLETTRAIN_EXEC_TIME_SHOW='true'
BULLETTRAIN_EXEC_TIME_ELAPSED=5
BULLETTRAIN_EXEC_TIME_BG='cyan'
BULLETTRAIN_EXEC_TIME_FG='black'

### Automatically list contents when changing directory ########################

function chpwd() {
  ls -a --color=auto --group-directories-first
}

### Disable stop (^S) and continue (^Q) flow control signals ###################

stty -ixon

### Use emacs keymap ###########################################################

bindkey -e

### aws-cli completions #################################################

if which brew >/dev/null; then
  if [[ -e "$(brew --prefix)/bin/aws_zsh_completer.sh" ]] ; then
    . "$(brew --prefix)/bin/aws_zsh_completer.sh"
  fi
fi

### awless completion ##########################################################

export PATH="$HOME/.local/bin:$PATH"
source <(awless completion zsh)

### Load other configs #########################################################

[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -f "$HOME/.aliases" ]] && . "$HOME/.aliases"
[[ -f "$HOME/.fzf.zsh" ]] && . "$HOME/.fzf.zsh"
[[ -f "$HOME/.rclocal" ]] && . "$HOME/.rclocal"

### Load iTerm2 shell addons ###################################################

iterm2_addons="$HOME/.iterm2_shell_integration.zsh"
[[ -e "$iterm2_addons" ]] && . "$iterm2_addons"

#### Restore tmux ##############################################################

[[ -n "$TMUX" ]] || tmux attach -d -t "local" || tmux new -s "local"
