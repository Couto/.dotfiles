# start_time="$(date +%s)"

HOME=/Users/couto;
DOTFILES=$HOME/.dotfiles

# Antigen and ZSH plugins
source $DOTFILES/antigen/antigen.zsh

antigen bundles <<EOFBUNDLES 

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
kennethreitz/autoenv

EOFBUNDLES

# This works as a theme
antigen bundle sindresorhus/pure

antigen apply

# rbenv, pyenv, nvm and the likes
source $(brew --prefix nvm)/nvm.sh
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# History Substring Search key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



# end_time="$(date +%s)"
# echo .zshrc: $((end_time - start_time)) seconds
