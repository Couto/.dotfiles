#!/user/bin/env bash

set -euo pipefail
IFS=$'\n\t'

prompt () {
    echo "$@";
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) return 0; exit;;
            No ) return 1; exit;;
        esac
    done
}

restart_dnsmasq () {
    sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons
    sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}


if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then

    restart_dnsmasq;

else
 
    prompt "

    To restart dnsmasq, launchctl must be used, however launchctl 
    doesn't work inside tmux, unless you're running `reattach-to-user-namespace`
    
    Do you still want to attempt to restart dnsmasq?
    
    " && restart_dnsmasq;   

fi
