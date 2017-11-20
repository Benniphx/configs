### .profile

### Exports ####################################################################

export LANG='en_US.UTF-8'
export LANGUAGE='en_US-UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='nvim'
export VISUAL="$EDITOR"
export SVN_EDITOR="$EDITOR"

if [[ "$COLORTERM" == "xfce4-terminal" ]]; then
  export TERM=xterm-256color
fi

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

### Go #########################################################################

go_path="$HOME/go"
if [[ -d "$go_path" ]]; then
  export GOPATH="$go_path"
  export PATH="$go_path/bin:$PATH"
fi

### Nvm ########################################################################

nvm_path="$HOME/.nvm"
if [[ -d "$nvm_path" ]]; then
  export NVM_DIR="$nvm_path"
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

### Rbenv ######################################################################

rbenv_path="$HOME/.rbenv"
if [[ -x "$rbenv_path/bin/rbenv" ]]; then
  export PATH="$rbenv_path/bin:$PATH"
  eval "$(rbenv init -)"
fi

### Pyenv ######################################################################

pyenv_path="$HOME/.pyenv"
if [[ -d "$pyenv_path" ]]; then
  export PATH="$pyenv_path/bin:$PATH"
  eval "$(pyenv init -)"
  if [[ -d "$pyenv_path/plugins/pyenv-virtualenv" ]] ; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv virtualenv-init -)"
  fi
fi

### Java #######################################################################

export JAVA_8_HOME="$(/usr/libexec/java_home -v1.8 &>/dev/null)"
[[ -n "$JAVA_8_HOME" ]] && alias java8='export JAVA_HOME=$JAVA_8_HOME' && java8

export JAVA_9_HOME="$(/usr/libexec/java_home -v9 &>/dev/null)"
[[ -n "$JAVA_9_HOME" ]] && alias java9='export JAVA_HOME=$JAVA_9_HOME'

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

### oc-cluster-wrapper #########################################################

ocw_path="$HOME/oc-cluster-wrapper"
[[ -d "$ocw_path" ]] && export PATH="$ocw_path:$PATH"

### android-ndk ###############################################################

android_ndk_path="/usr/local/share/android-ndk"
[[ -d "$android_ndk_path" ]] && export ANDROID_NDK_HOME="$android_ndk_path"
