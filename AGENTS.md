# AGENTS.md

Guia para agentes de IA trabalhando neste repositório.

## O que é este projeto

Dotfiles pessoais do Andre Ribas, gerenciados com [GNU Stow](https://www.gnu.org/software/stow/).
Cada ferramenta é um pacote isolado. O `setup.sh` automatiza a instalação completa em uma nova máquina.

Contexto de uso: macOS (Apple Silicon), ambiente de trabalho na EBANX e uso pessoal.

## Estrutura

```
dotfiles/
├── env/
│   └── .env.local.sample   # template de variáveis sensíveis
├── git/
│   └── .gitconfig          # aliases e identidade git
├── starship/
│   └── .config/
│       └── starship.toml   # configuração do prompt
├── zsh/
│   └── .zshrc              # configuração principal do shell
├── setup.sh                # script de instalação
├── README.md               # documentação para humanos
└── AGENTS.md               # este arquivo
```

Cada diretório de primeiro nível (exceto `env/`) é um pacote stow. O stow espelha a estrutura a partir de `$HOME` — então `zsh/.zshrc` vira `~/.zshrc`.

## Decisões já tomadas

Não questione ou sugira reverter estas decisões sem pedido explícito:

- **zsh** como shell principal — migração do bash, compatibilidade familiar
- **starship** como prompt — escolha consciente contra oh-my-zsh (pesado, hype excessivo)
- **stow** para symlinks — automatiza o vínculo entre repo e `$HOME`
- **ghostty** como terminal
- **zellij** como multiplexer
- **safe-chain** wrappando npm/python — segurança contra pacotes maliciosos, manter sempre
- **sem oh-my-zsh, sem frameworks de shell** — complexidade desnecessária
- **`.gitconfig` único** — email pessoal por padrão, trabalho via `includeIf` por remote
- **`.gitconfig.work` não versionado** — contém email corporativo, criado pelo `setup.sh`
- **`.env.local` não versionado** — tokens e segredos, nunca commitar

## Convenções

### Adicionando novos aliases ou funções ao `.zshrc`

- Coloque aliases dentro da seção temática correta (navegação, git, utilitários)
- Se não existir seção adequada, crie uma com o padrão `# ─── nome ──────`
- Funções ficam abaixo dos aliases, agrupadas por contexto
- Sem comentários óbvios — só comente o que não é autoexplicativo

### Adicionando novas ferramentas

- Se a ferramenta tem arquivo de config próprio, crie um novo pacote stow
- Adicione a instalação no `setup.sh` na seção de dependências
- Documente na tabela de ferramentas do `README.md` com descrição e dica de uso
- Se tiver muitos atalhos ou curva de aprendizado, adicione referência rápida no `README.md`

### Segredos e variáveis de ambiente

- Qualquer token, chave ou credencial vai em `~/.env.local` — nunca no repo
- Documente o identificador da variável em `env/.env.local.sample` com comentário de uso
- Adicione ao `.gitignore` qualquer arquivo local que possa conter segredos

### Commits

- Mensagens em inglês, curtas e descritivas
- Um commit por mudança lógica — não agrupar refactor com feature

## O que não fazer

- Não instalar oh-my-zsh ou qualquer framework de shell
- Não adicionar plugins de zsh desnecessários — preferir soluções nativas
- Não commitar arquivos com segredos (`.env.local`, `.gitconfig.work`, `*.bak`)
- Não adicionar complexidade sem pedido — menos é mais
- Não criar arquivos de documentação além dos já existentes sem pedido explícito
- Não sugerir migrar de bash para fish — zsh é a escolha definitiva

## Roadmap

- [ ] Suporte a Linux no `setup.sh` (detecção de OS, `apt` como fallback)
- [ ] Pacote `vim` com `.vimrc` básico
- [ ] Considerar `fd`, `bat`, `ripgrep` como alternativas modernas a `find`, `cat`, `grep`
- [ ] Configuração do ghostty versionada como pacote stow
- [ ] Configuração do zellij versionada como pacote stow
