# 40-aliases.zsh — all aliases

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls → eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lah --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons --git-ignore'

# cat → bat (defensive: handle both Ubuntu's batcat and upstream bat)
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --paging=never'
  alias cata='batcat --paging=never -A'
elif command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias cata='bat --paging=never -A'
fi

# grep — always color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Shell conveniences
alias cls='clear'
alias h='history 25'
alias reload='source ~/.zshrc'
alias zshrc='${EDITOR:-nvim} ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'

# Git — OMZ `git` plugin already gives us gs/gst/ga/gcmsg/gco/gp/gl/gb/etc.
# Add only what it doesn't cover:
alias glog='git log --graph --oneline --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'

# Quick reload + edit shortcuts for the modular config
alias zshrc.d='${EDITOR:-nvim} ~/.zshrc.d'
alias p10krc='${EDITOR:-nvim} ~/.p10k.zsh'
