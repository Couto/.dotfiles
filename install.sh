#!/bin/bash


# Set default values
DOTFILES_REPOSITORY="Couto/.dotfiles"
DOTFILES_DIRECTORY=$HOME/_dotfiles


set -e;

# Colors
red='\x1B[0;31m';
green='\x1B[0;32m';
cyan='\x1B[0;36m';
gray='\x1B[0;30m';
NC='\x1B[0m';
clear='\033[0K'

# Unicode characters
unicode_empty_circle=○;
unicode_full_circle=●;
unicode_crossed_circle=⊘;
unicode_x_mark=✖;
unicode_check_mark=✔;
unicode_right_arrow=➔;


# Status indicators
abort () {
    echo "";
    echo -e " ${red}${unicode_x_mark}${NC} $@";
    echo "";
    exit 1;
}

info () {
    echo -e " ${cyan}${unicode_right_arrow}${NC} $@";
}

success () {
    echo -e " ${green}${unicode_check_mark}${NC} $@";
}

# Line status indicators
# These will always be replaced by the next line
linfo () {
    echo -ne "${clear}";
    echo -ne " ${cyan}${unicode_empty_circle}${NC} $@\r";
}

lfail () {
    echo -ne "${clear}";
    echo -ne " ${red}${unicode_crossed_circle}${NC} $@\r"
}

lsuccess () {
    echo -ne "${clear}";
    echo -ne " ${green}${unicode_full_circle}${NC} $@\r";
}


prompt () {
    echo "$@";
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) return 1; exit;;
            No ) return 0; exit;;
        esac
    done
}

ask () {
    read  -p "$@ : " answer;
    echo $answer;
}

ask_default () {
    local question="$1";
    local default_val="$2";
    answer=$(ask "$1 [$2]");

    if [ -z "$answer" ]; then
        echo $default_val;
    else
        echo $answer;
    fi
}

git_clone () {
    local repository="$1";
    local destination="$2";

    if [[ -d "$destination" ]]; then
		abort "Directory $destination already exists, aborting..."
    fi

    git clone --quiet --depth 1 "$repository" "$destination";
}

github () {
    local repository="$1";
    local destination="$2";

    linfo "Cloning $1";
    git_clone "git@github.com:$repository.git" "$destination" || abort "Failed."
    lsuccess "Cloned dotfiles"
}

# Ask the user if they want to continue
# even if the computer is not a Mac
# this is risky since I'm not testing on linux.
[[ $(uname -s) != "Darwin" ]] && prompt "

  This is not an OSX machine.
  The following script was only tested on OSX Maverick.

  Do you still want to proceed at your own risk?

" && exit;

# Ask the user if they want to change some defaults
DOTFILES_DIRECTORY=$(ask_default "Select the destination directory" $DOTFILES_DIRECTORY);

github $DOTFILES_REPOSITORY $DOTFILES_DIRECTORY;
