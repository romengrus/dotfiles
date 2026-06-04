# Zsh configuration

Modern, sexy, dev-focused zsh setup powered by Oh My Zsh + Powerlevel10k.

## What's in the box

| Component                        | What it does                                       |
| -------------------------------- | -------------------------------------------------- |
| **Powerlevel10k**                | The prompt. Two-line, rainbow, transient, instant. |
| **MesloLGS NF**                  | Nerd Font for p10k icons.                          |
| **Oh My Zsh**                    | Plugin manager.                                    |
| **zsh-autosuggestions**          | Ghost-text history suggestions (fish-like).        |
| **zsh-syntax-highlighting**      | Colors commands as you type.                       |
| **zsh-history-substring-search** | Up-arrow matches by substring.                     |
| **eza**                          | `ls` replacement with icons + git status.          |
| **bat** (`batcat` on Ubuntu)     | `cat` replacement with syntax highlighting.        |
| **fzf**                          | Fuzzy finder for history, files, directories.      |

## Repo layout

```
zsh/
├── install.sh                    # idempotent bootstrap script
├── .zshrc                        # thin loader (sources .zshrc.d/*)
├── .zshrc.d/
│   ├── 00-env.zsh                # PATH, EDITOR, cargo, ruby, nvm lazy-load
│   ├── 10-history.zsh            # HIST* + setopt
│   ├── 20-plugins.zsh            # OMZ plugins + keybinds
│   ├── 30-tools.zsh              # eza/bat/fzf integration
│   ├── 40-aliases.zsh            # all aliases
│   └── 99-local.zsh              # machine-specific overrides (gitignored)
├── fonts/                        # MesloLGS NF (4 .ttf files)
└── p10k/
    └── .p10k.zsh                 # pre-baked rainbow config
```

## Installation

### 1. Install the font (Konsole)

The four MesloLGS NF files live in `zsh/fonts/`. Install them system-wide:

```bash
mkdir -p ~/.local/share/fonts
cp zsh/fonts/MesloLGS-NF-*.ttf ~/.local/share/fonts/
fc-cache -f
```

Then in Konsole: **Settings → Edit Current Profile → Appearance** → select **MesloLGS NF**.

### 2. Run the bootstrap script

```bash
cd ~/projects/dotfiles
bash zsh/install.sh
```

The script is idempotent (safe to re-run). It will:

1. `apt install` system packages: `zsh eza bat fzf git curl`
2. Clone Oh My Zsh into `~/.oh-my-zsh` (if missing).
3. Clone external OMZ plugins into `$ZSH_CUSTOM/plugins/`:
   - `zsh-autosuggestions`
   - `zsh-syntax-highlighting`
   - `zsh-history-substring-search`
4. Clone Powerlevel10k into `$ZSH_CUSTOM/themes/powerlevel10k`.
5. Symlink `~/.zshrc` and `~/.p10k.zsh` to the repo.

### 3. Make zsh your default shell

```bash
chsh -s "$(which zsh)"
```

Log out and back in for it to take effect.

### 4. First launch

Open a new Konsole tab. You should see the Powerlevel10k prompt. If anything looks off, run:

```bash
p10k configure
```

to re-enter the wizard. The shipped config is the **Rainbow** preset with minimal right-side info.

### 5. (Optional) Machine-specific overrides

```bash
cp zsh/.zshrc.d/99-local.zsh.example zsh/.zshrc.d/99-local.zsh
```

Edit `99-local.zsh` with paths/exports you don't want in git (work repos, private tokens, etc.). The file is gitignored.

## Cheatsheet

### Aliases

#### Navigation

| Alias | Action                            |
| ----- | --------------------------------- |
| `..`  | `cd ..`                           |
| `...` | `cd ../..`                        |
| `-`   | previous directory (zsh built-in) |

#### Listing (`eza`)

| Alias | Action                                       |
| ----- | -------------------------------------------- |
| `ls`  | colored listing with icons                   |
| `ll`  | long format + git status per file            |
| `la`  | long + hidden + git status                   |
| `lt`  | tree view (depth 2, gitignored files hidden) |

#### Files (`bat`)

| Alias  | Action                                             |
| ------ | -------------------------------------------------- |
| `cat`  | syntax-highlighted, no pager                       |
| `cata` | same, with non-printing chars visible (debug mode) |

#### Git (built-in OMZ `git` plugin — most useful)

