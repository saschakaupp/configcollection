#!/bin/sh
set -eu

DOTFILES_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
VIM_PACKAGE_DIR="$HOME/.vim/pack/dotfiles/start"
CODEX_CONFIG_DIR="$HOME/.codex"

if ! command -v git >/dev/null 2>&1; then
    printf '%s\n' "git is required to install Vim plugins." >&2
    exit 1
fi

install_vim_plugin() {
    plugin_name=$1
    plugin_repo=$2
    plugin_dir="$VIM_PACKAGE_DIR/$plugin_name"

    if [ -d "$plugin_dir/.git" ]; then
        return
    fi

    if [ -e "$plugin_dir" ]; then
        printf 'Plugin path exists but is not a Git checkout: %s\n' "$plugin_dir" >&2
        return 1
    fi

    git clone --depth 1 "$plugin_repo" "$plugin_dir"
}

mkdir -p "$VIM_PACKAGE_DIR" "$CODEX_CONFIG_DIR"
install_vim_plugin nerdtree https://github.com/preservim/nerdtree.git
install_vim_plugin syntastic https://github.com/vim-syntastic/syntastic.git
install_vim_plugin vim-airline https://github.com/vim-airline/vim-airline.git
install_vim_plugin catppuccin https://github.com/catppuccin/vim.git
install_vim_plugin vim-polyglot https://github.com/sheerun/vim-polyglot.git
install_vim_plugin vim-fugitive https://github.com/tpope/vim-fugitive.git

cp "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"
cp "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
cp "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
cp "$DOTFILES_DIR/codex/AGENTS.md" "$CODEX_CONFIG_DIR/AGENTS.md"

