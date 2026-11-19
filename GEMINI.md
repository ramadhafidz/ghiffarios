# GhiffariOS — Agent Instructions (Antigravity)

The root `AGENTS.md` is the source of truth for project identity, architecture,
and approval boundaries. This file provides Antigravity-specific operating notes.

## Read first
1. `AGENTS.md` (repository root)
2. Relevant rule files in `.agents/rules/RULES.md`
3. Relevant skill in `.agents/skills/` before touching its area

## Agents
Custom subagents live in `.agents/agents/`:
- `nix-architect` — repository structure and module design
- `nix-implementer` — writing and refactoring Nix configuration
- `desktop-specialist` — KDE Plasma and desktop environment configuration
- `app-integrator` — adding applications at the correct scope
- `reviewer` — correctness, safety, and regression review

## Skills
Project skills live in `.agents/skills/<name>/SKILL.md`. Read the matching skill
before modifying that area; they encode validated project conventions:
- `ghiffarios-architecture` — Repository layering, module boundaries, and where configuration belongs
- `nixos-module-management` — Conventions for writing NixOS modules, flakes, packages, and secrets
- `app-installation` — How to add applications at the correct scope (system vs user level)
- `kde-ricing` — KDE Plasma theming, appearance, and desktop customization conventions
- `hardware-management` — Rules for host hardware configuration, GPU, boot, and kernel settings
- `system-validation` — Non-activating validation and activation boundaries for NixOS changes
