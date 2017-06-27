# asyrjasalo/configs

TL;DR:

    git clone git@github.com:asyrjasalo/configs.git && configs/install_cli.sh

Note: Run `install_*.sh` `-f` to override the existing paths without confirmation (!)

## CLI

### Symlink dotfiles and local bins

    ./install_cli.sh

### Command-line brew apps

    ./install_apps.sh

This also installs Homebrew on OS X and Linuxbrew on GNU/Linux.

### Devenv

    ./install_devenv.sh

Includes `rbenv`, `pyenv`, `nvm` and AWS CLI tools.

### Neovim

    ./install_nvim.sh

This also installs and updates Vim plugins using Vundle.

## Shell

### Brewed zsh and zplug

    ./install_zsh.sh

This also sets the brew installed `zsh` as the user's default shell.

### Brewed bash and bash-completion

    ./install_bash.sh

This also sets the brew installed `bash` as the user's default shell.

## GUI

### Fonts and GUI configs

    ./install_gui.sh

This installs fonts and XFCE configs (the latter on GNU/Linux only).

### Sublime Text 3

    ./install_subl.sh

Using `-f` here will override the currently installed user packages.

## Windows

Prefer Windows Subsystem for Linux (on Windows 10) if possible - some of the Linuxbrew formulas actually work even on msys bundled with Git for Windows.

### Sublime Text 3

On Windows Vista and later, Sublime Text configs can be linked in administrator PowerShell:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
