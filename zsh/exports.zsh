#!/bin/zsh

# Path
export PATH=$DOTFILES/bin:/usr/local/bin:/usr/local/sbin:$PATH;

# Fix locales
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Editors
export ATOM_PATH="/opt/homebrew-cask/Caskroom/atom/latest/"
export ATOM="$ATOM_PATH/Atom.app"
export EDITOR=$(which vim)
export VISUAL="$(which vim)"

# Configurations
export NVM_DIR=$HOME/.nvm

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";
