#!/usr/local/bin/zsh

# Quick shortcuts
export HOME=/Users/couto;
export DOTFILES=${HOME}/.dotfiles

# Path
typeset -U path
path=(
    $DOTFILES/bin
    $(brew --prefix)/opt/coreutils/libexec/gnubin
    /usr/local/bin
    /usr/local/sbin
    $path
);

# rbenv, pyenv, nvm and the likes
source "$(brew --prefix nvm)/nvm.sh"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Manpages
export MANPATH=$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH;

# Fix locales
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Antigen
export ADOTDIR=$DOTFILES/.antigen

# Editors
export ATOM_PATH="/opt/homebrew-cask/Caskroom/atom/latest"
export ATOM="$ATOM_PATH/Atom.app"
export EDITOR=$(which vim)
export VISUAL="$(which vim)"

# Configurations
export NVM_DIR=$HOME/.nvm

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/couto/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

if [[ -n ${TMUX}  ]]; then
    consolidate-path
fi
