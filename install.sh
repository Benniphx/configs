#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
config_path="$script_path/common"
sublime_config_path="$script_path/sublime"

# Do not symlink these paths. Paths are relative to config_path.
do_not_symlink=(
    ".irssi"
)

### Helpers ####################################################################

function in_array() {
    local e
    for e in "${@:2}"; do
        [ "$e" == "$1" ] && return 0;
    done
    return 1
}

### Parse arguments ############################################################

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

### Symlink configs ############################################################

if [ `uname` = 'Darwin' ]; then
    sublime_user_path="$HOME/Library/Application Support/Sublime Text $sublime_version/Packages/User"
else
    sublime_user_path="$HOME/.config/sublime-text-$sublime_version/Packages/User"
fi

for source_file_name in `ls -A $config_path`; do
    if (in_array "$source_file_name" "${do_not_symlink[@]}"); then
        echo "Ignoring: $source_file_name"
    else
        ln -snvi"$ln_args" "$config_path/$source_file_name" "$HOME/$source_file_name"
    fi
done

### Symlink Sublime User configuration #########################################

ln -snvi"$ln_args" "$sublime_config_path" "$sublime_user_path"

### Install vim bundles as git submodules ######################################

pushd "$config_path" > /dev/null
git submodule update --init --depth 1 --recursive
popd > /dev/null

### Install fonts ##############################################################

"$script_path/fonts/install.sh"

### Install autojump ###########################################################

pushd "$script_path/extras/autojump" >/dev/null
    ./install.py 1>/dev/null
popd >/dev/null

### Symlink ZSH theme ##########################################################

mkdir -p "$config_path/.oh-my-zsh/custom/themes"
ln -snvi"$ln_args" "$script_path/zsh-extras/bullet-train-oh-my-zsh-theme/bullet-train.zsh-theme" \
    "$config_path/.oh-my-zsh/custom/themes/bullet-train.zsh-theme"

### Set default shell ##########################################################

if [ `uname` = 'Darwin' ]; then
    default_shell=$(dscl . -read "$HOME" UserShell)
else
    default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
fi

case $(echo "$default_shell") in
    */zsh)
        echo "ZSH already set to the default shell."
        ;;
    *)
        echo ""
        read -p "Set ZSH as the user's default shell [y\N] > " -r set_zsh
        case "$set_zsh" in
            [yY][eE][sS]|[yY])
                echo "Setting the user's shell to ZSH. Sudo password might be asked."
                chsh -s /bin/zsh
                ;;
        esac
        ;;
esac
