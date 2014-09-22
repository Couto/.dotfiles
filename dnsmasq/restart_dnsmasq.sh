#!/bin/bash

if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then
    echo "Stopping homebrew.mxcl.dnsmasq";
    sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    echo "Launching homebrew.mxcl.dnsmasq"
    sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons
    sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    echo "Flushing DNS cache"
    dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
else
    echo "ERROR: launchctl doesn't work inside tmux or screen sessions."
fi
