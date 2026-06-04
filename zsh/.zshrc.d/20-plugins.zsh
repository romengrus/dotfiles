# 20-plugins.zsh — keybindings for plugins that need post-source wiring

# history-substring-search — Up/Down arrow matches by substring.
# Cloned into $ZSH_CUSTOM/plugins/zsh-history-substring-search by install.sh.
__hss="$ZSH_CUSTOM/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
if [[ -f "$__hss" ]]; then
  source "$__hss"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # Also bind the keypad arrows + terminfo equivalents
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi
unset __hss
