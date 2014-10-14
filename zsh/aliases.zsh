#!/bin/zsh

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    #eval `dircolors ~/.dir_colors`
fi

# Alias
alias gi='gist -c -p -P -s -t js'
alias poopin='open /System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app/'
alias fuck='sudo !!'
alias zshrc='source ~/.zshrc'

# Network
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias geoip='curl -fsS http://ip-api.com/json | python -mjson.tool | pygmentize -l json'
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias whoiss='whois -h whois-servers.net'
alias server='python -m SimpleHTTPServer'
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias dnsmasq-start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist'
alias dnsmasq-stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist'

alias l='ls $LS_OPTIONS -lAhF'

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

# Utilities
alias trim="sed -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*\$//g'"; # echo " some string with spaces " | trim
