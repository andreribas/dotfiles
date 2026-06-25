#!/bin/bash
set -e

echo "==> dotfiles setup"

# ─── homebrew ─────────────────────────────────────────────────────────────────
BREW_BIN="/opt/homebrew/bin/brew"  # Apple Silicon; Intel usa /usr/local/bin/brew
[ -f "/usr/local/bin/brew" ] && BREW_BIN="/usr/local/bin/brew"

if [ ! -f "$BREW_BIN" ]; then
  echo "==> installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$($BREW_BIN shellenv)"

# ─── dependências ─────────────────────────────────────────────────────────────
echo "==> installing dependencies"
brew install zsh stow starship tree zellij
brew install --cask ghostty

# ─── symlinks via stow ────────────────────────────────────────────────────────
echo "==> linking dotfiles"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
stow --dir="$DOTFILES_DIR" --target="$HOME" zsh git starship

# ─── shell padrão ─────────────────────────────────────────────────────────────
ZSH_PATH="$(brew --prefix)/bin/zsh"
if ! grep -q "$ZSH_PATH" /etc/shells; then
  echo "==> adding $ZSH_PATH to /etc/shells (requer sudo)"
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "==> changing default shell to zsh"
  chsh -s "$ZSH_PATH"
fi

# ─── arquivos locais ──────────────────────────────────────────────────────────
if [ ! -f "$HOME/.env.local" ]; then
  cp "$DOTFILES_DIR/env/.env.local.sample" "$HOME/.env.local"
  echo "==> criado ~/.env.local — preencha os tokens necessários"
fi

if [ ! -f "$HOME/.gitconfig.work" ]; then
  cat > "$HOME/.gitconfig.work" <<'EOF'
[user]
	email =
EOF
  echo "==> criado ~/.gitconfig.work — adicione seu email de trabalho"
fi

echo ""
echo "  done. abra um novo terminal para carregar o zsh."
echo ""
echo "  pendências manuais:"
echo "    ~/.env.local       — preencha CR_PAT se necessário"
echo "    ~/.gitconfig.work  — adicione seu email de trabalho"
