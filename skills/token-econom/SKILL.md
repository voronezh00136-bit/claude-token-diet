---
name: token-econom
description: Hard token-budget operating mode. Auto-invoke on any multi-step or tool-using task; enforces cheapest-path execution so total spend drops 3-10x. Not needed for one-line answers.
---

# Token Econom — cheapest path that still ships

Goal: same result, fraction of the tokens. Every step must justify its context cost.

## 1. Triage before any tool call
- **S** (answerable from knowledge/context already loaded) → answer directly, ZERO tool calls.
- **M** (needs 1-3 targeted reads/greps) → do exactly those, no exploration.
- **L** (real project work) → 30-second plan first: list the minimum set of files/commands, then execute only that list.

## 2. Cheap-first ladder (never skip down)
script/CLI output → grep -n → digest → targeted Read (offset+limit) → full Read → ONE subagent. Full-file reads of >200-line files are a last resort; whole-directory reading is forbidden.

## 3. Digest instead of read
For any code file >100 lines, run `scripts/digest.sh <file>` first — returns line count + numbered signatures (~5% of full-read cost). Then Read only the line ranges you actually need.

## 4. Images are contraband
No screenshots/zoom/PDF-page renders unless it is the ONLY way or the user asked for visual proof. Desktop automation via AppleScript/CLI. PDFs via `markitdown` → grep the .md. One image ≈ 1.5-2k tokens re-sent EVERY following turn.

## 5. Output diet
- Edits as diffs/Edit-tool patches, never rewrite whole files that mostly stay the same.
- Never quote back code the user already has; reference `file:line`.
- Answers: verdict first, ≤10 lines unless asked to expand. No recap, no options-you-won't-take.

## 6. Verification budget
Verify once, with the cheapest signal (exit code, one grep, one curl). A tool result that already confirms success needs NO re-check. Tests: run the ONE relevant test, not the suite.

## 7. Context hygiene (say it out loud)
- Task changed → tell the user: "это новая задача — дешевле в новом чате".
- Context bloated (old dumps/images) → suggest `/compact` now, at a moment YOU pick.
- Model overkill for the task → say "это уровень Sonnet/Haiku, переключи /model" before doing heavy work.

## 8. Batch everything
Independent tool calls in ONE block. Questions to the user collected into ONE message. Repeated shell steps into ONE compound command.

## Kill-switch
If the user says "не экономь" / quality clearly suffers — drop the mode for that task and say so.
