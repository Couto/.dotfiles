#!/bin/bash

tmp_file () {
    local template="$(basename $0)";
    echo "$(mktemp -t $template)";
}

download_file () {
    local output=$2;
    local url=$1
    echo "Downloading $1";
    curl -s -o "$output" "$url" || exit 1
}

clean_file () {
    echo "Cleaning: $1"; 
    grep "0.0.0.0\|127.0.0.1" $1 | awk '{ print "127.0.0.1\t"$2 }' | sed 's///g' >> "$2"
}

main () {
    
    local ADBLOCK_FILE="adblock.list";
    local TMP_FILE=$(tmp_file);

    local yoyo=$(tmp_file);
    local swch=$(tmp_file);
    local mvps=$(tmp_file);
    local host=$(tmp_file);

    download_file "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0" "$yoyo" &
    download_file "http://someonewhocares.org/hosts/zero/" "$swch" &
    download_file "http://winhelp2002.mvps.org/hosts.txt" "$mvps" &
    download_file "http://hosts-file.net/download/hosts.txt" "$host" &
    wait

    clean_file "$yoyo" "$TMP_FILE";
    clean_file "$swch" "$TMP_FILE";
    clean_file "$mvps" "$TMP_FILE";
    clean_file "$host" "$TMP_FILE";

    echo "Sorting and removing duplicates"
    tr '[A-Z]' '[a-z]' < "$TMP_FILE" | sort -f | uniq > $ADBLOCK_FILE;

}

main;
