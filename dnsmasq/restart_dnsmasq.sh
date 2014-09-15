#!/bin/bash

if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then
    sudo launchctl stop homebrew.mxcl.dnsmasq;
    sudo launchctl start homebrew.mxcl.dnsmasq;
else
    echo "ERROR: launchctl doesn't work inside tmux or screen sessions."
fi
