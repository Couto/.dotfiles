#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

readonly BREWFILE="$(dirname $0)/Brewfile";
readonly CASKFILE="$(dirname $0)/Caskfile";
readonly FOUNDRYFILE="$(dirname $0)/Foundryfile";

brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

brew update
brew upgrade

# Install brew packages
while read package; do
  brew install "${package}";
done < "${BREWFILE}"

# Install brew cask applications
while read application; do
  brew cask install "${application}";
done < "${CASKFILE}"

# Install brew cask fonts
while read font; do
  brew cask install "${font}";
done < "${FOUNDRYFILE}"



