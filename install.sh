#!/usr/bin/env bash

# This script symlinks the configs to $HOME. It also initializes the vim bundles.
# Run with -f to override the exising files/symlinks at $HOME without confirmation.

# On Windows (Vista and newer), Sublime Text configs can be kind of symlinked by
# opening a PowerShell as an administrator and running the following commands:
#
# cd "$env:appdata\Sublime Text 3\Packages\"
# rmdir -recurse User
# cmd /c mklink /D User $env:userprofile\configs\sublime

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
config_path="$script_path/common"
sublime_config_path="$script_path/sublime"

# Do not symlink these paths. Paths are relative to config_path.
do_not_symlink=()

### Helpers ####################################################################

function in_array() {
    local e
    for e in "${@:2}"; do
        [ "$e" == "$1" ] && return 0;
    done
    return 1
}

### Main #######################################################################

while getopts 'f' arg; do
    case "$arg" in
        f)
            ln_args='f'
            ;;
        *)
            exit 1
            ;;
    esac
done

if [ `uname` = 'Darwin' ]; then
    sublime_user_path="$HOME/Library/Application Support/Sublime Text $sublime_version/Packages/User"
else
    sublime_user_path="$HOME/.config/sublime-text-$sublime_version/Packages/User"
fi

# Symlink configs
for source_file_name in `ls -A $config_path`; do
    if (in_array "$source_file_name" "${do_not_symlink[@]}"); then
        echo "Ignoring: $source_file_name"
    else
        ln -snvi"$ln_args" "$config_path/$source_file_name" "$HOME/$source_file_name"
    fi
done

# Symlink Sublime User configuration
ln -snvi"$ln_args" "$sublime_config_path" "$sublime_user_path"

# Symlink ZSH theme
ln -snvi"$ln_args" "$script_path/zsh-extras/bullet-train-oh-my-zsh-theme/bullet-train.zsh-theme" \
    "$config_path/.oh-my-zsh/themes/bullet-train.zsh-theme"

# Vim bundles as git submodules
pushd "$config_path" > /dev/null
git submodule update --depth 1 --init --recursive
popd > /dev/null
