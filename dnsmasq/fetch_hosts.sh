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

get_network_interface () {
    echo "$(route get 8.8.8.8 | grep 'interface' | sed 's/interface://g' | tr -d ' ')";
}

get_network_service() {
    
    scutil_query(){
        local key=$1;

        scutil<<EOT
            open
            get $key
            d.show
            close
EOT
    }

    local SERVICE_GUID="$(scutil_query State:/Network/Global/IPv4 | grep 'PrimaryService' | awk '{print $3}')";
    local SERVICE_NAME="$(scutil_query Setup:/Network/Service/$SERVICE_GUID | grep 'UserDefinedName' | awk -F': ' '{print $2}')";

    echo "$SERVICE_NAME";
}

get_dhcp_dns () {
    local interface="$(get_network_interface)";
    echo "$(ipconfig getpacket $interface | grep 'domain_name_server' |  cut -d '{' -f2 | cut -d '}' -f1)";
}

get_configured_dns () {
    local service=$(get_network_service);
    echo $(networksetup -getdnsservers $service);
}

get_nameservers() {
    local nameservers="$(get_configured_dns)";

    if [[ $nameservers == *DNS\ Servers* ]]; then
        nameservers=$(get_dhcp_dns);
    fi

    echo $nameservers;
}

main () {
    
    local ADBLOCK_FILE="adblock.list";
    local TMP_FILE=$(tmp_file);
    local NAMESERVERS="127.0.0.1 $(get_nameservers)";

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

    echo "Add local machine as nameserver"
    sudo networksetup -setdnsservers $(get_network_service) $(echo $NAMESERVERS | tr ' ' '\n' | uniq | tr '\n' ' ');

}

main;
