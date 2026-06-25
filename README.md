# dotfiles

Configurações pessoais gerenciadas com [stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/andreribas/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
./setup.sh
```

O script instala homebrew (se necessário), dependências, cria os symlinks e troca o shell padrão para zsh.

## O que é instalado

| Ferramenta | Tipo | Descrição |
|---|---|---|
| [zsh](TOOLS.md#zsh) | shell | Shell principal. Compatível com bash, melhor autocompletion. |
| [starship](TOOLS.md#starship) | prompt | Prompt rápido e configurável. Mostra path, git e stack do projeto automaticamente. |
| [stow](TOOLS.md#stow) | dotfiles | Gerencia symlinks dos dotfiles. `stow <pacote>` para ativar, `stow -D <pacote>` para remover. |
| [ghostty](TOOLS.md#ghostty) | terminal | Terminal nativo, GPU-accelerated. Rápido e sem frescura. |
| [zellij](TOOLS.md#zellij) | multiplexer | Divide o terminal em painéis e mantém sessões vivas. Alternativa moderna ao tmux. |
| [tree](TOOLS.md#tree) | utilitário | Lista diretórios em formato de árvore. |

Para guias detalhados, atalhos e comandos úteis de cada ferramenta, veja [TOOLS.md](TOOLS.md).

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