| Alias   | Action                                                |
| ------- | ----------------------------------------------------- |
| `gs`    | `git status`                                          |
| `gst`   | `git status`                                          |
| `ga`    | `git add`                                             |
| `gcmsg` | `git commit -m`                                       |
| `gco`   | `git checkout`                                        |
| `gp`    | `git push`                                            |
| `gl`    | `git pull`                                            |
| `gb`    | `git branch`                                          |
| `glog`  | (custom) `git log --graph --oneline --decorate --all` |
| `gd`    | (custom) `git diff`                                   |

#### Shell

| Alias               | Action                                            |
| ------------------- | ------------------------------------------------- |
| `cls`               | `clear`                                           |
| `h`                 | `history`                                         |
| `reload`            | `source ~/.zshrc`                                 |
| `zshrc`             | open `~/.zshrc` in `$EDITOR` (nvim)               |
| `extract <archive>` | extract any archive format (OMZ `extract` plugin) |

### Keybindings

| Key             | Action                                                         |
| --------------- | -------------------------------------------------------------- |
| **Ctrl-R**      | fzf fuzzy history search                                       |
| **Ctrl-T**      | fzf fuzzy file picker (inserts path at cursor)                 |
| **Alt-C**       | fzf fuzzy `cd` into a subdirectory                             |
| **Ctrl-Space**  | accept zsh-autosuggestions ghost text                          |
| **Up arrow**    | history-substring-search up (matches what you typed)           |
| **Down arrow**  | history-substring-search down                                  |
| **Esc Esc**     | prepend `sudo` to current/previous command (OMZ `sudo` plugin) |
| **Right arrow** | accept autosuggestion (alternative to Ctrl-Space)              |

### Prompt (Powerlevel10k)

Two-line rainbow prompt. Segments:

**Left side:**

- `dir` — current directory, color-coded per level
- `vcs` — git branch + status (✓ clean, ✗ dirty, ⇡ ahead, ⇣ behind)
- `prompt_char` — `❯` green if last command succeeded, red if failed

**Right side (minimal):**

- `command_duration` — shown only if command took >2 seconds
- `time` — current time, 24h format

**Transient prompt:** after command execution, the previous multi-line prompt collapses to a single `❯`. Keeps scrollback readable. Disable temporarily with `POWERLEVEL9K_TRANSIENT_PROMPT=off`.

**Instant prompt:** previous prompt is shown immediately on shell start, hiding cold-start latency. If a plugin prints to stdout and breaks it, run `p10k configure` and switch to "verbose" instant prompt.

### Configuration commands

| Command          | Action                      |
| ---------------- | --------------------------- |
| `p10k configure` | re-run p10k wizard          |
| `omz update`     | update Oh My Zsh            |
| `reload`         | reload `.zshrc` after edits |
| `zshrc`          | edit `.zshrc` in nvim       |

### nvm lazy-load

`node`, `npm`, `npx`, `pnpm`, `yarn`, and `nvm` are shell stubs until first use. The first invocation sources `nvm.sh` (~250ms hit) and re-executes the command. Subsequent invocations are normal speed. This keeps shell startup fast.

If something weird happens (e.g. `nvm` not picking up the right version), force a fresh source:

```bash
source "$NVM_DIR/nvm.sh"
```

### History

| Setting                             | Value                                                                          |
| ----------------------------------- | ------------------------------------------------------------------------------ |
| `HISTSIZE` / `SAVEHIST`             | 100,000                                                                        |
| Dedup                               | yes (`HIST_IGNORE_ALL_DUPS`)                                                   |
| Share across sessions               | yes (`SHARE_HISTORY`)                                                          |
| Append immediately                  | yes (`INC_APPEND_HISTORY`)                                                     |
| Leading-space commands not recorded | yes (`HIST_IGNORE_SPACE`) — prefix with a space to keep secrets out of history |

### Troubleshooting

**Prompt looks broken / shows boxes instead of icons.** Konsole isn't using MesloLGS NF. Re-check Settings → Edit Current Profile → Appearance.

**Shell startup feels slow.** First check nvm isn't being sourced eagerly — grep `.zshrc.d/` for `nvm.sh`. Then check OMZ plugins aren't printing to stdout (breaks instant prompt):

```bash
time zsh -i -c exit
```

**`bat` is `batcat` on Ubuntu.** Already handled by defensive aliases. If `cat` isn't highlighting, check `command -v batcat || command -v bat`.

**fzf keybindings not working.** Make sure `/usr/share/doc/fzf/examples/key-bindings.zsh` exists. On minimal installs you may need `apt install fzf` explicitly.

**Want to start fresh.** Remove the symlinks, everything else lives in the repo:

```bash
rm ~/.zshrc ~/.p10k.zsh
```
