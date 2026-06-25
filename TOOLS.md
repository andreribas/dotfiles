# Tools

Reference guide for each tool installed by `setup.sh`.

---

## zsh

**Site:** https://www.zsh.org/  
**Type:** shell

Main shell. bash-compatible — scripts and habits transfer directly. Better native autocompletion and plugin ecosystem without needing heavy frameworks.

**Useful commands**

```bash
reload           # reloads .zshrc (alias defined in dotfiles)
zshprofile       # opens .zshrc in vim and reloads on exit
```

---

## starship

**Site:** https://starship.rs/  
**Type:** prompt  
**Config:** `~/.config/starship.toml` (managed by stow)

Minimalist and fast prompt. Automatically detects the context of the current directory and displays relevant information.

What appears in the prompt:
- Current path (truncated to 4 levels, repo root when inside one)
- Git branch and status (modified, staged, ahead/behind)
- Node, Python, or Ruby version when detected in the project

**Useful commands**

```bash
starship explain    # shows what each part of the current prompt represents
starship preset     # lists available presets
```

---

## stow

**Site:** https://www.gnu.org/software/stow/  
**Type:** symlink manager

Creates symlinks from each package to `$HOME`, mirroring the directory structure. Allows versioning dotfiles without moving files from their expected system locations.

**Useful commands**

```bash
# from ~/projects/dotfiles
stow zsh                        # activates the zsh package (creates ~/.zshrc)
stow -D zsh                     # removes symlinks for the zsh package
stow --restow zsh               # recreates symlinks (useful after changes)
stow zsh git starship           # activates multiple packages at once
```

**Adding a new package**

1. Create the directory with the package name: `mkdir my-package`
2. Add files mirroring the structure from `$HOME`
   - Ex: config at `~/.config/foo/bar.toml` → `my-package/.config/foo/bar.toml`
3. Run `stow my-package`
4. Add it to `setup.sh`

---

## ghostty

**Site:** https://ghostty.org/  
**Type:** terminal

Native macOS terminal, GPU-accelerated. Fast startup, true color support, ligatures, and multiplexers. No Electron, no bloat.

**Useful shortcuts**

| Shortcut | Action |
|---|---|
| `Cmd t` | New tab |
| `Cmd n` | New window |
| `Cmd d` | Split pane vertically |
| `Cmd Shift d` | Split pane horizontally |
| `Cmd [` / `Cmd ]` | Navigate between panes |
| `Cmd ,` | Open settings |

---

## zellij

**Site:** https://zellij.dev/  
**Type:** terminal multiplexer

Splits the terminal into panes and tabs, keeping sessions alive even after closing the terminal. Modern alternative to tmux — shortcuts visible in the bottom bar, no need to memorize configurations.

Start with `zellij`. The current mode and available shortcuts are always shown on screen.

**Panes**

| Shortcut | Action |
|---|---|
| `Ctrl p` → `n` | New pane |
| `Ctrl p` → `d` | Split down |
| `Ctrl p` → `r` | Split right |
| `Ctrl p` → `x` | Close pane |
| `Ctrl p` → arrows | Navigate between panes |
| `Ctrl p` → `z` | Maximize/restore current pane |
| `Ctrl p` → `w` | Floating mode (floating pane) |

**Tabs**

| Shortcut | Action |
|---|---|
| `Ctrl t` → `n` | New tab |
| `Ctrl t` → `x` | Close tab |
| `Ctrl t` → arrows | Navigate between tabs |
| `Ctrl t` → `r` | Rename tab |

**Sessions**

| Shortcut | Action |
|---|---|
| `Ctrl o` → `d` | Detach (session continues in background) |
| `zellij attach` | Reconnect to the most recent session |
| `zellij list-sessions` | List active sessions |
| `zellij kill-session <name>` | Kill a session |

**Quit:** `Ctrl q`

---

## tree

**Type:** utility  

Lists directories in tree format. Installed via homebrew.

**Useful commands**

```bash
tree                  # lists the current directory
tree -L 2             # limits to 2 levels of depth
tree -a               # includes hidden files
tree -I node_modules  # ignores a directory
```
