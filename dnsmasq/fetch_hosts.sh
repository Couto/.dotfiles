#!/bin/bash

# Unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'
# set -x

tmp_file () {
    local template="$(basename $0)";
    mktemp -t "$template";
}

download_file () {
    local output=$2;
    local url=$1

    curl -fsS -o "$output" "$url";
}

clean_file () { 
    grep "0.0.0.0\|127.0.0.1" "$1" | awk '{ print "0.0.0.0\t"$2 }' | sed 's///g' >> "$2"
}

fetch_host () {
    local host="$1";
    local output_file="$2";
    local tmp="$(tmp_file)";

    download_file "$host" "$tmp";
    clean_file "$tmp" "$output_file"

    echo -e "Fetched: $host";
}

main () { 
    local ADBLOCK_FILE="adblock.list";
    local TMP_FILE=$(tmp_file);
    local HOSTS_FILES=(
        "http://sysctl.org/cameleon/hosts"
        "https://jansal.googlecode.com/svn/trunk/adblock/hosts"
        # "http://optimate.dl.sourceforge.net/project/adzhosts/HOSTS.txt"
        "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0"
        "https://adaway.org/hosts.txt"
        "http://hosts-file.net/ad_servers.txt"
        "http://www.malwaredomainlist.com/hostslist/hosts.txt"
    );

    for host in "${HOSTS_FILES[@]}";
    do
        fetch_host "$host" "$TMP_FILE" &
    done;
    wait

    tr '[A-Z]' '[a-z]' < "$TMP_FILE" | sort -f | uniq > $ADBLOCK_FILE;
    echo -e "Deduped: $ADBLOCK_FILE";
}

main;
