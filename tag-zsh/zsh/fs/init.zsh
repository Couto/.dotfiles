#!/usr/bin/env zsh

# File System configurations and aliases

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

CWD="$(dirname ${(%):-%x})";
source "${CWD}/aliases.zsh";
source "${CWD}/functions.zsh";

