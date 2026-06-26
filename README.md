# dotfiles

Personal configurations managed with [stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/andreribas/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
./setup.sh
```

The script installs homebrew (if needed), dependencies, creates the symlinks, and changes the default shell to zsh.

## What gets installed

| Tool | Type | Description |
|---|---|---|
| [zsh](TOOLS.md#zsh) | shell | Main shell. bash-compatible, better autocompletion. |
| [starship](TOOLS.md#starship) | prompt | Fast and configurable prompt. Automatically shows path, git status, and project stack. |
| [stow](TOOLS.md#stow) | dotfiles | Manages dotfile symlinks. `stow <package>` to activate, `stow -D <package>` to remove. |
| [ghostty](TOOLS.md#ghostty) | terminal | Native, GPU-accelerated terminal. Fast and no-nonsense. |
| [zellij](TOOLS.md#zellij) | multiplexer | Splits the terminal into panes and keeps sessions alive. Modern alternative to tmux. |
| [tree](TOOLS.md#tree) | utility | Lists directories in tree format. |

For detailed guides, shortcuts, and useful commands for each tool, see [TOOLS.md](TOOLS.md).

## Structure

```
dotfiles/
├── home/                   # stow packages — symlinked into $HOME on setup
│   ├── git/
│   │   └── .gitconfig          # aliases, personal identity, remote-based override
│   ├── starship/
│   │   └── .config/
│   │       └── starship.toml   # prompt: path, git, stack (Node/Python/Ruby)
│   ├── zsh/
│   │   └── .zshrc              # PATH, history, aliases, utility functions
│   └── claude/
│       └── .claude/
│           └── statusline.sh   # Claude Code statusline script
└── env/
    └── .env.local.sample   # template for tokens and instructions
```

To add a new tool's config, create `home/<tool>/` following the same structure. `setup.sh` picks it up automatically.

## Local files (not versioned)

After setup, create the files below according to the machine. `setup.sh` creates empty versions automatically.

### `~/.gitconfig.work`

Email used automatically in repos with the `github.com/ebanx` remote:

```ini
[user]
    email = your-work-email@company.com
```

### `~/.env.local`

Tokens and sensitive variables. Base it on `env/.env.local.sample`.
