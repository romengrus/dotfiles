# 10-history.zsh — history config + setopt

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY          # record timestamps + duration
setopt HIST_IGNORE_ALL_DUPS      # dedup entire history
setopt HIST_IGNORE_SPACE         # leading-space commands are not recorded (secrets)
setopt HIST_REDUCE_BLANKS        # normalize whitespace
setopt HIST_VERIFY               # !! expansion shows before executing
setopt INC_APPEND_HISTORY        # write to history file immediately
setopt SHARE_HISTORY             # all sessions share history, instantly

# Allow `#` comments at the interactive prompt
setopt INTERACTIVE_COMMENTS
