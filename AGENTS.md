# AGENTS.md

Guide for AI agents working in this repository.

## What this project is

Personal dotfiles of Andre Ribas, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each tool is an isolated package. `setup.sh` automates the full installation on a new machine.

Usage context: macOS (Apple Silicon), work environment at EBANX and personal use.

## Structure

```
dotfiles/
├── home/                   # stow packages — everything here is symlinked into $HOME
│   ├── git/
│   │   └── .gitconfig          # aliases and git identity
│   ├── starship/
│   │   └── .config/
│   │       └── starship.toml   # prompt configuration
│   ├── zsh/
│   │   └── .zshrc              # main shell configuration
│   └── claude/
│       └── .claude/
│           ├── statusline.sh       # Claude Code statusline script
│           └── skills/
│               ├── wrap-up/        # /wrap-up  — session close checklist
│               ├── git-status/     # /git-status — visual working tree overview
│               └── git-log/        # /git-log  — visual commit history
├── env/
│   └── .env.local.sample   # template for sensitive variables
├── setup.sh                # installation script
├── README.md               # documentation for humans
└── AGENTS.md               # this file
```

`home/` contains all stow packages. Stow mirrors their structure into `$HOME` — so `home/zsh/.zshrc` becomes `~/.zshrc`. `setup.sh` auto-detects every subdirectory inside `home/` as a package; no manual registration is needed when adding a new tool.

## Decisions already made

Do not question or suggest reverting these decisions without an explicit request:

- **zsh** as the main shell — migrated from bash, familiar compatibility
- **starship** as the prompt — conscious choice against oh-my-zsh (heavy, excessive hype)
- **stow** for symlinks — automates the link between repo and `$HOME`
- **ghostty** as the terminal
- **zellij** as the multiplexer
- **safe-chain** wrapping npm/python — security against malicious packages, always keep
- **no oh-my-zsh, no shell frameworks** — unnecessary complexity
- **single `.gitconfig`** — personal email by default, work via `includeIf` by remote
- **`.gitconfig.work` not versioned** — contains corporate email, created by `setup.sh`
- **`.env.local` not versioned** — tokens and secrets, never commit

## Conventions

### Language

This repository's language is **English**. All documentation, comments, and commit messages must be written in English.

### Adding new aliases or functions to `.zshrc`

- Place aliases inside the correct thematic section (navigation, git, utilities)
- If no suitable section exists, create one with the pattern `# ─── name ──────`
- Functions go below aliases, grouped by context
- No obvious comments — only comment what is not self-explanatory

### Adding new Claude Code skills

- Skills live under `home/claude/.claude/skills/<skill-name>/SKILL.md`
- After creating the file, run `stow -d home -t ~ claude` to symlink it into `~/.claude/skills/`
- Update the structure tree in both `AGENTS.md` and `README.md`
- Available immediately via `/<skill-name>` in any Claude Code session (live reload)

### Adding new tools

- If the tool has its own config file, create `home/<tool>/` mirroring the path it occupies under `$HOME` — `setup.sh` picks it up automatically, no registration needed
- Add the installation to `setup.sh` in the dependencies section
- Create a dedicated section in `TOOLS.md` with site, description, useful commands, and relevant shortcuts
- Add the tool to the table in `README.md` with the link pointing to the section in `TOOLS.md` (e.g. `[name](TOOLS.md#name)`) — never to the external site

### Secrets and environment variables

- Any token, key, or credential goes in `~/.env.local` — never in the repo
- Document the variable identifier in `env/.env.local.sample` with a usage comment
- Add to `.gitignore` any local file that may contain secrets

### Commits

- Messages in English, short and descriptive
- One commit per logical change — do not group refactor with feature

## What not to do

- Do not install oh-my-zsh or any shell framework
- Do not add unnecessary zsh plugins — prefer native solutions
- Do not commit files with secrets (`.env.local`, `.gitconfig.work`, `*.bak`)
- Do not add complexity without being asked — less is more
- Do not create documentation files beyond the existing ones without an explicit request
- Do not suggest migrating from bash to fish — zsh is the definitive choice

## Roadmap

- [ ] Linux support in `setup.sh` (OS detection, `apt` as fallback)
- [ ] `vim` package with a basic `.vimrc`
- [ ] Consider `fd`, `bat`, `ripgrep` as modern alternatives to `find`, `cat`, `grep`
- [ ] ghostty configuration versioned as a stow package
- [ ] zellij configuration versioned as a stow package
