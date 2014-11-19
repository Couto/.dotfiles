start_time=$(date +%s)

# Quick shortcuts
export HOME=/Users/couto;
export DOTFILES=${HOME}/.dotfiles

# Get aliases, functions and so on
for file in ${DOTFILES}/zsh/{exports,aliases,functions,key-bindings}.zsh; do
    source $file;
done

# Antigen and ZSH plugins
source ${DOTFILES}/antigen/antigen.zsh

antigen bundles <<EOFBUNDLES

    rupa/z
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-history-substring-search
    kennethreitz/autoenv
    sindresorhus/pure

EOFBUNDLES

antigen apply

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# rbenv, pyenv, nvm and the likes
source "$(brew --prefix nvm)/nvm.sh"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Display computer information using archey
# but only if we're not inside a tmux/screen session
if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then
    archey -c
fi

end_time=$(date +%s)
echo .zshrc: $((end_time - start_time)) seconds
