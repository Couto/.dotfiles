#!/bin/bash

create_tmp_file () {
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
    grep "0.0.0.0\|127.0.0.1" $1 | awk '{ print "127.0.0.1\t"$2 }' >> "$2"
}

ADBLOCK_FILE="adblock.list";
TMP_FILE=$(create_tmp_file);
NAMESERVERS="127.0.0.1 $(networksetup -getdnsservers Wi-Fi)";


yoyo=$(create_tmp_file);
swch=$(create_tmp_file);
mvps=$(create_tmp_file);
host=$(create_tmp_file);

download_file "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0" "$yoyo" &
download_file "http://someonewhocares.org/hosts/zero/" "$swch" &
download_file "http://winhelp2002.mvps.org/hosts.txt" "$mvps" &
download_file "http://hosts-file.net/download/hosts.txt" "$host" &
wait

echo "Formatting lists and creating hosts file";
clean_file "$yoyo" "$TMP_FILE";
clean_file "$swch" "$TMP_FILE";
clean_file "$mvps" "$TMP_FILE";
clean_file "$host" "$TMP_FILE";

echo "Sorting and removing duplicates"
tr '[A-Z]' '[a-z]' < "$TMP_FILE" | sort -f | uniq -u | sed 's///g' > $ADBLOCK_FILE;

echo "Add local machine as nameserver"
# sudo networksetup -setdnsservers Wi-Fi $(echo "$NAMESERVERS" | tr ' ' '\n' | uniq -u | tr '\n' ' ');

