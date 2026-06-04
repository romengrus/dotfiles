# .p10k.zsh — Powerlevel10k config (Rainbow preset, minimal right side)
# Generated to match the design in docs/zsh.md.
# Re-run `p10k configure` if you want to switch presets and overwrite this.

# 'nerdfont-complete' assumes a Nerd-Font-patched font (MesloLGS NF, see zsh/fonts/).
typeset -g POWERLEVEL9K_MODE=nerdfont-v3

# Instant prompt — show cached prompt immediately on cold start.
# 'quiet' silences warnings from plugins that print to stdout during init.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Transient prompt — collapse previous prompts to a single '❯' after execution.
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

# ------------------------------------------------------------------------------
# Prompt segments
# ------------------------------------------------------------------------------

# Left side: dir + git + prompt_char
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir                     # current directory, color-coded per level
  vcs                     # git branch + status
  prompt_char             # ❯ green (success) / red (failure)
)

# Right side (minimal): command_duration + time
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_duration        # only shown if >2s
  time                    # 24h clock
)

# ------------------------------------------------------------------------------
# Layout / spacing
# ------------------------------------------------------------------------------

# Blank line between prompts for breathing room
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Two-line prompt
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Show '❯' on the second line (already in prompt_char segment)
typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

# Right prompt on the same line as the prompt_char (the second line)
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''
# (No extra prefix; prompt_char handles the ❯ glyph.)

# Connection between left & right sides on the first line
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='·'
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=''

# ------------------------------------------------------------------------------
# Dir segment — Rainbow style (background color shifts per path level)
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_DIR_BACKGROUND='blue'
typeset -g POWERLEVEL9K_DIR_FOREGROUND='white'
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
# Truncate middle of long paths: ~/p/dotfiles instead of ~/projects/dotfiles
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='…'
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# Icon at the start of the dir segment
typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER_COLOR='white'
typeset -g POWERLEVEL9K_HOME_ICON='\uF015'        # 
typeset -g POWERLEVEL9K_HOME_SUB_ICON='\uF07C'    # 
typeset -g POWERLEVEL9K_DIR_CLASSES=()

# ------------------------------------------------------------------------------
# VCS (git) segment
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_VCS_BACKGROUND='green'
typeset -g POWERLEVEL9K_VCS_FOREGROUND='black'

# Branch icon
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '  # 

# Branch formats
typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash)
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'

# Status icons
typeset -g POWERLEVEL9K_VCS_CLEAN_ICON='\u2714'      # ✔
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'  # ●
typeset -g POWERLEVEL9K_VCS_MODIFIED_ICON='\u2716'   # ✖
typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
typeset -g POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
typeset -g POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
typeset -g POWERLEVEL9K_VCS_GIT_ICON=''

# Ahead/behind
typeset -g POWERLEVEL9K_VCS_GIT_COMMITS_AHEAD_PREFIX=' ⇡'
typeset -g POWERLEVEL9K_VCS_GIT_COMMITS_BEHIND_PREFIX=' ⇣'

# ------------------------------------------------------------------------------
# prompt_char — ❯ green/red
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOPP}_FOREGROUND='green'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOPP}_FOREGROUND='red'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true

# ------------------------------------------------------------------------------
# command_duration — only show if >= 2s
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='grey'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='white'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_ICON='\uF252 '  # 
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_ONLY_SHOW_COMMANDS_EXCEEDING_THRESHOLD=true

# ------------------------------------------------------------------------------
# time — 24h
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_TIME_BACKGROUND='grey'
typeset -g POWERLEVEL9K_TIME_FOREGROUND='white'
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
typeset -g POWERLEVEL9K_TIME_ICON='\uF017 '  # 
typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

# ------------------------------------------------------------------------------
# Rainbow separators (angled Powerline-style)
# ------------------------------------------------------------------------------

typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'    # 
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'   # 
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'       # 
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'      # 
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''

# ------------------------------------------------------------------------------
# Status segment (when non-zero exit code) — only shown on failure
# ------------------------------------------------------------------------------

# Optional: add `status` to LEFT_PROMPT_ELEMENTS if you want exit codes inline.
# Currently relying on prompt_char's red color as the failure signal.
typeset -g POWERLEVEL9K_STATUS_OK=false
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='red'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='white'
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_COLOR='white'
typeset -g POWERLEVEL9K_STATUS_ERROR_CONTENT_EXPANSION='⏎ %?'

# ------------------------------------------------------------------------------
# Final marker required by p10k
# ------------------------------------------------------------------------------

(( ${#_p9k__line_widgets_left} == 0 )) || unset _p9k__line_widgets_left
typeset -gi _P9K_INITIALIZED=1
