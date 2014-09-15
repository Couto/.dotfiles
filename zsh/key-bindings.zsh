#!/bin/bash

# History Substring Search key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Search backward incrementally for a specified string
bindkey '^r' history-incremental-search-backward # ctrl+r

# Cursor movements
bindkey '^a' beginning-of-line # ctrl+a
bindkey '^e' end-of-line # ctrl+e

# [Backspace] - delete backward
bindkey '^?' backward-delete-char

# [Delete] - delete forward
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char


# [Home] - Go to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line
fi

# [End] - Go to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line
fi
