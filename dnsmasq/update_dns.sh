#!/bin/bash

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
    local nameservers="127.0.0.1  $(get_nameservers)";
    local ns=$(echo $nameservers | tr ' ' '\n' | uniq | tr '\n' ' ');
   

    echo "Add local machine as nameserver"
    sudo networksetup -setdnsservers $(get_network_service) $ns;
    echo "New nameservers list:"
    echo "$ns" | tr ' ' '\n';
}

main;
