# asyrjasalo/configs

Install CLI features only:

    git clone git@github.com:asyrjasalo/configs.git && configs/install_cli.sh

To also install Terminus fonts and XFCE configs (the latter on GNU/Linux only):

    install_ui.sh

To also install brew and apps:

    install_apps.sh

To also set brew installed zsh as the user's default shell:

    install_zsh.sh

Any `install_*` with `-f` to override the existing paths without prompting.


## Sublime Text

### OS X and Linux distros

    install_subl.sh

With `-f` to override the currently installed user packages.


### Windows

On Windows Vista and later, Sublime Text configs can be linked in administrator PowerShell:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
