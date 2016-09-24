# asyrjasalo/configs

Run this:

    git clone git@github.com:asyrjasalo/configs.git && configs/install.sh

Run `install.sh` with `-f` to override the existing paths without prompting.


## Sublime Text

### OS X / Linux distros

Run `sublime.sh` with `-f` to override the currently installed user packages.


### Windows

On Windows Vista and later, Sublime Text configs can be linked in administrator PowerShell:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
