#!/usr/bin/env zsh

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
  cd $(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)');
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* *;
    fi;
}
