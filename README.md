# asyrjasalo/configs

TL;DR:

    git clone git@github.com:asyrjasalo/configs.git && configs/symlink_dotfiles.sh

Run `symlink_dotfiles.sh` with `-f` to override the existing paths without prompting (!)

## Goodies

### Brew and brew cask apps

    ./install_apps.sh

Uses Homebrew and Cask on OS X, and Linuxbrew on GNU/Linux.

### Brewed zsh and zplug

    ./install_zsh.sh

This prompts to set (the brewed) `zsh` as the user's default shell.

### Brewed bash and bash-completion

    ./install_bash.sh

This prompt to set (the brewed) `bash` as the user's default shell.

### Fonts

    ./install_fonts.sh

### Neovim

    ./install_nvim.sh

Installs Neovim and Vundle, and updates the (Neo)vim plugins.

### Sublime Text 3

    ./install_subl.sh

Using `-f` will override the currently installed user packages.

### Devenv

    ./install_devenv.sh

Installs `rbenv`, `pyenv`, `nvm` and some AWS CLI tools.

## Windows

Prefer Windows Subsystem for Linux (on Windows 10) if possible - some of the Linuxbrew formulas actually work even on msys bundled with Git for Windows.

### Sublime Text 3

On Windows Vista and later, Sublime Text configs can be linked in administrator PowerShell:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
