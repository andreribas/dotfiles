#!/bin/bash
set -e

echo "==> dotfiles setup"

# ─── homebrew ─────────────────────────────────────────────────────────────────
BREW_BIN="/opt/homebrew/bin/brew"  # Apple Silicon; Intel uses /usr/local/bin/brew
[ -f "/usr/local/bin/brew" ] && BREW_BIN="/usr/local/bin/brew"

if [ ! -f "$BREW_BIN" ]; then
  echo "==> installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$($BREW_BIN shellenv)"

# ─── dependencies ─────────────────────────────────────────────────────────────
echo "==> installing dependencies"
brew install zsh stow starship tree zellij
brew install --cask ghostty

# ─── symlinks via stow ────────────────────────────────────────────────────────
echo "==> linking dotfiles"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES_DIR="$DOTFILES_DIR/home"

# Back up any real files that would conflict with stow.
# Symlinks already managed by stow are skipped.
resolve_conflicts() {
  local pkg="$1"
  local pkg_dir="$PACKAGES_DIR/$pkg"
  local found_conflict=0

  while IFS= read -r -d '' src; do
    local rel="${src#"$pkg_dir"/}"
    local target="$HOME/$rel"

    [ -e "$target" ] || [ -L "$target" ] || continue  # doesn't exist — no conflict
    [ -L "$target" ] && [ -e "$target" ] && continue  # valid symlink — stow owns it
    [ -L "$target" ] && { rm "$target"; continue; }   # broken symlink — safe to replace

    if [ "$found_conflict" -eq 0 ]; then
      echo ""
      echo "  conflicts in package: $pkg"
      found_conflict=1
    fi

    echo ""
    echo "  ~/$rel  (backing up to ~/${rel}.bak)"
    echo "  ── diff: local → repo ──────────────────"
    diff --unified=3 "$target" "$src" || true
    echo "  ────────────────────────────────────────"

    cp "$target" "${target}.bak"
    rm "$target"
  done < <(find "$pkg_dir" -type f -print0)
}

for pkg in "$PACKAGES_DIR"/*/; do resolve_conflicts "$(basename "$pkg")"; done

(cd "$PACKAGES_DIR" && stow --target="$HOME" *)

# ─── claude settings ──────────────────────────────────────────────────────────
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ ! -f "$CLAUDE_SETTINGS" ]; then
  echo "{}" > "$CLAUDE_SETTINGS"
fi
python3 - "$CLAUDE_SETTINGS" "$HOME" <<'PYEOF'
import sys, json
path, home = sys.argv[1], sys.argv[2]
with open(path) as f:
  s = json.load(f)
s['statusLine'] = {'type': 'command', 'command': f'{home}/.claude/statusline.sh'}
with open(path, 'w') as f:
  json.dump(s, f, indent=2)
  f.write('\n')
PYEOF
echo "==> configured ~/.claude/settings.json statusLine"

# ─── default shell ────────────────────────────────────────────────────────────
ZSH_PATH="$(brew --prefix)/bin/zsh"
if ! grep -q "$ZSH_PATH" /etc/shells; then
  echo "==> adding $ZSH_PATH to /etc/shells (requires sudo)"
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "==> changing default shell to zsh"
  chsh -s "$ZSH_PATH"
fi

# ─── local files ──────────────────────────────────────────────────────────────
if [ ! -f "$HOME/.env.local" ]; then
  cp "$DOTFILES_DIR/env/.env.local.sample" "$HOME/.env.local"
  echo "==> created ~/.env.local — fill in the required tokens"
fi

if [ ! -f "$HOME/.gitconfig.work" ]; then
  cat > "$HOME/.gitconfig.work" <<'EOF'
[user]
	email =
EOF
  echo "==> created ~/.gitconfig.work — add your work email"
fi

echo ""
echo "  done. open a new terminal to load zsh."
echo ""
echo "  manual steps:"
echo "    ~/.env.local       — fill in CR_PAT if needed"
echo "    ~/.gitconfig.work  — add your work email"
