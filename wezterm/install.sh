#!/usr/bin/env bash
# wezterm/install.sh — idempotent bootstrap for the dotfiles wezterm config.
# See: docs/wezterm.md
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WEZTERM_DIR="$REPO_DIR/wezterm"
TARGET_DIR="$HOME/.config/wezterm"
TARGET_FILE="$TARGET_DIR/wezterm.lua"

green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[1;33m%s\033[0m\n' "$*"; }
red() { printf '\033[1;31m%s\033[0m\n' "$*" >&2; }

# -----------------------------------------------------------------------------
# 1. System packages (dnf on Fedora; warn otherwise)
# -----------------------------------------------------------------------------
if ! command -v wezterm >/dev/null 2>&1; then
	if command -v dnf >/dev/null 2>&1; then
		green "==> dnf: wezterm"
		sudo dnf install -y wezterm
	else
		yellow "==> wezterm not found and dnf unavailable; install wezterm manually."
	fi
else
	green "==> wezterm already installed: $(wezterm --version 2>/dev/null || echo 'unknown version')"
fi

# -----------------------------------------------------------------------------
# 2. Fonts (MesloLGS NF, shared with the zsh/p10k setup)
# -----------------------------------------------------------------------------
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
need_font_copy=0
for src in "$REPO_DIR/zsh/fonts/"*.ttf; do
	[[ -f "$src" ]] || continue
	dest="$FONT_DIR/$(basename "$src")"
	if [[ "$src" -nt "$dest" ]] || [[ ! -f "$dest" ]]; then
		cp -f "$src" "$dest"
		need_font_copy=1
	fi
done
if [[ $need_font_copy -eq 1 ]] && command -v fc-cache >/dev/null 2>&1; then
	fc-cache -f "$FONT_DIR" >/dev/null
	green "==> MesloLGS NF fonts refreshed"
fi

# -----------------------------------------------------------------------------
# 3. Symlink ~/.config/wezterm/wezterm.lua -> repo
# -----------------------------------------------------------------------------
link() {
	local src="$1" target="$2"
	if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$src")" ]]; then
		green "==> $target already linked correctly"
		return
	fi
	if [[ -e "$target" || -L "$target" ]] && [[ ! -L "$target" || -e "$target" ]]; then
		if [[ -e "$target" && ! -L "$target" ]]; then
			yellow "==> backing up existing $target -> $target.bak"
			mv "$target" "$target.bak"
		fi
	fi
	ln -sf "$src" "$target"
	green "==> linked $target -> $src"
}

mkdir -p "$TARGET_DIR"
link "$WEZTERM_DIR/wezterm.lua" "$TARGET_FILE"

# -----------------------------------------------------------------------------
# 4. Verify the config parses
# -----------------------------------------------------------------------------
if command -v wezterm >/dev/null 2>&1; then
	if wezterm --config-file "$WEZTERM_DIR/wezterm.lua" show-keys >/dev/null 2>&1; then
		green "==> config parses cleanly"
	else
		red "==> WARNING: config did not parse; check $WEZTERM_DIR/wezterm.lua"
	fi
fi

green ""
green "==> done. Launch wezterm (or reload with Ctrl+Shift+R) to apply."
