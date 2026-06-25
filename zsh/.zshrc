
# ─── safe-chain ───────────────────────────────────────────────────────────────
source /Users/andreribas/.safe-chain/scripts/init-posix.sh

# ─── env local (tokens and sensitive keys) ────────────────────────────────────
[ -f "$HOME/.env.local" ] && source "$HOME/.env.local"

# ─── path ─────────────────────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$HOME/.codeium/windsurf/bin:$PATH"
export PATH="/opt/pmk/env/global/bin:$PATH"

# ─── completions ──────────────────────────────────────────────────────────────
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
autoload -Uz compinit && compinit

# ─── history ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ─── navigation ───────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# ─── editor ───────────────────────────────────────────────────────────────────
export EDITOR="vim"

# ─── aliases: navigation ──────────────────────────────────────────────────────
alias cdw='cd ~/projects/wayne'
alias cdp='cd ~/projects/pay'
alias cde='cd ~/projects/everest'
alias cdh='cd ~/projects/houston'

# ─── aliases: listing ─────────────────────────────────────────────────────────
alias la='ls -a'
alias ll='ls -lahF'

# ─── aliases: git ─────────────────────────────────────────────────────────────
alias gs='git status'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'
alias gds='git diff --staged'

# ─── aliases: utilities ───────────────────────────────────────────────────────
alias tree='tree -C'
alias reload='source ~/.zshrc'
alias zshprofile='vim ~/.zshrc && source ~/.zshrc'

# ─── utility functions ────────────────────────────────────────────────────────
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# ─── pay: container helpers ───────────────────────────────────────────────────
PAY_CONTAINER=pay-pay.ebanx.local-1

function pay_status { docker ps | grep $PAY_CONTAINER > /dev/null && echo running || echo stopped; }
function pay_docker_exec { docker exec -it $PAY_CONTAINER $*; }
function pay_docker_check_exec { [[ $(pay_status) == "running" ]] && pay_docker_exec $* || echo "Pay docker is not running."; }

alias pay_sh="pay_docker_check_exec bash"
alias pay_console="pay_docker_check_exec bin/payconsole.sh"

# ─── starship ─────────────────────────────────────────────────────────────────
eval "$(starship init zsh)"
