# Tools

Guia de referência para cada ferramenta instalada pelo `setup.sh`.

---

## zsh

**Site:** https://www.zsh.org/  
**Tipo:** shell

Shell principal. Compatível com bash — scripts e hábitos transferem direto. Melhor autocompletion nativo e ecossistema de plugins sem precisar de frameworks pesados.

**Comandos úteis**

```bash
reload           # recarrega o .zshrc (alias definido no dotfiles)
zshprofile       # abre o .zshrc no vim e recarrega ao sair
```

---

## starship

**Site:** https://starship.rs/  
**Tipo:** prompt  
**Config:** `~/.config/starship.toml` (gerenciado pelo stow)

Prompt minimalista e rápido. Detecta automaticamente o contexto do diretório atual e exibe informações relevantes.

O que aparece no prompt:
- Path atual (truncado a 4 níveis, raiz do repo quando dentro de um)
- Branch e status git (modificados, staged, ahead/behind)
- Versão de Node, Python ou Ruby quando detectados no projeto

**Comandos úteis**

```bash
starship explain    # mostra o que cada parte do prompt atual representa
starship preset     # lista presets disponíveis
```

---

## stow

**Site:** https://www.gnu.org/software/stow/  
**Tipo:** gerenciador de symlinks

Cria symlinks de cada pacote para `$HOME`, espelhando a estrutura de diretórios. Permite versionar dotfiles sem mover os arquivos do lugar esperado pelo sistema.

**Comandos úteis**

```bash
# a partir de ~/projects/dotfiles
stow zsh                        # ativa o pacote zsh (cria ~/.zshrc)
stow -D zsh                     # remove os symlinks do pacote zsh
stow --restow zsh               # recria os symlinks (útil após mudanças)
stow zsh git starship           # ativa múltiplos pacotes de uma vez
```

**Adicionando um novo pacote**

1. Crie o diretório com o nome do pacote: `mkdir meu-pacote`
2. Adicione os arquivos espelhando a estrutura a partir de `$HOME`
   - Ex: config em `~/.config/foo/bar.toml` → `meu-pacote/.config/foo/bar.toml`
3. Rode `stow meu-pacote`
4. Adicione ao `setup.sh`

---

## ghostty

**Site:** https://ghostty.org/  
**Tipo:** terminal

Terminal nativo para macOS, GPU-accelerated. Inicialização rápida, suporte a true color, ligatures e multiplexers. Sem Electron, sem frescura.

**Atalhos úteis**

| Atalho | Ação |
|---|---|
| `Cmd t` | Nova aba |
| `Cmd n` | Nova janela |
| `Cmd d` | Dividir painel verticalmente |
| `Cmd Shift d` | Dividir painel horizontalmente |
| `Cmd [` / `Cmd ]` | Navegar entre painéis |
| `Cmd ,` | Abrir configurações |

---

## zellij

**Site:** https://zellij.dev/  
**Tipo:** multiplexer de terminal

Divide o terminal em painéis e abas, mantendo sessões vivas mesmo após fechar o terminal. Alternativa moderna ao tmux — atalhos visíveis na barra inferior, sem necessidade de decorar configurações.

Inicie com `zellij`. O modo atual e os atalhos disponíveis aparecem sempre na tela.

**Painéis**

| Atalho | Ação |
|---|---|
| `Ctrl p` → `n` | Novo painel |
| `Ctrl p` → `d` | Dividir para baixo |
| `Ctrl p` → `r` | Dividir para a direita |
| `Ctrl p` → `x` | Fechar painel |
| `Ctrl p` → setas | Navegar entre painéis |
| `Ctrl p` → `z` | Maximizar/restaurar painel atual |
| `Ctrl p` → `w` | Modo floating (painel flutuante) |

**Abas**

| Atalho | Ação |
|---|---|
| `Ctrl t` → `n` | Nova aba |
| `Ctrl t` → `x` | Fechar aba |
| `Ctrl t` → setas | Navegar entre abas |
| `Ctrl t` → `r` | Renomear aba |

**Sessões**

| Atalho | Ação |
|---|---|
| `Ctrl o` → `d` | Desanexar (sessão continua em background) |
| `zellij attach` | Reconectar à sessão mais recente |
| `zellij list-sessions` | Listar sessões ativas |
| `zellij kill-session <nome>` | Encerrar uma sessão |

**Sair:** `Ctrl q`

---

## tree

**Tipo:** utilitário  

Lista diretórios em formato de árvore. Instalado via homebrew.

**Comandos úteis**

```bash
tree                  # lista o diretório atual
tree -L 2             # limita a 2 níveis de profundidade
tree -a               # inclui arquivos ocultos
tree -I node_modules  # ignora um diretório
```
