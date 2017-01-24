# asyrjasalo/configs

Note: Run `install_*.sh` `-f` to override the existing paths without confirmation (!)

## CLI only

    git clone git@github.com:asyrjasalo/configs.git && configs/install_cli.sh

## OS UI specific

    ./install_ui.sh

This installs Terminus fonts and XFCE configs (the latter on GNU/Linux only).

## Brew and apps

    ./install_apps.sh

This uses Homebrew on OS X and Linuxbrew on GNU/Linux.

## Brewed zsh and zplug

    ./install_zsh.sh

This also sets the brew installed `zsh` as the user's default shell.

## Sublime Text 3

    ./install_subl.sh

Using `-f` here will override the currently installed user packages.

### Windows

On Windows Vista and later, Sublime Text configs can be linked in administrator PowerShell:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
