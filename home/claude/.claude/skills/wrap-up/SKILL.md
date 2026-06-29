---
description: Session close checklist — reviews open topics, delivery & docs, information capture, future plans, and cleanliness/git. Verifies against the real project state, not just the conversation. Use when the user wants to wrap up or close the session.
disable-model-invocation: true
---

Review this session before closing. Work through each checkpoint, **verify against the actual project state rather than assuming**, and report each with a clear status (done / attention needed). Be direct and brief.

If the project documents its own session-close or change-archival procedure (e.g. an "on completing a change" section in `AGENTS.md`/`CONTRIBUTING.md`), follow that procedure in addition to the checks below.

1. **Open topics** — scan the conversation for questions, issues, or requests that were raised but not resolved. List any still open; confirm if all are done.

2. **Delivery & documentation** — confirm the core task is complete and functional; if not, describe what is missing. Then reconcile the docs against the real state — don't trust them at face value:
   - Identify what was actually delivered this session and ensure each delivery is reflected in the project's docs: CHANGELOG (entry), ROADMAP (status / ✅), and any "current state" doc (e.g. `AGENTS.md`). Scan the doc files the repo actually has (`AGENTS.md`, `README.md`, `TOOLS.md`, `CHANGELOG.md`, `ROADMAP.md`, other root `.md`s) rather than assuming a fixed set.
   - Cross-check for drift: does everything the CHANGELOG/ROADMAP marks delivered actually exist as done (and vice-versa)? If the project uses a planning/spec workflow, is every delivered unit archived — no completed-but-unarchived work, no stale or duplicate plans? Listing the active-work directory and `git log` helps.
   - Spot-check facts that rot: file paths/names, counts (tests, endpoints), and "next/upcoming" lists that may already be done.
   - New tools, skills, conventions, or structural changes must be documented. **Fix what is out of sync now** — only leave it as a flag if it genuinely needs the user's decision.

3. **Capture what would otherwise be lost** — the goal: nothing discussed, discovered, decided, or done should survive only in this conversation. Sweep for:
   - Decisions **and their rationale**; alternatives considered and **why they were rejected**.
   - Discoveries — bugs, gotchas, constraints, surprising findings, non-obvious context.
   - Corrections or preferences the user expressed about how to work.
   For each, decide its home — the repo's durable record (docs/design notes) when it belongs to the project, or the auto-memory system for cross-session context not derivable from the repo — and record it there now. Don't duplicate what a repo doc already captures.

4. **Future plans** — follow-up actions, TODOs, deferred decisions. Confirm each is captured somewhere durable (a repo doc or memory) or explicitly handed off to the user — never left implicit in the chat.

5. **Cleanliness & git** — leave the project in the cleanest state possible:
   - Run `git status`. List uncommitted changes and ask the user whether to commit. Watch for stray scratch/temp files that should not be committed; for deliberately-untracked items, call them out as intentional.
   - If there are local commits not yet pushed, ask whether to push.
   - No half-applied changes, broken intermediate states, or orphaned artifacts left behind.

If every checkpoint is clear, end with a short, natural closing message in the language of the conversation telling the user everything is in order and they can safely close the session. Keep it natural, not formulaic.

If any checkpoint needs attention, skip the closing message and list only the items that need action.
