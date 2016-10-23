### .zshrc

### Zplug ######################################################################

# Homebrew/Linuxbrew: brew install zplug
export ZPLUG_HOME='/usr/local/opt/zplug'
source "$ZPLUG_HOME/init.zsh"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:"*.zsh-theme"

zplug check || zplug install
zplug load

### Bullet-train settings ######################################################

# Make sure the prompt is able to be generated properly
setopt prompt_subst

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
BULLETTRAIN_DIR_BG='blue'
BULLETTRAIN_DIR_FG='white'
BULLETTRAIN_DIR_EXTENDED='1'

# git
BULLETTRAIN_GIT_BG='white'
BULLETTRAIN_GIT_FG='black'

### node.js nvm
BULLETTRAIN_NVM_SHOW='false'
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
  ls --color=auto -ahlF --group-directories-first
}

### Shortcut to reload config ##################################################

alias s=". \"$HOME\"/.zshrc"

### disable stop (^S) and continue (^Q) flow control signals ###################

stty -ixon

### Load iTerm2 shell addons ###################################################

iterm2_addons="$HOME/.iterm2_shell_integration.zsh"
[[ -e "$iterm2_addons" ]] && . "$iterm2_addons"

### Load other configs #########################################################

[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -f "$HOME/.zshrc_local" ]] && . "$HOME/.zshrc_local" || true
