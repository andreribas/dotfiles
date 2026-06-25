# dotfiles

Configurações pessoais gerenciadas com [stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/andreribas/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
./setup.sh
```

O script instala homebrew (se necessário), dependências, cria os symlinks e troca o shell padrão para zsh.

## Estrutura

```
dotfiles/
├── env/
│   └── .env.local.sample   # template de tokens e instruções
├── git/
│   └── .gitconfig          # aliases, identidade pessoal, override por remote
├── starship/
│   └── .config/
│       └── starship.toml   # prompt: path, git, stack (Node/Python/Ruby)
└── zsh/
    └── .zshrc              # PATH, history, aliases, funções utilitárias
```

## Arquivos locais (não versionados)

Após o setup, crie os arquivos abaixo conforme a máquina. O `setup.sh` cria versões vazias automaticamente.

### `~/.gitconfig.work`

Email usado automaticamente em repos com remote `github.com/ebanx`:

```ini
[user]
    email = seu-email@trabalho.com
```

### `~/.env.local`

Tokens e variáveis sensíveis. Baseie-se em `env/.env.local.sample`.
