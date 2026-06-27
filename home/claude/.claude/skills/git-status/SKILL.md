---
description: Visual and friendly git status — shows branch state, staged/unstaged/untracked files with a one-line summary of each change. Use when the user asks about git status, what changed, or wants an overview of the working tree.
disable-model-invocation: true
---

## Current git state

Branch and tracking:
!`git status -sb 2>/dev/null`

Working tree changes:
!`git status --short 2>/dev/null`

Diff summary per file:
!`git diff --stat HEAD 2>/dev/null`

Recent commits:
!`git log --oneline -5 2>/dev/null`

## Instructions

Present the above data as a clean, readable overview in the language of the conversation:

1. **Branch line** — show current branch and whether it's ahead/behind remote.

2. **File list** — group files into three sections: Staged, Modified, and Untracked. For each file, add a one-line note describing *what kind of change* it is (e.g. new feature, config tweak, bug fix, refactor) based on the filename, path, and diff stat context. If the diff gives no clue, omit the note.

3. **Summary** — one sentence on the overall state of the working tree (e.g. "Nothing staged yet", "Ready to commit", "Partially staged").

Use simple visual markers for file status:
- `+` added/staged new file
- `~` modified
- `-` deleted
- `?` untracked

Keep it tight — this is a glance view, not a narrative.
