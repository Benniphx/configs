#!/bin/bash

# This script symlinks the configuration files to the home directory.
#
# WARNING: Using command-line argument -f replaces the files/directories
#          with same-named symlinks at the user's $HOME.
#
# On Windows (Vista and newer), Sublime Text configs can be symlinked by
# opening a PowerShell as an administrator and running the following commands:
#
#   1. cd "$env:appdata\Sublime Text 2\Packages\"
#   2. rmdir -recurse User
#   3. cmd /c mklink /D User $env:userprofile\configs\sublime\User

### CONFIGURATION ##############################################################

# Subdirectory name for Linux/OS X configs
POSIX_CONFIG_DIR_NAME='posix'

# Subdirectory name for the Sublime Text configs
SUBLIME_CONFIG_DIR_NAME='sublime'

# Sublime Text major version number (2 or 3)
SUBLIME_VERSION=2

# Add files that should not be symlinked to the array below.
DO_NOT_SYMLINK=(
  'do_not_want.sh'
)

### NO NEED TO EDIT BELOW ######################################################

OS_IDENTIFIER=${OSTYPE//[0-9.]/}

THIS_DIR=`dirname "${BASH_SOURCE}"`
CONFIG_DIR=`cd $THIS_DIR/$POSIX_CONFIG_DIR_NAME && pwd`
SUBLIME_CONFIG_DIR=`cd $THIS_DIR/$SUBLIME_CONFIG_DIR_NAME && pwd`

skip_or_create_symlink() {
    symlink_path="$2/$1"
    if [[ -h "$symlink_path" ]] || [[ -e "$symlink_path" ]] && [[ $force != 1 ]]; then
        echo "   Skipping: $1 (already exists, use -f to override)"
        return
    fi
    if [[ -h "$symlink_path" ]] || [[ -e "$symlink_path" ]] && [[ $force == 1 ]]; then
        rm -rf "$symlink_path"
    fi
    echo "   Symlinking: $3/$1 -> $symlink_path"
    ln -s "$3/$1" "$2"
}

in_array() {
    for e in "${@:2}"; do
        [[ "$e" = "$1" ]] && break;
    done;
}

while getopts 'f' OPTION; do
    case "$OPTION" in
        f)
            force=1
        ;;
        *)
            exit 1
        ;;
    esac
done

# Sublime Text configs
echo "-> Initializing Sublime Text $SUBLIME_VERSION configs and packages"
if [[ "$OS_IDENTIFIER" == 'darwin' ]]; then
    destination="$HOME/Library/Application Support/Sublime Text $SUBLIME_VERSION/Packages"
else
    destination="$HOME/.config/sublime-text-$SUBLIME_VERSION/Packages"
fi
skip_or_create_symlink 'User' "$destination" "$SUBLIME_CONFIG_DIR"

# POSIX configs
echo '-> Updating config files'
for source_file in `ls -A $CONFIG_DIR`; do
    if ( in_array "$source_file" "${DO_NOT_SYMLINK[@]}" ); then
        echo "   Ignoring: $source_file"
    else
        skip_or_create_symlink "$source_file" "$HOME" "$CONFIG_DIR"
    fi
done

OLDWD="$PWD"
cd "$THIS_DIR"

# vim bundles
echo '-> Initializing vim bundles'
git submodule --quiet update --init --recursive

echo "-> Updating vim bundles"
git submodule --quiet foreach git pull -q origin master

cd "$OLDWD"
