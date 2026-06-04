# 30-tools.zsh — integration with eza, bat, fzf

# fzf: fuzzy finder — key bindings + completion
# Files live in different paths across distros; try them in order.
__fzf_bindings=""
__fzf_completion=""
for candidate in \
  /usr/share/doc/fzf/examples/key-bindings.zsh \
  /usr/share/fzf/key-bindings.zsh \
  /usr/share/fzf/shell/key-bindings.zsh; do
  if [[ -z "$__fzf_bindings" && -f "$candidate" ]]; then
    __fzf_bindings="$candidate"
  fi
done
for candidate in \
  /usr/share/doc/fzf/examples/completion.zsh \
  /usr/share/fzf/completion.zsh \
  /usr/share/fzf/shell/completion.zsh; do
  if [[ -z "$__fzf_completion" && -f "$candidate" ]]; then
    __fzf_completion="$candidate"
  fi
done
[[ -n "$__fzf_bindings" ]]   && source "$__fzf_bindings"   2>/dev/null
[[ -n "$__fzf_completion" ]] && source "$__fzf_completion" 2>/dev/null
unset __fzf_bindings __fzf_completion candidate

# Default fzf options — nicer preview window
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'

# Use fd if available (much faster than find, respects .gitignore)
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
elif command -v fdfind >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
fi

# bat / batcat — defensive: try batcat first (Ubuntu/Debian), then bat (other)
if command -v batcat >/dev/null 2>&1; then
  export BAT_CMD='batcat'
elif command -v bat >/dev/null 2>&1; then
  export BAT_CMD='bat'
fi

# eza — default flags for all aliases
export EZA_OPTIONS='--icons --group-directories-first'
