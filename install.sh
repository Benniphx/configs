#!/usr/bin/env bash

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

### Configuration ##############################################################

sublime_version=3
dotfiles_path="$script_path/dotfiles"
sublime_dotfiles_path="$script_path/sublime"

# Do not symlink these paths. Paths are relative to $dotfiles_path.
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

function git_clone_or_pull {
    local url="$1"
    local target="$2"
    git -C "$target" pull --rebase 2>/dev/null || git clone --depth 1 "$url" "$target"
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

### Symlink dotfiles ###########################################################

for source_file_name in `ls -A $dotfiles_path`; do
    if (in_array "$source_file_name" "${do_not_symlink[@]}"); then
        echo "Ignoring: $source_file_name"
    else
        ln -snvi"$ln_args" "$dotfiles_path/$source_file_name" \
            "$HOME/$source_file_name"
    fi
done

### Symlink htoprc for Linux distributions #####################################

if [ `uname` != 'Darwin' ]; then
    mkdir -p "$HOME/.config/htop"
    ln -snvi"$ln_args" "$dotfiles_path/.htoprc" "$HOME/.config/htop/htoprc"
fi

### Symlink Sublime User configuration #########################################

if [ `uname` = 'Darwin' ]; then
    sublime_user_path="$HOME/Library/Application Support/Sublime Text $sublime_version/Packages/User"
else
    sublime_user_path="$HOME/.config/sublime-text-$sublime_version/Packages/User"
fi

ln -snvi"$ln_args" "$sublime_dotfiles_path" "$sublime_user_path"

### Install submodules if any ##################################################

pushd "$dotfiles_path" > /dev/null
git submodule update --init --depth 1 --recursive
popd > /dev/null

### Install Oh-My-Zsh ##########################################################

git_clone_or_pull https://github.com/robbyrussell/oh-my-zsh.git \
    "$HOME/.oh-my-zsh"

git_clone_or_pull https://github.com/caiogondim/bullet-train-oh-my-zsh-theme.git \
    "$HOME/.oh-my-zsh/custom/themes"

### Install fonts ##############################################################

"$script_path/fonts/install.sh"

### Install autojump ###########################################################

git_clone_or_pull git://github.com/joelthelion/autojump.git /tmp/autojump
pushd /tmp/autojump >/dev/null
./install.py 1>/dev/null
popd >/dev/null

### Install SCM Breeze #########################################################

git_clone_or_pull git://github.com/ndbroadbent/scm_breeze.git \
    "$HOME/.scm_breeze"
# "$HOME/.scm_breeze/install.sh"

### Install Tmux plugin manager ################################################

git_clone_or_pull https://github.com/tmux-plugins/tpm \
    "$HOME/.tmux/plugins/tpm"

### Install Vundle #############################################################

git_clone_or_pull https://github.com/VundleVim/Vundle.vim.git \
    "$HOME/.vim/bundle/Vundle.vim"
echo -ne '\n' | vim +PluginInstall +qall 2>/dev/null

### Symlink Neovim configs #####################################################
ln -s"$ln_args" "$HOME/.vim" "$HOME/.config/nvim"
ln -s"$ln_args" "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"

### Set default shell ##########################################################

if [ `uname` = 'Darwin' ]; then
    default_shell=$(dscl . -read "$HOME" UserShell)
else
    default_shell=$(getent passwd "$LOGNAME" | cut -d: -f7)
fi

case $(echo "$default_shell") in
    */zsh)
        echo "ZSH already set to the user's default shell."
        ;;
    *)
        echo ""
        read -p "Set ZSH as the user's default shell [y\N] > " -r set_zsh
        case "$set_zsh" in
            [yY][eE][sS]|[yY])
                echo "Sudo password might be asked."
                chsh -s /bin/zsh
                ;;
        esac
        ;;
esac
