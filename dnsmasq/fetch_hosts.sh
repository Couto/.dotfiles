#!/usr/bin/env bash

# Unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'


# enable bash debug mode
# if the script was called with '--debug'
enable_debug () {
    local args=$@;
    local e;

    for e in ${args[@]}; 
    do
        if [[ "$e" == "--debug" ]]; then
            set -x
        fi
    done

}


create_tmp_file () {
    local template="$(basename $0).XXXXXXXX";
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
    local tmp_file="$(create_tmp_file)";

    download_file "$host" "$tmp_file";
    clean_file "$tmp_file" "$output_file"

    echo -e "Fetched: $host";
}

restart_dnsmasq () {
    local restart_script="$DOTFILES/dnsmasq/restart_dnsmasq.sh";
    
    if [ -f "$restart_script" ]; then
        bash "$restart_script";
    fi

}


main () {
    
    enable_debug "$@";

    local ADBLOCK_FILE="blocked_hosts.list";
    local TMP_FILE=$(create_tmp_file);
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
    
    echo -e "Attempting to restart dnsmasq";
    restart_dnsmasq;

}

main "$@";
