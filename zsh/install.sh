#!/usr/bin/env bash
# zsh/install.sh — idempotent bootstrap for the dotfiles zsh config.
# See: docs/zsh.md
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_DIR="$REPO_DIR/zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[1;33m%s\033[0m\n' "$*"; }
red() { printf '\033[1;31m%s\033[0m\n' "$*" >&2; }

need() { command -v "$1" >/dev/null 2>&1 || {
	red "missing dependency: $1"
	return 1
}; }

# -----------------------------------------------------------------------------
# 1. System packages (apt, Ubuntu/Debian)
# -----------------------------------------------------------------------------
if command -v apt >/dev/null 2>&1; then
	green "==> apt: zsh eza bat fzf git curl"
	sudo apt update
	sudo apt install -y zsh eza bat fzf git curl
else
	yellow "==> apt not found; skipping system packages. Install manually: zsh eza bat fzf git curl"
fi

# -----------------------------------------------------------------------------
# 2. Oh My Zsh
# -----------------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	green "==> installing Oh My Zsh"
	KEEP_ZSHRC=yes RUNZSH=no CHSH=no \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	green "==> Oh My Zsh already installed at ~/.oh-my-zsh"
fi

mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

# -----------------------------------------------------------------------------
# 3. External OMZ plugins
# -----------------------------------------------------------------------------
clone_or_pull() {
	local url="$1" dest="$2"
	if [[ -d "$dest/.git" ]]; then
		green "==> updating $(basename "$dest")"
		git -C "$dest" pull --ff-only --quiet
	else
		green "==> cloning $(basename "$dest")"
		git clone --depth=1 --quiet "$url" "$dest"
	fi
}

clone_or_pull https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_or_pull https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# -----------------------------------------------------------------------------
# 4. Powerlevel10k theme
# -----------------------------------------------------------------------------
clone_or_pull https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"

# -----------------------------------------------------------------------------
# 5. Fonts
# -----------------------------------------------------------------------------
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
green "==> installing MesloLGS NF fonts to $FONT_DIR"
for src in "$ZSH_DIR/fonts/"*.ttf; do
	[[ -f "$src" ]] || continue
	dest="$FONT_DIR/$(basename "$src")"
	if [[ "$src" -nt "$dest" ]] || [[ ! -f "$dest" ]]; then
		cp -f "$src" "$dest"
	fi
done
if command -v fc-cache >/dev/null 2>&1; then
	fc-cache -f "$FONT_DIR" >/dev/null
fi
green "==> fonts installed. Set 'MesloLGS NF' as your Konsole profile font."

# -----------------------------------------------------------------------------
# 6. Symlinks (idempotent, warns if target exists and is not a symlink to repo)
# -----------------------------------------------------------------------------
link() {
	local src="$1" target="$2"
	if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$src")" ]]; then
		green "==> $target already linked correctly"
		return
	fi
	if [[ -e "$target" && ! -L "$target" ]]; then
		yellow "==> backing up existing $target → $target.bak"
		mv "$target" "$target.bak"
	fi
	ln -sf "$src" "$target"
	green "==> linked $target → $src"
}

link "$ZSH_DIR/.zshrc" "$HOME/.zshrc"
link "$ZSH_DIR/p10k/.p10k.zsh" "$HOME/.p10k.zsh"

# Create ~/.zshrc.d as a symlink to the repo's modular dir
link "$ZSH_DIR/.zshrc.d" "$HOME/.zshrc.d"

# -----------------------------------------------------------------------------
# 7. Default shell
# -----------------------------------------------------------------------------
ZSH_BIN="$(command -v zsh || true)"
if [[ -n "$ZSH_BIN" ]] && [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
	yellow "==> current shell is '${SHELL:-unset}', zsh is at '$ZSH_BIN'"
	yellow "    run:  chsh -s '$ZSH_BIN'    (then log out and back in)"
fi

green ""
green "==> done. Open a new Konsole tab to see your new prompt."
green "    If icons show as boxes, set 'MesloLGS NF' in Konsole profile appearance."
