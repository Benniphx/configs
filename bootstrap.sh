#!/usr/bin/env bash

# This script symlinks the configs to the $HOME.
# Run with -f to override the exising files at $HOME without confirmation.

# On Windows (Vista and newer), Sublime Text configs can be symlinked by
# opening a PowerShell as an administrator and running the following commands:
#
#   1. cd "$env:appdata\Sublime Text 2\Packages\"
#   2. rmdir -recurse User
#   3. cmd /c mklink /D User $env:userprofile\configs\sublime\User


SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
OS_IDENTIFIER="${OSTYPE//[0-9.]/}"


### Configuration ##############################################################

SUBLIME_VERSION=2       # 2 or 3
CONFIG_PATH="$SCRIPT_PATH/posix"
SUBLIME_CONFIG_PATH="$SCRIPT_PATH/sublime"

if [ "$OS_IDENTIFIER" == "darwin" ]; then
    # File names inside the CONFIG_PATH are enough
    DO_NOT_SYMLINK=(
      'fonts.conf'
    )

    sublime_user_path="$HOME/Library/Application Support/Sublime Text $SUBLIME_VERSION/Packages/User"
else
    sublime_user_path="$HOME/.config/sublime-text-$SUBLIME_VERSION/Packages/User"
fi


### Helpers ####################################################################

function in_array() {
    for e in "${@:2}"; do
        [[ "$e" = "$1" ]] && break;
    done;
}


### Main #######################################################################

while getopts 'f' OPTION; do
    case "$OPTION" in
        f)
            LN_OPTS='f'
            ;;
        *)
            exit 1
            ;;
    esac
done

# Configs
for source_file_name in `ls -A $CONFIG_PATH`; do
    if ( in_array "$source_file_name" "${DO_NOT_SYMLINK[@]}" ); then
        echo "   Ignoring: $source_file_name"
    else
        ln -snvi$LN_OPTS "$CONFIG_PATH/$source_file_name" "$HOME/$source_file_name"
    fi
done

# Sublime User packages and configuration
ln -snvi$LN_OPTS "$SUBLIME_CONFIG_PATH" "$sublime_user_path"

# Vim bundles as git submodules
pushd "$CONFIG_PATH" > /dev/null
git submodule --quiet update --init --recursive
popd > /dev/null

exit 0
