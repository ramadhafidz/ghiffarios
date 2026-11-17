# GhiffariOS — Project Instructions

## 1. Project Identity

GhiffariOS is a declarative, reproducible NixOS configuration project.

Primary goals:
- Maintain a clean and understandable NixOS configuration.
- Keep system configuration reproducible through Nix flakes.
- Separate machine-specific configuration from reusable modules.
- Manage user environment declaratively with Home Manager.
- Keep hardware configuration explicit and maintainable.
- Document architectural decisions and meaningful changes.

This repository is the source of truth for GhiffariOS configuration.

## 2. Agent Operating Principles

All agents working in this repository must:

1. Read this file before starting work.
2. Read the relevant skill in `.omp/skills/` before modifying related areas.
3. Inspect the current repository structure and existing implementation.
4. Prefer small, focused, reversible changes.
5. Follow existing project conventions unless there is a documented reason to improve them.
6. Explain proposed changes and their impact.
7. Report files changed, checks performed, and remaining concerns.
8. Never assume a configuration is active merely because it exists in the repository.

## 3. Repository Architecture

Follow these architectural boundaries:

- `flake.nix`: project inputs, outputs, and host registration.
- `flake.lock`: pinned dependency versions.
- `hosts/`: machine-specific NixOS configuration.
- `modules/nixos/`: reusable system-level modules.
- `home/`: Home Manager user configuration.
- `README.md`: project overview, setup, and documentation.

Host-specific hardware configuration belongs under the relevant host directory.

See `.omp/skills/ghiffarios-architecture/SKILL.md` for details.

## 4. NixOS Development Rules

- Prefer declarative Nix configuration.
- Prefer reusable modules for functionality shared across hosts.
- Keep host-specific settings inside the relevant host.
- Avoid unnecessary duplication.
- Preserve the existing flake architecture.
- Do not introduce new dependencies without explaining their purpose.
- Never modify `flake.lock` casually.
- Do not use imperative system modifications when a declarative solution is appropriate.

See `.omp/skills/nixos-module-management/SKILL.md`.

## 5. Hardware Management

- Treat hardware configuration as machine-specific.
- Inspect existing hardware settings before changing GPU, kernel, boot, or driver configuration.
- Preserve hardware-specific fallbacks and specialisations.
- Never replace generated hardware configuration without inspecting its contents.
- Preserve `hosts/ghiffari-workstation/hardware-configuration.nix.local`.
- Do not overwrite, delete, rename, or stage that local file.

See `.omp/skills/hardware-management/SKILL.md`.

## 6. Home Manager

- Keep user-level applications and preferences in Home Manager.
- Avoid placing user-only configuration in NixOS system modules.
- Keep reusable Home Manager modules organized by responsibility.
- Do not assume every application belongs in the system package list.

See `.omp/skills/app-installation/SKILL.md`.

## 7. Git Workflow

- Inspect `git status` before editing.
- Review diffs after editing.
- Stage only explicitly intended files.
- Never use `git add -A` or `git add .`.
- Never commit, push, or publish without explicit approval.
- Preserve unrelated user changes.
- Never discard uncommitted work.

See `.omp/RULES.md` and the global git-workflow skill.

## 8. Safety and Approval Boundaries

The following actions always require explicit user approval:

- `nixos-rebuild switch`
- `home-manager switch`
- Rebooting or shutting down the machine.
- Nix garbage collection or store cleanup.
- Formatting, repartitioning, or deleting storage.
- Destructive file operations.
- Changing bootloader, kernel, GPU driver, or critical security configuration.
- Committing, pushing, or deploying changes.
- Modifying credentials, secrets, or authentication configuration.

Agents may inspect files, propose changes, edit project files, and run non-destructive validation.

Never expose API keys, passwords, tokens, or other credentials in logs, diffs, documentation, or generated Nix files.

See `.omp/RULES.md` and `.omp/skills/system-validation/SKILL.md`.

## 9. Validation

Before declaring a change complete:

1. Inspect the final diff.
2. Run relevant non-destructive checks when available.
3. Validate Nix syntax and module evaluation where practical.
4. Report checks that could not be performed.
5. Do not activate configuration without explicit approval.

A successful syntax check does not guarantee a successful system activation.

## 10. Agent Collaboration

Use the global OMP agents and skills when appropriate.

Project-specific responsibilities:

- Architect: repository structure and architectural decisions.
- Developer: implementation and refactoring.
- DevOps: tooling, automation, and operational workflows.
- NixOS Specialist: NixOS, flakes, modules, hardware, and Home Manager.
- Reviewer: correctness, maintainability, safety, and regression review.

Agents must respect the same approval boundaries. Delegation does not grant additional permissions.

## 11. Documentation

Update documentation when changes affect:

- Repository architecture.
- Host configuration.
- Module responsibilities.
- Installation or maintenance procedures.
- Important operational decisions.

Keep documentation concise, accurate, and consistent with the actual implementation.
