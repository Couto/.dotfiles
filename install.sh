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
    sleep 1;
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
            Yes ) return 0; exit;;
            No ) return 1; exit;;
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

osx_version () {
    echo "$(sw_vers -productVersion)";
}

is_mavericks () {
    local version=$(osx_version);
    if [[  $version =~ ^[0-9]+\.([0-9]+) ]]; then
        local middle=${BASH_REMATCH[1]};
        if [ $middle -eq "9" ]; then
            return 0;
        else
            return 1;
        fi
    fi
}

has_command_line_tools () {
    if [[ is_mavericks ]]; then
        #local dev_dir=$(/usr/bin/xcode-select -print-path 2>/dev/null);
        return 1;
    fi
}


install_command_line_tools () {
    info "Will now attempt to install Command Line Tools (expect a GUI popup):"
    sudo "$(which xcode-select)" --install
    ask "Press any key when the installation has completed."
    if [[ ! has_command_line_tools ]]; then
        abort "Please install Command Line Tools and then try again";
    fi
}




# Ask the user if they want to continue
# even if the computer is not a Mac
# this is risky since I'm not testing on linux.
[[ $(uname -s) != "Darwin" ]] && (prompt "

  This is not an OSX machine.
  The following script was only tested on OSX Mavericks.

  Do you still want to proceed at your own risk?

" || exit);

# Inform the user that although they are using OSX
# I only tested on mavericks
is_mavericks || (prompt "

  Although this is an OSX machine, the following script
  was only tested on Mavericks.

  Do you still want to proceed at your own risk?

" || exit);

# Check if the command line tools are installed
# Try to install them, if not.
[[ has_command_line_tools ]] && install_command_line_tools;

# Ask the user if they want to change some defaults
DOTFILES_DIRECTORY=$(ask_default "Select the destination directory" $DOTFILES_DIRECTORY);


#github $DOTFILES_REPOSITORY $DOTFILES_DIRECTORY;
