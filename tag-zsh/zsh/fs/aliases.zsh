#!/usr/bin/env zsh

# Because typing `cd ..` is a lot of work
alias ..='cd ..';
alias ...='cd ../..';

# prompt before overwriting file
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias ln='ln -i'

# Display useful info and colors if possible
if [ "${TERM}" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    #eval `dircolors ~/.dir_colors`
fi

alias l='ls ${LS_OPTIONS} -lAhF'
