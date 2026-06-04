# .zshrc — thin loader
# All real config lives in ~/.zshrc.d/*.zsh
# See: ~/projects/dotfiles/docs/zsh.md

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme: Powerlevel10k (installed by zsh/install.sh into $ZSH_CUSTOM/themes/)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins — order matters! zsh-syntax-highlighting must be last.
plugins=(
  git
  sudo
  extract
  command-not-found
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Load modular config (sorted by filename — hence the numeric prefixes)
if [[ -d ~/.zshrc.d ]]; then
  for f in ~/.zshrc.d/*.zsh(N); do
    source "$f"
  done
fi
