#!/bin/zsh

# Alias
alias gi='gist -c -p -P -s -t js'
alias poopin='open /System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app/'
alias fuck='sudo'

# Network
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias whoiss='whois -h whois-servers.net'
alias server='python -m SimpleHTTPServer'
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias l='ls -lahG'

# prompt before overwriting file
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias ln='ln -i'

# because typing 'cd' is A LOT of work!!
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
