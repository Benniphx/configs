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

if [[ "$OSTYPE" = darwin* ]]; then
  # prepend homebrew installed binaries to path
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

  if which brew >/dev/null; then
    coreutils_bin_path="$(brew --prefix coreutils)/libexec/gnubin"
    [[ -d "$coreutils_bin_path" ]] && export PATH="$coreutils_bin_path:$PATH"

    findutils_bin_path="$(brew --prefix findutils)/libexec/gnubin"
    [[ -d "$findutils_bin_path" ]] && export PATH="$findutils_bin_path:$PATH"
  fi

  if brew command command-not-found-init > /dev/null 2>&1; then
    eval "$(brew command-not-found-init)";
  fi
else
  export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"

  if which brew >/dev/null; then
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
    export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
  fi
fi

### Nvm ########################################################################

export NVM_DIR="$HOME/.nvm"
[[ ! -d "$NVM_DIR" ]] && mkdir -p "$NVM_DIR"
. "$(brew --prefix nvm)/nvm.sh"

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

### Fasd #######################################################################

if which fasd >/dev/null; then
  eval "$(fasd --init auto)"
fi

### Fzf ########################################################################

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

### SCM puff ###################################################################

which scmpuff >/dev/null && eval "$(scmpuff init -s)"


### Dircolors ##################################################################

which dircolors >/dev/null && eval "$(dircolors -b "$HOME"/.dir_colors)"

### Thefuck ####################################################################

which thefuck >/dev/null && eval "$(thefuck --alias)"
