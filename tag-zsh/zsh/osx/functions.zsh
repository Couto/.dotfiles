#!/usr/bin/env zsh

function disable_daemon {
  echo "Disabling ${1}";
  sudo launchctl unload -w /System/Library/LaunchDaemons/${1}.plist;
}

function disable_agent {
  echo "Disabling ${1}";
  launchctl unload -w /System/Library/LaunchAgents/${1}.plist;
}
