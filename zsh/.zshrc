start_time="$(date +%s)"

# Quick shortcuts
export HOME=/Users/couto;
export DOTFILES=$HOME/.dotfiles

# Path
export PATH=$DOTFILES/bin:/usr/local/bin:/usr/local/sbin:$PATH;

# Editors
export ATOM_PATH="/opt/homebrew-cask/Caskroom/atom/latest/"
export ATOM="$ATOM_PATH/Atom.app"
export EDITOR=$(which vim)
export VISUAL="$(which vim)"

# Antigen and ZSH plugins
source $DOTFILES/antigen/antigen.zsh

antigen bundles <<EOFBUNDLES 

rupa/z
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
kennethreitz/autoenv

EOFBUNDLES

# This works as a theme
antigen bundle sindresorhus/pure

antigen apply

# rbenv, pyenv, nvm and the likes
export NVM_DIR=$HOME/.nvm
source $(brew --prefix nvm)/nvm.sh
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# History Substring Search key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Alias
alias gi='gist -c -p -P -s -t js'
alias l='ls -laG'
alias poopin='open /System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app/'
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="dscacheutil -flushcache"

# Display computer information using archey
# but only if we're not inside a tmux/screen session
if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then
    archey -c
fi

end_time="$(date +%s)"
echo .zshrc: $((end_time - start_time)) seconds
