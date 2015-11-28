# asyrjasalo/configs

Run this:

    git clone git@github.com:asyrjasalo/configs.git && configs/install.sh

Run `install.sh` with `-f` to override the existing paths at without prompting.


## Sublime Text and Windows

On Windows (Vista and newer) Sublime Text configs can be kind of symlinked by
opening a PowerShell as an administrator and running the following commands:

```
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\configs\sublime
```
