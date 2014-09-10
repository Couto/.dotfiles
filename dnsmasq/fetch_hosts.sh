#!/bin/bash

create_tmp_file () {
    local template="$(basename $0)";
    echo $(mktemp -t $template);
}

download_file () {
    local output=$2;
    local url=$1
    echo "Downloading $1";
    curl -s -o $output $url || exit 1
}

ADBLOCK_FILE="adblock.list";
TMP_FILE=$(create_tmp_file);
NAMESERVERS="127.0.0.1 $(networksetup -getdnsservers Wi-Fi)";


swch=$(create_tmp_file);
mvps=$(create_tmp_file);
host=$(create_tmp_file);

download_file "http://someonewhocares.org/hosts/zero/" "$swch" &
download_file "http://winhelp2002.mvps.org/hosts.txt" "$mvps" &
download_file "http://hosts-file.net/download/hosts.txt" "$host" &
wait

echo "Formatting lists and creating hosts file";
grep "127.0.0.1" "$swch" | awk '{ print "0.0.0.0\t"$2 }' >> $TMP_FILE
grep "0.0.0.0" "$mvps"   | grep -v "# 0.0.0.0" | awk '{ print "0.0.0.0\t"$2 }' >> $TMP_FILE
grep "127.0.0.1" "$host" | awk '{ print "0.0.0.0\t"$2 }' >> $TMP_FILE

echo "Sorting and removing duplicates"
tr '[A-Z]' '[a-z]' < "$TMP_FILE" | sort -f | uniq > $ADBLOCK_FILE;

echo "Add local machine as nameserver"
sudo networksetup -setdnsservers Wi-Fi $(echo "$NAMESERVERS" | tr ' ' '\n' | uniq -u | tr '\n' ' ');

