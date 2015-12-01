### .zshrc

### Oh My Zsh ##################################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment to Oh My Zsh Automatically upgrade itself without prompting
# DISABLE_UPDATE_PROMPT=true

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# I am using thefuck for corrections so this is uncommented.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS='dd.mm.yyyy'

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which Oh My Zsh plugins to load.
# Add wisely, too many plugins slow down startup.
plugins=(gem git git-extras npm pip python vagrant)

### Theme ######################################################################

# name of the theme to load in ~/.oh-my-zsh/themes/ or $ZSH_CUSTOM/themes/
ZSH_THEME='bullet-train'

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
BULLETTRAIN_NVM_SHOW='true'
BULLETTRAIN_NVM_BG='green'
BULLETTRAIN_NVM_FG='black'

### pyenv
BULLETTRAIN_VIRTUALENV_SHOW='true'
BULLETTRAIN_VIRTUALENV_BG='yellow'
BULLETTRAIN_VIRTUALENV_FG='black'

### Shortcut to reload configs #################################################

alias s=". \"$HOME\"/.zshrc"

### Load other configs #########################################################

[ -f "$ZSH/oh-my-zsh.sh" ] && . "$ZSH/oh-my-zsh.sh"
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.zsh_local" ] && . "$HOME/.zsh_local" || true
