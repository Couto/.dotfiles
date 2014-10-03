#!/bin/zsh

# Path
export PATH=$DOTFILES/bin:$(brew --prefix)/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH;

# Manpages
export MANPATH=$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH;

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
