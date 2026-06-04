# 00-env.zsh — environment, PATH, editor, language managers

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Prefer US English and UTF-8
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Less: nice defaults (don't clear screen, exit if <1 screen, raw control chars)
export LESS='-F -R -X -i'

# Color-aware tools
export GREP_COLORS='mt=01;31:fn=01;35:bn=01;32:se=01;34'

# Cargo (Rust) — keep literal source, fast (just PATH prepend)
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Ruby gems (kept literal, matches original .zshrc)
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin"

# nvm — lazy-loaded to keep shell startup fast.
# First invocation of nvm/node/npm/npx/pnpm/yarn sources nvm.sh (~250ms),
# then re-execs the command. Subsequent calls are normal speed.
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  __p10k_nvm_load() {
    unset -f nvm node npm npx pnpm yarn 2>/dev/null
    source "$NVM_DIR/nvm.sh"
  }
  nvm()  { __p10k_nvm_load; nvm "$@"; }
  node() { __p10k_nvm_load; node "$@"; }
  npm()  { __p10k_nvm_load; npm "$@"; }
  npx()  { __p10k_nvm_load; npx "$@"; }
  pnpm() { __p10k_nvm_load; pnpm "$@"; }
  yarn() { __p10k_nvm_load; yarn "$@"; }
fi
