# GhiffariOS — Agent Instructions (omp)

The root `AGENTS.md` is the source of truth for project identity, architecture,
and approval boundaries. This file only adds omp-specific operating notes.

## Read first
1. `AGENTS.md` (repository root)
2. Relevant rule files in `.omp/RULES.md`
3. Relevant skill in `.omp/skills/` before touching its area

## Agents
Custom agents live in `.omp/agents/`:
- `nix-architect` — repository structure and module design
- `nix-implementer` — writing and refactoring Nix configuration
- `desktop-specialist` — KDE Plasma and desktop environment configuration
- `app-integrator` — adding applications at the correct scope
- `reviewer` — correctness, safety, and regression review

## Skills
Project skills live in `.omp/skills/<name>/SKILL.md`. Read the matching skill
before modifying that area; they encode validated project conventions.
