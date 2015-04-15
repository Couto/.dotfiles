start_time=$(date +%s)

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

# History settings (stolen from oh-my-zsh)
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Display computer information using archey
# but only if we're not inside a tmux/screen session
if ! { [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; } then
    archey -c
fi

end_time=$(date +%s)
echo .zshrc: $((end_time - start_time)) seconds
