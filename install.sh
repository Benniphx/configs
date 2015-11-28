#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
dotfiles_path="$script_path/dotfiles"
sublime_dotfiles_path="$script_path/sublime"

# Do not symlink these paths. Paths are relative to dotfiles_path.
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

for source_file_name in `ls -A $dotfiles_path`; do
    if (in_array "$source_file_name" "${do_not_symlink[@]}"); then
        echo "Ignoring: $source_file_name"
    else
        ln -snvi"$ln_args" "$dotfiles_path/$source_file_name" "$HOME/$source_file_name"
    fi
done

### Symlink Sublime User configuration #########################################

ln -snvi"$ln_args" "$sublime_dotfiles_path" "$sublime_user_path"

### Install vim bundles as git submodules ######################################

pushd "$dotfiles_path" > /dev/null
git submodule update --init --depth 1 --recursive
popd > /dev/null

### Install fonts ##############################################################

"$script_path/fonts/install.sh"

### Install autojump ###########################################################

pushd "$script_path/extras/autojump" >/dev/null
    ./install.py 1>/dev/null
popd >/dev/null

### Symlink Tmux plugin manager ################################################

mkdir -p "$HOME/.tpm/plugins"
ln -snvi"$ln_args" "$script_path/extras/tpm" "$HOME/.tpm/plugins/tpm"

### Symlink ZSH theme ##########################################################

mkdir -p "$dotfiles_path/.oh-my-zsh/custom/themes"
ln -snvi"$ln_args" "$script_path/zsh-extras/bullet-train-oh-my-zsh-theme/bullet-train.zsh-theme" \
    "$dotfiles_path/.oh-my-zsh/custom/themes/bullet-train.zsh-theme"

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
