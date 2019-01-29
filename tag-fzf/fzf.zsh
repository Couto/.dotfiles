# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/couto/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/couto/.fzf/bin"
fi

command -v rg >/dev/null 2>&1 && { 
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
}

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/couto/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/couto/.fzf/shell/key-bindings.zsh"

