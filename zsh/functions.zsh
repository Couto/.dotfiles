#!/bin/zsh

red='\e[00;31m';
green='\e[00;32m';
cyan='\e[00;36m';
nc='\e[00m';

arrow_up="⬆";
arrow_down="⬇";
arrow_left="⬅";
arrow_right="➡";
cross="❌ ";
check="✔";

# Query postgresq directly
function q() {
    psql -h localhost -U postgres -d musicphotos -c $@;
}

# Query isitup.org to check if given url is online
# is-up 15minuteslate.net
is-up () {
    local url="$1";
    local uastring="BASH/cURL";
    local status_code=$(curl -s -A "$uastring" "http://isitup.org/$url.json" | python -mjson.tool | grep 'status_code' | grep -o "\d")

    case $status_code in
    "1")
        echo -e "$green $arrow_up $nc Website is alive.";
        ;;
    "2")
        echo -e "$red $arrow_down $nc Website appears down.";
        ;;
    "3")
        echo -e "$red $cross $nc Domain was not valid.";
        ;;
    *)
        echo -e "$red $cross $nc Something really wrong happened...";
        ;;
    esac
}

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
    local tmpFile="${@%/}.tar";

    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

    size=$(
        stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
        stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
    );

    local cmd="";
    if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli";
    else
        if hash pigz 2> /dev/null; then
            cmd="pigz";
        else
            cmd="gzip";
        fi;
    fi;

    echo "Compressing .tar using \`${cmd}\`…";
    "${cmd}" -v "${tmpFile}" || return 1;
    [ -f "${tmpFile}" ] && rm "${tmpFile}";
    echo "${tmpFile}.gz created successfully.";
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

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1");
    local gzipsize=$(gzip -c "$1" | wc -c);
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
    printf "orig: %d bytes\n" "$origsize";
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Run `dig` and display the most useful info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

# List blocked domains matching the given domain
function list-blocked() {
    local domain="$1";
    local domain_list="$DOTFILES/dnsmasq/adblock.list"

    if [ -f "$domain_list" ]; then
        grep $domain $domain_list
    fi
}

function brew-add() {
    local brewfile="$DOTFILES/homebrew/Brewfile";

    for package in "$@"; do
        echo "install $package" >> "$brewfile";
    done

    brew bundle "$brewfile";
}

function cask-add() {
    local brewfile="$DOTFILES/homebrew/Caskfile";

    for package in "$@"; do
        echo "cask install $package" >> "$brewfile";
    done

    brew bundle "$brewfile";
}

function foundry-add() {
    local brewfile="$DOTFILES/homebrew/Foundryfile";

    for package in "$@"; do
        echo "cask install $package" >> "$brewfile";
    done

    brew bundle "$brewfile";
}

function git-repository-url() {
    git --git-dir=${PWD}/.git config --get remote.origin.url
}

function git-repository-shorturl() {
    git-repository-url | grep -o ':.*/.*.git' | grep -o '[a-zA-Z0-9_-]*/[a-zA-Z0-9_-]*' | uniq
}
