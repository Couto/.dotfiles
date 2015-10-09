#!/usr/bin/env zsh

# Network
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias geoip='curl -fsS http://ip-api.com/json | python -mjson.tool | jq "."'
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias whoiss='whois -h whois-servers.net'
alias server='python -m SimpleHTTPServer'
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

