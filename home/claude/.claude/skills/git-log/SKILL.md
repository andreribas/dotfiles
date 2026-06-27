---
description: Visual and friendly git log — shows recent commits with context. Use when the user wants to see commit history or what was done recently.
disable-model-invocation: true
---

## Git log

!`git log --oneline --graph --decorate -20 2>/dev/null`

## Commit details (last 10)

!`git log --pretty=format:"%h %as %s" -10 2>/dev/null`

## Instructions

Present the commit history as a clean, readable overview in the language of the conversation:

1. **Branch/graph line** — show current branch and any visible merge/branch structure from the graph.

2. **Commit list** — for each commit show: hash, date, and message. Group by day if there are multiple commits on the same date. Add a one-line note on what the commit likely changed based on the message (e.g. "nova feature", "fix de bug", "refactor", "config"). Skip the note if the message is already self-explanatory.

3. **Summary** — one sentence on the cadence or nature of recent work (e.g. "5 commits today, mostly configuration", "active week with mixed feature and fix work").

Keep it tight — this is a glance view, not a narrative.
